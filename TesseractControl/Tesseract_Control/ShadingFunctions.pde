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
void shadeRandom(LED myLED)
{
    myLED.shade = color(random(0, 255), random(0, 255), random(0, 255));
}

//random black and white
void shadeRandomBlackAndWhite(LED myLED)
{
    float colour = random(0,255);
    myLED.shade = color(colour, colour, colour);
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
void shadeChargeUp(LED myLED) 
{
  myLED.shade = color(millis()/50,millis()/50,millis()/50);
}

void shadeLightPoints(LED myLED, ArrayList<lightPoint> newlightPoints)
{
  float red = 0;
  float green = 0;
  float blue = 0;
  
  for(int j = 0; j < newlightPoints.size(); j++)
  {
    lightPoint lightSource = newlightPoints.get(j);
    float dist = dist(myLED.realLocation.x, myLED.realLocation.y, myLED.realLocation.z, lightSource.location.x, lightSource.location.y, lightSource.location.z);
    if(dist < lightSource.intensity.value)
    {
      dist = map(dist, 0, lightSource.intensity.value, 1, 0);
      red += red(lightSource.lightColor) * dist;
      green += green(lightSource.lightColor) * dist;
      blue += blue(lightSource.lightColor) * dist;
    }
  }
  myLED.shade = color(red, green, blue);
}

void shadeOnePoint(int index, color newColor)
{
  LEDs[index].shade = newColor;
}

void shadeNoise(LED myLED, float xOff)
{
  //float blue = map(noise(i + xOff + 2000), 0, 1, 0, 255);
  //myLED.shade = color(0, 0, blue);
}

/*
void shadeLightPlane(ArrayList<lightPlane> newlightPlanes)
{
  
}
*/

void shadeByYCuttoff(LED myLED, float cuttoff, color newColor, boolean above)
{
  if(above)
  {
    if(myLED.realLocation.y < cuttoff)
    {
      myLED.shade = newColor;
    }
  }
  else
  {
    if(myLED.realLocation.y > cuttoff)
    {
      myLED.shade = newColor;
    }
  }
}

void shadeByXCuttoff(LED myLED, float cuttoff, color newColor, boolean above)
{
  if(above)
  {
    if(myLED.realLocation.x < cuttoff)
    {
      myLED.shade = newColor;
    }
  }
  else
  {
    if(myLED.realLocation.x > cuttoff)
    {
      myLED.shade = newColor;
    }
  }
}

void shadeByZCuttoff(LED myLED, float cuttoff, color newColor, boolean above)
{
  if(above)
  {
    if(myLED.realLocation.x < cuttoff)
    {
      myLED.shade = newColor;
    }
  }
  else
  {
    if(myLED.realLocation.x > cuttoff)
    {
      myLED.shade = newColor;
    }
  }
}

/*
void normalizeShading()
{
  
}
*/

//tune to the music
