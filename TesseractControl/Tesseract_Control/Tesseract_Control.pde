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
boolean debugOn = false;

int animationCheck = 1;

Minim minim;
AudioPlayer player;
BeatDetect beat;
WaveformRenderer waveform;
BeatListener beatListener;
FFT fft;

ArrayList<lightPoint> movingLights;
ArrayList<lightPoint> staticLights;
ArrayList<lightBlock> lightBlocks;

LED[] LEDs;

float minDistance;
int closestText;
float closestTextX;
float closestTextY;

int savedTime = 0;
int vertexIndex = 0;

PVector[] vertices;

void setup()
{
  size(1000, 1000, P3D);
  mapOn = true;
  randomOn = false;
  
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
  
  player = minim.loadFile("LVTrack01.mp3", 512);
  player.addListener(waveform);
  
  LEDs = new LED[460]; // Initialize Full Tesseract Array (460 = number of LEDs)
  
  lightPoints = new ArrayList<lightPoint>();
  movingLights = new ArrayList<lightPoint>();
  staticLights = new ArrayList<lightPoint>();
  lightBlocks = new ArrayList<lightBlock>();
  
  opc = new OPC(this, "127.0.0.1", 7890);
  
  boolean shrinkSetupDone = false;
  
  //generate the Tesseract
  generateTesseract();
  setCornerConnections();
  
  colorRainbow();
  
  //start up minim - for playing music
  minim = new Minim(this);
  beat = new BeatDetect(player.bufferSize(), player.sampleRate());
  beat.setSensitivity(500);
  fft = new FFT( player.bufferSize(), player.sampleRate() );
  fft.linAverages( 30 );
  
  setupLEDs();
  
  player.play();
  player.loop();
  
}

void draw()
{
  background(0);
  
  beat.detect( player.mix );
  fft.forward( player.mix );
  
  //colorRandomBlackAndWhite();
  //equalizer3DRun();
  //quadBoxRotRun();
  //quadBoxRotRun();
  //octoBoxRun();
  
  switch(animationCheck)
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
    case 3: 
      equalizer3DRun();
      break;
    case 4:
      quadBoxRotRun();
      break;
    default:
      break;
      
  }
  
  for(int i = 0; i < LEDs.length; i++)
  {
    LED myLED = LEDs[i];
    //shadeFullBrightness(myLED);
    shadeBlack(myLED);
    shadeLightPoints(myLED, lightPoints);
    //colorCornersRed();
    //shadeFullBrightness(myLED);
    //shadeWithinBlock(myLED, lightBlocks.get(0));
    
    for(int j = 0; j < lightBlocks.size(); j++)
    {
      shadeWithinBlock(myLED, lightBlocks.get(j));
    }
    
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
  
  waveform.display();
  
  if(debugOn)
  {
    for(int i = 0; i < lightPoints.size(); i++)
    {
      lightPoints.get(i).display(width*0.75, height*0.75, 0);
    }
    for(int i = 0; i < lightBlocks.size(); i++)
    {
      lightBlocks.get(i).display(width*0.75, height*0.75, 0);
    }
  }
}

void keyPressed()
{
  switch(key)
  {
    case ' ':
      mapOn = !mapOn;
      if(player.isPlaying()) player.pause();
      else  player.play();
      break;
    case 'd':
      debugOn = !debugOn;
      break;
    case '1':
      clearLights();
      animationCheck = 0;
      break;
    case '2':
      clearLights();
      animationCheck = 1;
      break;
    case '3':
      clearLights();
      animationCheck = 2;
      break;
    case '4':
      clearLights();
      equalizer3DSetup();
      animationCheck = 3;
      break;
    case '5':
      clearLights();
      quadBoxRotSetup();
      animationCheck = 4;
      break;
    default:
      break;
  }
}

void setupLEDs()
{
  for(int i = 0; i < LEDs.length; i++)
  {
    opc.led(i, (int)LEDs[i].mapLocation.x, (int)LEDs[i].mapLocation.y);
  }
}
void clearLights()
{
  lightPoints.clear();
  movingLights.clear();
  staticLights.clear();
  lightBlocks.clear();
}

