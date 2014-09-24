//Light The Tessaract with different coloredLights

void shadeFullBrightness(LED myLED)
{
  myLED.shade = myLED.trueColor;
}

void shadeLightPoints(LED myLED, ArrayList<lightPoint> newLightPoints)
{
  float red = 0;
  float green = 0;
  float blue = 0;
  
  for(int j = 0; j < newLightPoints.size(); j++)
  {
    lightPoint lightSource = newLightPoints.get(j);
    float dist = dist(myLED.realLocation.x, myLED.realLocation.y, myLED.realLocation.z, lightSource.location.x, lightSource.location.y, lightSource.location.z);
    float sourceRed = red(lightSource.lightColor);
    float sourceGreen = green(lightSource.lightColor);
    float sourceBlue = blue(lightSource.lightColor);
    
    if(dist < lightSource.intensity.value)
    //if(myLED.trueColor != myLED.shade)
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

void shadeLightPointsAmalg(LED myLED, ArrayList<lightPoint> newlightPoints)
{
  float red = 0;
  float green = 0;
  float blue = 0;
  ArrayList<lightPoint> nearLights;
  nearLights = new ArrayList<lightPoint>();
  
  for(int i = 0; i < newlightPoints.size(); i++)
  {
    lightPoint lightSource = newlightPoints.get(i);
    float dist = dist(myLED.realLocation.x, myLED.realLocation.y, myLED.realLocation.z, lightSource.location.x, lightSource.location.y, lightSource.location.z);
    if(dist < lightSource.intensity.value)
    {
      nearLights.add(lightSource);
    }
  }
  
  for(int i = 0; i < nearLights.size(); i++)
  {
    lightPoint lightSource = nearLights.get(i);
    float dist = dist(myLED.realLocation.x, myLED.realLocation.y, myLED.realLocation.z, lightSource.location.x, lightSource.location.y, lightSource.location.z);
    dist = map( dist, 0, lightSource.intensity.value, 1, 0 );
    red += red( myLED.trueColor ) * dist / nearLights.size();
    green += green( myLED.trueColor ) * dist / nearLights.size();
    blue += blue( myLED.trueColor ) * dist / nearLights.size();
  }
  
  myLED.shade = color(red, green, blue);
}

void shadeLightWells(LED myLED, ArrayList<lightPoint> newlightPoints)
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
    //if(dist > lightSource.intensity.value)
    {
      //if(myLight.shade == color(0, 0, 0)
      dist = map( dist, 200, lightSource.intensity.value, 1, 0 );
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

void shadeLightBlocks(LED myLED, ArrayList<lightBlock> newLightBlocks, char dimension)
{
  float red = 0;
  float green = 0;
  float blue = 0;
  float dist;
  
  for(int j = 0; j < newLightBlocks.size(); j++)
  {
    lightBlock lightSource = newLightBlocks.get(j);
    if(dimension == 'x')
    {
      dist = dist(myLED.realLocation.x, 0, lightSource.location.x, 0);
      float sourceRed = red(lightSource.blockColor);
      float sourceGreen = green(lightSource.blockColor);
      float sourceBlue = blue(lightSource.blockColor);
      
      if(dist < lightSource.w.value)
      {
        dist = map( dist, 0, lightSource.w.value, 1, 0 );
        red = red( myLED.trueColor ) * dist;
        red = (red > sourceRed) ? sourceRed : red;
        green = green( myLED.trueColor ) * dist;
        green = (green > sourceGreen) ? sourceGreen : green;
        blue = blue( myLED.trueColor ) * dist;
        blue = (blue > sourceBlue) ? sourceBlue : blue;
      }
    }
    else if(dimension == 'y')
    {
      dist = dist(myLED.realLocation.y, 0, lightSource.location.y, 0);
      float sourceRed = red(lightSource.blockColor);
      float sourceGreen = green(lightSource.blockColor);
      float sourceBlue = blue(lightSource.blockColor);
      
      if(dist < lightSource.h.value)
      {
        dist = map( dist, 0, lightSource.h.value, 1, 0 );
        red = red( myLED.trueColor ) * dist;
        red = (red > sourceRed) ? sourceRed : red;
        green = green( myLED.trueColor ) * dist;
        green = (green > sourceGreen) ? sourceGreen : green;
        blue = blue( myLED.trueColor ) * dist;
        blue = (blue > sourceBlue) ? sourceBlue : blue;
      }
    }
    else if(dimension == 'z')
    {
      dist = dist(myLED.realLocation.z, 0, lightSource.location.z, 0);
      float sourceRed = red(lightSource.blockColor);
      float sourceGreen = green(lightSource.blockColor);
      float sourceBlue = blue(lightSource.blockColor);
      
      if(dist < lightSource.d.value)
      {
        dist = map( dist, 0, lightSource.d.value, 1, 0 );
        red = red( myLED.trueColor ) * dist;
        red = (red > sourceRed) ? sourceRed : red;
        green = green( myLED.trueColor ) * dist;
        green = (green > sourceGreen) ? sourceGreen : green;
        blue = blue( myLED.trueColor ) * dist;
        blue = (blue > sourceBlue) ? sourceBlue : blue;
      }
    }
    else
    {
      println("invalid dimension: " + dimension);
    }
    
    myLED.shade = color(red, green, blue);
  }
}

void shadeWithinPoint(LED myLED, lightPoint newLightPoint)
{
  float dist = dist(myLED.realLocation.x, myLED.realLocation.y, myLED.realLocation.z, newLightPoint.location.x, newLightPoint.location.y, newLightPoint.location.z);
  if(dist < newLightPoint.intensity.value)
  {
    float sourceRed = red(newLightPoint.lightColor);
    float sourceGreen = green(newLightPoint.lightColor);
    float sourceBlue = blue(newLightPoint.lightColor);
    
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
