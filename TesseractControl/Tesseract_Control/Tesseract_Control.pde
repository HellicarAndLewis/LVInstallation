import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import java.util.Map;

PFont font;
OPC opc;
ArrayList<lightPoint> lightPoints;
boolean mapOn;
boolean randomOn;

int newAnimationCheck;

int shaders;

Minim minim;
AudioPlayer player;
BeatDetect beat;
WaveformRenderer waveform;
BeatListener beatListener;

ArrayList<lightPoint> movingLights;
ArrayList<lightPoint> staticLights;

LED[] LEDs;

float minDistance;
int closestText;
float closestTextX;
float closestTextY;

int savedTime = 0;
int vertexIndex = 0;

boolean shrinkSetupDone;

PVector[] vertices;

void setup()
{
  size(1000, 1000, P3D);
  mapOn = true;
  randomOn = false;
  
  shaders = 0;
  
  vertices = new PVector[16];
  vertices[0] = new PVector(100, 100, 100);
  vertices[1] = new PVector(-100, 100, 100);
  vertices[2] = new PVector(-100, 100, -100);
  vertices[3] = new PVector(100, 100, -100);
  vertices[4] = new PVector(100, -100, 100);
  vertices[5] = new PVector(-100, -100, 100);
  vertices[6] = new PVector(-100, -100, -100);
  vertices[7] = new PVector(100, -100, -100);
  vertices[8] = new PVector(50, 50, 50);
  vertices[9] = new PVector(-50, 50, 50);
  vertices[10] = new PVector(-50, 50, -50);
  vertices[11] = new PVector(50, 50, -50);
  vertices[12] = new PVector(50, -50, 50);
  vertices[13] = new PVector(-50, -50, 50);
  vertices[14] = new PVector(-50, -50, -50);
  vertices[15] = new PVector(50, -50, -50);
  
  waveform = new WaveformRenderer();
  
  minim = new Minim(this);
  
  player = minim.loadFile("LVTrack02.mp3", 512);
  player.addListener(waveform);
  
  LEDs = new LED[460]; // Initialize Full Tesseract Array (460 = number of LEDs)
  lightPoints = new ArrayList<lightPoint>();
  movingLights = new ArrayList<lightPoint>();
  staticLights = new ArrayList<lightPoint>();
  
  opc = new OPC(this, "127.0.0.1", 7890);
  
  boolean shrinkSetupDone = false;
  
  //generate the Tesseract
  generateTesseract();
  setCornerConnections();
  
  //start up minim - for playing music
  minim = new Minim(this);
  beat = new BeatDetect(player.bufferSize(), player.sampleRate());
  
  //Shade Tesseract Initially
  
  colorRainbow();
  /*
  for(int i = 0; i < LEDs.length; i++)
  {
    LED myLED = LEDs[i];
    colorRandomBlackAndWhite(myLED);
  }
  */
  //shadeSolid(127, 127, 127);
  //colorCornersRed();
  //colorRandom();
  //shadeChargeUp();
  //pairOfSpotsSetup(300);
  //redBouncersSetupStaticLights();
  
  setupLEDs();
  
  player.play();
  player.loop();
  
}

void draw()
{
  background(0);
  
  beat.detect(player.mix);
  
  //println(millis() % 1000);
  if(millis() % 10000 < 200)
  {
    newAnimationCheck = int(random(3));
    colorCheck = int(random(
    lightPoints.clear();
    movingLights.clear();
    staticLights.clear();
    println(newAnimationCheck);
  }
  
  switch(newAnimationCheck)
  {
    case 0:
      fillThenDance();  
      break;
    case 1:
      PopThenDrop();
      break;
    case 2:
      popOnBeat();
      break;
  }
  //PopThenDrop();
  //pairOfSpotsRun(200);
  //shadeCornersOnBeat();
  /*
  if(millis() > 11000)
  {
    shrinkToCenterSetup();
  }
  if(staticLights.size() > 0)
  {
    shrinkToCenterRun();
  }
  */
  for(int i = 0; i < LEDs.length; i++)
  {
    LED myLED = LEDs[i];
    //shadeFullBrightness(myLED);
    shadeLightPoints(myLED, lightPoints);
  }
  
  //Draw 3D version all the time
  for (int i = 0; i < LEDs.length; i++)
  {
    LEDs[i].draw3D(width*0.75, height*0.75);
  }
  //Draw 2D map when mapOn is toggled
  if(mapOn)
  {
    for (int i = 0; i < LEDs.length; i++)
    {
      LEDs[i].drawMap(0, 0);
      LEDs[i].stroke = 0;
    }
  }
  
  minDistance = MAX_FLOAT;
  PVector mouseLocation = new PVector(mouseX, mouseY);
  for(int i = 0; i < LEDs.length; i++)
  {
    float dist = dist(mouseLocation.x, mouseLocation.y, LEDs[i].mapLocation.x, LEDs[i].mapLocation.y);
    if(dist < 10 && dist < minDistance)
    {
      minDistance = dist;
      closestText = i;
      closestTextX = mouseLocation.x + 10;
      closestTextY = mouseLocation.y - 10;
    }
  }
  
  if(minDistance < MAX_FLOAT)
  {
    pushMatrix();
    fill(255);
    translate(closestTextX, closestTextY);
    textAlign(CENTER);
    text(closestText, 0, 0);
    popMatrix();
    
    LEDs[closestText].stroke = 255;
    LED myLED = LEDs[closestText];
    LEDs[myLED.nextLEDIndex].stroke = 255;
  }
  /*
  stroke(255);
  for(int i = 0; i < player.bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, player.bufferSize(), width/2, width );
    float x2 = map( i+1, 0, player.bufferSize(), width/2, width );
    line( x1, 50 + player.left.get(i)*50, x2, 50 + player.left.get(i+1)*50 );
    line( x1, 150 + player.right.get(i)*50, x2, 150 + player.right.get(i+1)*50 );
  }
  */
  waveform.display();
  
  for(int i = 0; i < lightPoints.size(); i++)
  {
    //lightPoints.get(i).display(width*0.75, height*0.75, 0);
  }
}

void keyPressed()
{
  //toggle drawing the 2D map
  mapOn = !mapOn;
}

void setupLEDs()
{
  for(int i = 0; i < LEDs.length; i++)
  {
    opc.led(i, (int)LEDs[i].mapLocation.x, (int)LEDs[i].mapLocation.y);
  }
}

