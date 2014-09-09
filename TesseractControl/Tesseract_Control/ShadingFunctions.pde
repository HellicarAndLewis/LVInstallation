//Functions to Shade Tesseract (this is where the fun happens)

//Rainbow colors
void shadeRainbow()
{
  for(int i = 0; i < LEDs.length; i++)
  {
    LED myLED = LEDs[i];
    float red = map(myLED.realLocation.x, -100, 100, 0, 255);
    float green = map(myLED.realLocation.y, -100, 100, 0, 255);
    float blue = map(myLED.realLocation.z, -100, 100, 0, 255);
    myLED.shade = color(red, green, blue);
  }
}

//random colored
void shadeRandom()
{
  for(int i = 0; i < LEDs.length; i++)
  {
    LED myLED = LEDs[i];
    myLED.shade = color(random(0, 255), random(0, 255), random(0, 255));
  }
}

//random black and white
void shadeRandomBlackAndWhite()
{
  for(int i = 0; i < LEDs.length; i++)
  {
    LED myLED = LEDs[i];
    float colour = random(0,255);
    myLED.shade = color(colour, colour, colour);
  }
}

//all one solid color
void shadeSolid(int red, int blue, int green)
{
  for(int i = 0; i < LEDs.length; i++)
  {
    LED myLED = LEDs[i];
    myLED.shade = color(red, green, blue);
  }
}

//shade corners Red
void shadeCornersRed()
{
  for(int i = 0; i < LEDs.length; i++)
  {
    LED myLED = LEDs[i];
    if(myLED.isCorner)
    {
      myLED.shade = color(255, 0, 0);
    }
  }
}

//slowly charge up
void shadeChargeUp() 
{
  for(int i = 0; i < LEDs.length; i++)
  {
    LED myLED = LEDs[i];
    myLED.shade = color(millis()/50,millis()/50,millis()/50);
  }
}

void shadeLightPoints(ArrayList<lightPoint> newlightPoints)
{
  for(int i = 0; i < LEDs.length; i++)
  {
    LED myLED = LEDs[i];
    float red = 0;
    float green = 0;
    float blue = 0;
    
    for(int j = 0; j < newlightPoints.size(); j++)
    {
      lightPoint lightSource = newlightPoints.get(j);
      float dist = dist(myLED.realLocation.x, myLED.realLocation.y, myLED.realLocation.z, lightSource.location.x, lightSource.location.y, lightSource.location.z);
      if(dist < lightSource.intensity)
      {
        dist = map(dist, 0, lightSource.intensity, 1, 0);
        red += red(lightSource.lightColor) * dist;
        green += green(lightSource.lightColor) * dist;
        blue += blue(lightSource.lightColor) * dist;
      }
    }
     myLED.shade = color(red, green, blue);
  }
}

void shadeOnePoint(int index, color newColor)
{
  LEDs[index].shade = newColor;
}

void shadeNoise(float xOff)
{
  for(int i = 0; i < LEDs.length; i++)
  {
    //float red = map(noise(i / 24 + xOff), 0, 1, 0, 255);
    //float green = map(noise(i / 3 + xOff + 1000), 0, 1, 0, 255);
    float blue = map(noise(i + xOff + 2000), 0, 1, 0, 255);
    LEDs[i].shade = color(0, 0, blue);
  }
}

/*
void shadeLightPlane(ArrayList<lightPlane> newlightPlanes)
{
  
}
*/

void shadeBelowY(float y)
{
  for(int i = 0; i < LEDs.length; i++)
  {
    LED myLED = LEDs[i];
    
    if(myLED.realLocation.y > y)
    {
      myLED.shade = color(255);
    }
    else
    {
      myLED.shade = color(127);
    }
  }
}

//tune to the music
