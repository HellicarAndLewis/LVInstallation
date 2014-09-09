import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import java.util.Map;

PFont font;
OPC opc;
PImage dot;
LED[] LEDs;
ArrayList<lightPoint> lightPoints;
boolean MapOn;
PVector centerMouse;

Minim minim;
AudioPlayer player;

float minDistance;
int closestText;
float closestTextX;
float closestTextY;

float xOff = 0.0;

void setup()
{
  size(1000, 1000, P3D);
  //frameRate(10);
  MapOn = true;
  
  minim = new Minim(this);
  
  player = minim.loadFile("testSound.mp3");
  
  
  LEDs = new LED[460]; // Initialize Full Tesseract Array (460 = number of LEDs)
  lightPoints = new ArrayList<lightPoint>();
  
  dot = loadImage("dot.png");
  opc = new OPC(this, "127.0.0.1", 7890);

  //generate the Tesseract
  generateTesseract();
  setCornerConnections();
  
  //start up minim - for playing music
  minim = new Minim(this);
  player = minim.loadFile("testSound.mp3");
  
  //Shade Tesseract Initially
  
  //shadeRainbow();
  //shadeSolid(127, 127, 127);
  //shadeCornersRed();
  //shadeRandom();
  //shadeChargeUp();
  
  //lightPoint light1 = new lightPoint(LEDs[12], color(255, 0, 0), 20);
  //lightPoint light2 = new lightPoint(0, 0, 0, color(255, 255, 255), 200);
  //lightPoints.add(light1);
  //lightPoints.add(light2);
  //shadeOnePoint(12, blue);
  
  for(int i = 0; i < LEDs.length; i++)
  {
    opc.led(i, (int)LEDs[i].mapLocation.x, (int)LEDs[i].mapLocation.y);
  }
  player.play();
  player.loop();
}

void draw()
{
  background(0);
  //shadeRandomBlackAndWhite();
  //shadeChargeUp();
  //shadeLightPoints(lightPoints);
  //shadeNoise(xOff);
  float maxLimit = MIN_FLOAT;
  
  for(int i = 0; i < player.bufferSize() - 1; i++)
  {
    float newLimit = player.left.get(i);
    if(newLimit > maxLimit)
    {
      maxLimit = newLimit;
    }
  }
  maxLimit *= 150;
  shadeBelowY(100 - maxLimit);
  //xOff += 0.05;
  
  //Draw 3D version all the time
  for (int i = 0; i < LEDs.length; i++)
  {
    LEDs[i].draw3D(width*0.75, height*0.75);
  }
  //Draw 2D map when MapOn is toggled
  if(MapOn)
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
  }
}

void keyPressed()
{
  //toggle drawing the 2D map
  MapOn = !MapOn;
}

