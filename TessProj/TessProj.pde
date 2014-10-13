import g4p_controls.*;

import javax.swing.*;

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

//Graphics & shader management
PGraphics src;
GlowManager postProduction;

//Light points and blocks
ArrayList<lightPoint> lightPoints;
ArrayList<lightBlock> lightBlocks;

//Tesseract constants
PVector[] vertices;
LED[] LEDs;

float outerSize;
float innerSize;

//Setup timer
int savedTime;
int savedLocTime;

//Animation globals
int whirlwindStep;
float minLight = 0;
lightBlock[] climbOnBlocks;

//Control switches
boolean debugOn;
boolean solidOn;
boolean fullOn;
boolean climbing;
boolean lineInOn = false;
int lightAnim;
int locAnim;

//Audio setup
Minim minim;
AudioPlayer player;
AudioInput lineIn;
BeatDetect beat;
FFT fft;

void setup()
{
  locAnim = 0;
  frame.setTitle("Tesseract Projection");

  //Basic setup
  frameRate(30);
  size(displayWidth, displayHeight, OPENGL);
  smooth(8);
  
  //Setup vertices
  defineVertices();
  
  //LED Array Setup
  LEDs = new LED[4600];
  
  //Setup light arrays
  lightPoints = new ArrayList<lightPoint>();
  lightBlocks = new ArrayList<lightBlock>();
  
  //Generate actual tesseract
  generateTesseract();
  
  //color Tesseract
  colorSolid(255, 255, 255);

  //Setup src and post Production
  src = createGraphics(width, height, P3D);
  postProduction = new GlowManager();
  postProduction.initGlow(this, src, 0.2f);
  postProduction.glow.set("BlendMode", 1);
  
  setupMinim(lineInOn); // False - test player, true - 
  
  //Setup timer
  savedTime = millis();
  savedLocTime = millis();
}

void draw()
{
  activateMinim(lineInOn);
  //println(fft.getAvg(1));
  switch(lightAnim)
  {
    case 1:
      fillThenDance();  
      break;
    case 2:
      PopThenDrop();
      break;
    case 3:
      popOnBeat();
      break;
    case 4: 
      evenEqualizerRun();
      break;
    case 5:
      rain(10, 0);
      break;
    case 6:
      novaRun(minLight);
      break;
    case 7:
      whirlwindRun();
      break;
    case 8:
      climbOnRun(climbOnBlocks, climbing);
      if(lightBlocks.size() == 32) climbing = false;
      if(lightBlocks.size() == 0) climbing = true;
      break;
    default:
      break;
  }
  
  switch(locAnim)
  {
    case 1:
      returnToTess(5);
      break;
    default:
      break;
  }
  
  for (int i = 0; i < LEDs.length; i++)
  {
    shadeBlack(LEDs[i]);
    //shadeFullBrightness(LEDs[i]);
    shadeLightPoints(LEDs[i], lightPoints);
    shadeWithinBlocks(LEDs[i], lightBlocks);
    LEDs[i].move();
    //LEDs[i].checkEdges();
  }
  
  drawGeometry(src);
  
  if(debugOn)
  {
    //drawLights(src);
  }
  
  PGraphics graphics = postProduction.dowGlow(src);
  image(graphics, 0, 0);
}

void keyPressed()
{
  switch(key)
  {
    case '1':
      clearLights();
      solidOn = false;
      lightAnim = 1;
      break;
    case '2':
      clearLights();
      solidOn = false;
      lightAnim = 2;
      break;
    case '3':
      clearLights();
      solidOn = false;
      lightAnim = 3;
      break;
    case '4':
      clearLights();
      evenEqualizerSetup();
      solidOn = true;
      lightAnim = 4;
      break;
    case '5':
      clearLights();
      solidOn = false;
      lightAnim = 5;
      break;
    case '6':
      clearLights();
      novaSetup();
      solidOn = false;
      minLight = 0;
      lightAnim = 6;
      break;
    case '7':
      clearLights();
      solidOn = true;
      whirlwindStep = 1000;
      whirlwindSetup();
      lightAnim = 7;
      break;
    case '8':
      clearLights();
      solidOn = true;
      climbOnBlocks = climbOnSetup();
      lightAnim = 8;
      break;
    case 'a':
      returnToTess(5);
      locAnim = 1;
      savedLocTime = millis();
      break;
    case 'f':
      freeze();
      locAnim = 0;
      savedLocTime = millis();
      break;
    case 's':
      explode();
      locAnim = 0;
      savedLocTime = millis();
      break;
    case 'd':
      bendOut();
      locAnim = 0;
      savedLocTime = millis();
      break;
    case 'q':
      colorRainbow();
      break;
    case 'w':
      colorRandomBlackAndWhite();
      break;
    case 'e':
      colorSolid(255, 255, 255);
      break;
    case 'y':
      colorSolid(12, 139, 38);
      break;
    case 'l':
      fullOn = !fullOn;
      break;
    default:
      break;
  }
}

void drawGeometry(PGraphics src)
{
  src.beginDraw();
  src.background(0);
  src.pushMatrix();
  src.translate(width/2, height/2);
  src.rotateY(frameCount * 0.005f);
  src.noStroke();
  for(int i = 0; i < LEDs.length; i++)
  {
    LEDs[i].draw3D(src);
    /*
    src.pushMatrix();
    src.translate(LEDs[i].realLoc.x, LEDs[i].realLoc.y, LEDs[i].realLoc.z); 
    src.stroke(color(255, 0, 0));
    src.line(0, 0, 0, LEDs[i].acc.x * 10, LEDs[i].acc.y * 10, LEDs[i].acc.z * 10);
    src.stroke(color(0, 255, 0));
    src.line(0, 0, 0, LEDs[i].vel.x * 10, LEDs[i].vel.y * 10, LEDs[i].vel.z * 10);
    src.popMatrix();
    */
  }
  src.popMatrix();
  src.endDraw();
}

void drawLights(PGraphics src)
{
  src.beginDraw();
  src.translate(width/2, height/2);
  src.noStroke();
  for(int i = 0; i < lightPoints.size(); i++)
  {
    lightPoints.get(i).display(src);
  }
  for(int i = 0; i < lightBlocks.size(); i++)
  {
    lightBlocks.get(i).display(src);
  }
  src.endDraw();
}

void clearLights()
{
  lightPoints.clear();
  lightBlocks.clear();
}

void clearAnimations()
{
  lightAnim = 0;
}

boolean sketchFullScreen() {
  return true;
}

