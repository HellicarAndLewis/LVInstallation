void PopOnBeat(float level)
{
  if(player.left.level() > level)
  {
    lightPoint newLight = new lightPoint(LEDs[int(random(460))], color(255, 0, 0), 20);
    newLight.velocity = new PVector(random(0, 5), random(0, 5), random(0, 5));
    movingLights.add(newLight);
    lightPoints.add(newLight);
  }
   
  if(movingLights.size() > 1)
  {
    movingLights.remove(0);
    lightPoints.remove(0);
    if(player.left.level() > level)
    {
      for(int i = 0; i < movingLights.size(); i++)
      {
        lightPoint myLight = movingLights.get(i);
        myLight.wobble(20, 100);
      }
    }
  }
  
  for(int i = 0; i < movingLights.size(); i++)
  {
    lightPoint myLight = movingLights.get(i);
    myLight.move();
    myLight.checkOuterEdges();
    myLight.update();
    myLight.findNearestLED();
  }
}

void FillThenDance(float level)
{
  if(player.left.level() > level)
  {
    lightPoint newLight = new lightPoint(LEDs[int(random(460))], color(255, 255, 255), 50);
    newLight.velocity = new PVector(random(0, 5), random(0, 5), random(0, 5));
    movingLights.add(newLight);
    lightPoints.add(newLight);
  }
   
  if(movingLights.size() > 30)
  {
    movingLights.remove(0);
    lightPoints.remove(0);
    if(player.left.level() > level)
    {
      for(int i = 0; i < movingLights.size(); i++)
      {
        
        lightPoint myLight = movingLights.get(i);
        myLight.wobble(20, 100);
      }
    }
  }
  
  for(int i = 0; i < movingLights.size(); i++)
  {
    lightPoint myLight = movingLights.get(i);
    myLight.move();
    myLight.checkOuterEdges();
    myLight.update();
    myLight.findNearestLED();
  }
}

void PopThenDrop(float level)
{
  if(player.left.level() > level)
  {
    lightPoint newLight = new lightPoint(random(-100, 100), -100, random(-100, 100), color(255, 0, 0), 50);
    newLight.acceleration = new PVector(0, random(0, 5), 0);
    newLight.intensity.target(100);
    movingLights.add(newLight);
    lightPoints.add(newLight);
  }
  
  for(int i = 0; i < movingLights.size(); i++)
  {
    lightPoint myLight = movingLights.get(i);
    if (myLight.location.y > 200)
    {
      movingLights.remove(i);
    }
  }
  
  for(int i = 0; i < movingLights.size(); i++)
  {
    lightPoint myLight = movingLights.get(i);
    myLight.move();
    myLight.update();
    myLight.findNearestLED();
  }
}

void flashersSetup()
{
  //staticLights.add(
}
  /*
  float maxLimit = MIN_FLOAT;
  
  for(int i = 0; i < player.bufferSize() - 1; i++)
  {
    float newLimit = player.left.get(i);
    if(newLimit > maxLimit)
    {
      maxLimit = newLimit;
    }
  }
  */
  /*
  float maxLimit = player.left.level();
  for(int i = 0; i < LEDs.length; i++)
  {
    
    LED myLED = LEDs[i];
    if(myLED.outside || myLED.connections)
    {
      float newLimit = map(maxLimit, -1, 1, -100, 300);
      shadeBelowY(100 - newLimit, myLED);
    }
    else if(myLED.inside)
    {
      float newLimit = map(maxLimit, -1, 1, -50, 50);
      shadeAboveY(newLimit, myLED);
    }
  }
  */
