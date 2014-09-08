import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

PFont font;
OPC opc;
PImage dot;
//PeasyCam camera;
LED[] LEDs;
LED[] cornerLEDs;
ArrayList<lightPoint> lightPoints;
boolean MapOn;
PVector centerMouse;
Minim minim;

float closestDist;
int closestText;
float closestTextX;
float closestTextY;

float lightX, lightY, lightZ;
float theta;

void setup()
{
  size(1000, 1000, P3D);

  MapOn = true;

  LEDs = new LED[460]; // Initialize Full Tesseract Array (460 = number of LEDs)
  cornerLEDs = new LED[64]; // Initialize array of corners
  lightPoints = new ArrayList<lightPoint>();
  /*
  for(int i = 0; i < LEDs.length; i++)
  {
    PVector nadda = new PVector(0, 0, 0);
    LED newLED = new LED(nadda, nadda);
    LEDs[i] = newLED;
  }
  */

  dot = loadImage("dot.png");
  opc = new OPC(this, "127.0.0.1", 7890);
  
  lightX = -100;
  lightY = -100;
  lightZ = -100;
  theta = 0;

  //generate the Tesseract
  generateTesseract();
  
  //start up minim - for playing music
  minim = new Minim(this);
  
  //Shade Tesseract Initially
  //shadeRainbow();
  shadeSolid(127, 127, 127);
  //shadeCornersRed();
  //shadeRandom();
  //shadeChargeUp();
  //lightPoint light1 = new lightPoint(LEDs[12].realLocation, color(0, 200, 255), 100);
  lightPoint light2 = new lightPoint(LEDs[12].realLocation, color(255, 0, 0), 20);
  lightPoint light3 = new lightPoint(0, 0, 0, color(255, 255, 255), 200);
  //lightPoints.add(light1);
  lightPoints.add(light2);
  lightPoints.add(light3);
  //shadeOnePoint(12, blue);
  
  for(int i = 0; i < LEDs.length; i++)
  {
    opc.led(i, (int)LEDs[i].mapLocation.x, (int)LEDs[i].mapLocation.y);
  }
}

void draw()
{
  background(0);
  //shadeRandomBlackAndWhite();
  //shadeChargeUp();
  shadeLightPoints(lightPoints);
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
    }
  }
  
  lightPoint redDot = lightPoints.get(0);
  redDot.location = 
  
  for(int i = 0; i < lightPoints.size() - 1; i++)
  {
    lightPoints.get(i).display(width*0.75, height*0.75, 0);
  }
  
  /*
  // Change the dot size as a function of time, to make it "throb"
  float dotSize = height * 0.3 * (1.0 + 0.2 * sin(millis() * 0.01));
  
  // Draw it centered at the mouse location
  image(dot, mouseX - dotSize/2, mouseY - dotSize/2, dotSize, dotSize);
  */
}

void keyPressed()
{
  //toggle drawing the 3D map
  MapOn = !MapOn;
}

