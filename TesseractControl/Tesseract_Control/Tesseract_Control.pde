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
lightingScheme summer;
lightingScheme lava;
lightingScheme snow;

float minLight = 0;

Integrator barrier = new Integrator(0);

boolean mapOn;
//boolean randomOn;
boolean debugOn = false;
boolean outsideOn = false;
boolean fullOn = false;
boolean solidOn = false;

int animationCheck = 0;
int colorCheck = 0;
int dynamicColoringCheck = 0;
int lightingSchemeCheck = 0;
int whirlwindStep = 1000;

int savedTime;

Minim minim;
AudioPlayer player;
AudioInput lineIn;
BeatDetect beat;
WaveformRenderer waveform;
BeatListener beatListener;
FFT fft;

ArrayList<lightBlock> lightBlocks;

LED[] LEDs;

float minDistance;
int closestText;
float closestTextX;
float closestTextY;

PVector[] vertices;

void setup()
{
  size(1000, 1000, P3D);
  
  mapOn = true;
  //randomOn = false;
  
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
  
  lineIn = minim.getLineIn();

  player = minim.loadFile("LVTrack01.mp3", 512);
  player.addListener(waveform);
  lineIn.addListener(waveform);

  LEDs = new LED[460]; // Initialize Full Tesseract Array (460 = number of LEDs)

  lightPoints = new ArrayList<lightPoint>();
  lightBlocks = new ArrayList<lightBlock>();
  
  color[] summerColors;
  summerColors = new color[3];
  summerColors[0] = color(254, 254, 254);
  summerColors[1] = color(254, 254, 254);
  summerColors[2] = color(0, 0, 127);
  
  summer = new lightingScheme(summerColors);
  
  color[] lavaColors;
  lavaColors = new color[5];
  lavaColors[0] = color(255, 0, 0);
  lavaColors[1] = color(255, 140, 0);
  lavaColors[2] = color(255, 165, 0);
  lavaColors[3] = color(255, 255, 0);
  lavaColors[4] = color(255, 69, 0);
  
  lava = new lightingScheme(lavaColors);

  color[] snowColors;
  snowColors = new color[3];
  snowColors[0] = color(254, 254, 254);
  snowColors[1] = color(224, 255, 255);
  snowColors[2] = color(135, 206, 250);
  
  snow = new lightingScheme(snowColors);

  
  opc = new OPC(this, "127.0.0.1", 7890);

  //generate the Tesseract
  generateTesseract();
  setCornerConnections();

  colorSolid(255, 255, 255);

  //start up minim - for playing music
  //beat = new BeatDetect(lineIn.bufferSize(), lineIn.sampleRate());
  //fft = new FFT( lineIn.bufferSize(), lineIn.sampleRate() );
  
  beat = new BeatDetect(player.bufferSize(), player.sampleRate());
  fft = new FFT( player.bufferSize(), player.sampleRate() );
  
  beat.setSensitivity(200);
  fft.linAverages( 30 );

  setupLEDs();

  player.play();
  player.loop();
  savedTime = millis();
}

