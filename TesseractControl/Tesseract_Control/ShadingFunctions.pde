//Light The Tessaract with different coloredLights

void shadeFullBrightness(LED myLED)
{
  myLED.shade = myLED.trueColor;
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
    float sourceRed = red(lightSource.lightColor);
    float sourceGreen = green(lightSource.lightColor);
    float sourceBlue = blue(lightSource.lightColor);
    if(dist < lightSource.intensity.value)
    {
      dist = map( dist, 0, lightSource.intensity.value, 1, 0 );
      red = red( myLED.trueColor ) * dist;
      red = (red > sourceRed) ? sourceRed : red;
      green = green( myLED.trueColor ) * dist;
      green = (green > sourceGreen) ? sourceGreen : green;
      blue = blue( myLED.trueColor ) *   dist;
      blue = (blue > sourceBlue) ? sourceBlue : blue;
    }
    myLED.shade = color(red, green, blue);
  }
}

void shadeWithinBlock(LED myLED, lightBlock newLightBlock)
{
  if( newLightBlock.isThisInside(myLED.realLocation) )
  {
    float sourceRed = red(newLightBlock.blockColor);
    float sourceGreen = green(newLightBlock.blockColor);
    float sourceBlue = blue(newLightBlock.blockColor);
    
    float red = red( myLED.trueColor );
    red = (red > sourceRed) ? sourceRed : red;
    float green = green( myLED.trueColor );
    green = (green > sourceGreen) ? sourceGreen : green;
    float blue = blue( myLED.trueColor );
    blue = (blue > sourceBlue) ? sourceBlue : blue;
    myLED.shade = color(red, green, blue);
  }
}

void shadeBlack(LED myLED)
{
  myLED.shade = 0;
}
