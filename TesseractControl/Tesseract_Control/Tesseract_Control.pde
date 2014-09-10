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

int shaders;

Minim minim;
AudioPlayer player;
BeatDetect beat;

ArrayList<lightPoint> movingLights;
ArrayList<lightPoint> staticLights;

LED[] LEDs;

float minDistance;
int closestText;
float closestTextX;
float closestTextY;

int savedTime = 0;
void setup()
{
  size(1000, 1000, P3D);
  mapOn = true;
  randomOn = false;
  
  shaders = 0;
  
  minim = new Minim(this);
  
  player = minim.loadFile("testSound.mp3");
  
  LEDs = new LED[460]; // Initialize Full Tesseract Array (460 = number of LEDs)
  lightPoints = new ArrayList<lightPoint>();
  movingLights = new ArrayList<lightPoint>();
  staticLights = new ArrayList<lightPoint>();
  
  opc = new OPC(this, "127.0.0.1", 7890);

  //generate the Tesseract
  generateTesseract();
  setCornerConnections();
  
  //start up minim - for playing music
  minim = new Minim(this);
  player = minim.loadFile("LVSong01.mp3");
  beat = new BeatDetect();
  
  //Shade Tesseract Initially
  
  colorRainbow();
  //shadeSolid(127, 127, 127);
  //shadeCornersRed();
  //shadeRandom();
  //shadeChargeUp();
  pairOfSpotsSetup(300);
  //redBouncersSetupStaticLights();
  
  setupLEDs();
  
  player.play();
  player.loop();
  
}

void draw()
{
  background(0);
  
  beat.detect(player.mix);
  //PopOnBeat();
  //fillThenDance();
  //PopThenDrop();
  pairOfSpotsRun(200);
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