void draw()
{
  background(0);
  
  //beat.detect( lineIn.mix );
  //fft.forward( lineIn.mix );
  
  beat.detect( player.mix );
  fft.forward( player.mix );

  switch(animationCheck)
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
    rain(6, 0);
    break;
  case 6:
    quadBoxRotRun();
    break;
  case 7:
    fillRun();
    break;
  case 8:
    novaRun(minLight);
    break;
  case 9:
    whirlwindRun();
    break;
  default:
    break;
  }
  
  switch(dynamicColoringCheck)
  {
    case 0:
      break;
    case 1:
      colorRandomBlackAndWhite();
      break;
    default:
      break;
  }
  
  switch(lightingSchemeCheck)
  {
    case 0:
      break;
    case 1:
      summer.colorLights(lightPoints);
      break;
    case 2:
      lava.colorLights(lightPoints);
      break;
    case 3:
      snow.colorLights(lightPoints);
      break;
    default:
      break;
  }
  
  for (int i = 0; i < LEDs.length; i++)
  {
    LED myLED = LEDs[i];

    if(fullOn) 
    { 
      shadeFullBrightness(myLED);
    } 
    else
    {
      shadeBlack(myLED);
    }
    
    if(solidOn)
    {
      for (int j = 0; j < lightPoints.size(); j++)
      {
        shadeWithinPoint(myLED, lightPoints.get(j));
      }
      for(int j = 0; j < lightBlocks.size(); j++)
      {
        shadeWithinBlock(myLED, lightBlocks.get(j));
      }
    }
    else 
    {
      shadeLightPoints(myLED, lightPoints);
      
      shadeLightBlocks(myLED, lightBlocks, 'y');
    }
  }
  //Draw 3D version all the time
  for (int i = 0; i < LEDs.length; i++)
  {
    LEDs[i].draw3D(width*0.75, height*0.75);
  }

  //Draw 2D map when mapOn is toggled
  if (mapOn)
  {
    for (int i = 0; i < LEDs.length; i++)
    {
      LEDs[i].drawMap(0, 0);
      LEDs[i].stroke = 0;
    }
  }
  
  minDistance = MAX_FLOAT;
  PVector mouseLocation = new PVector(mouseX, mouseY);
  
  for (int i = 0; i < LEDs.length; i++)
  {
    float dist = dist(mouseLocation.x, mouseLocation.y, LEDs[i].mapLocation.x, LEDs[i].mapLocation.y);
    if (dist < 10 && dist < minDistance)
    {
      minDistance = dist;
      closestText = i;
      closestTextX = mouseLocation.x + 10;
      closestTextY = mouseLocation.y - 10;
    }
  }

  if (minDistance < MAX_FLOAT)
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

  if (debugOn)
  {
    for (int i = 0; i < lightPoints.size (); i++)
    {
      lightPoints.get(i).display(width*0.75, height*0.75, 0);
    }
    for (int i = 0; i < lightBlocks.size (); i++)
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
    if (player.isPlaying()) player.pause();
    else  player.play();
    break;
  case 'd':
    debugOn = !debugOn;
    break;
  case '1':
    clearLights();
    animationCheck = 1;
    break;
  case '2':
    clearLights();
    animationCheck = 2;
    break;
  case '3':
    clearLights();
    animationCheck = 3;
    break;
  case '4':
    clearLights();
    evenEqualizerSetup();
    animationCheck = 4;
    break;
  case '5':
    clearLights();
    animationCheck = 5;
    break;
  case '6':
    clearLights();
    quadBoxRotSetup();
    animationCheck = 6;
    break;
  case '7':
    clearLights();
    fillSetup(color(255, 127, 127), color(100, 100, 100));
    animationCheck = 7;
    break;
  case '8':
    clearLights();
    novaSetup();
    minLight = 0;
    animationCheck = 8;
    break;
  case '9':
    clearLights();
    whirlwindSetup();
    animationCheck = 9;
    break;
  case 'q':
    colorRainbow();
    break;
  case 'w':
    colorRandomBlackAndWhite();
    break;
  case 'e':
    colorGradient(color(255, 0, 0), color(0, 255, 0), 0, 'x');
    break;
  case 'r':
    colorSolid(255, 255, 255);
    break;
  case 't':
    colorSolid(255, 0, 0);
  case 'y':
    colorSolid(0, 255, 0);
    break;
  case 'u':
    colorSolid(0, 0, 255);
    break;
  case 'p':
    dynamicColoringCheck = (dynamicColoringCheck == 0) ? 1 : 0;
    break;
  case 'l':
    fullOn = !fullOn;
    break;
  case 's':
    solidOn = !solidOn;
  case 'z':
    lightingSchemeCheck = 0;
    break;
  case 'x':
    lightingSchemeCheck = 1;
    break;
  case 'c':
    lightingSchemeCheck = 2;
    break;
  case 'v':
    lightingSchemeCheck = 3;
    break;
  default:
    break;
  }
}

void setupLEDs()
{
  for (int i = 0; i < LEDs.length; i++)
  {
    opc.led(i, (int)LEDs[i].mapLocation.x, (int)LEDs[i].mapLocation.y);
  }
}

void clearLights()
{
  lightPoints.clear();
  lightBlocks.clear();
}

void clearAnimations()
{
  animationCheck = 0;
}

