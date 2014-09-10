void PopOnBeat()
{
  if(beat.isOnset())
  {
    lightPoint newLight = new lightPoint(LEDs[int(random(460))], color(255, 0, 0), 20);
    newLight.intensity.attraction = 0.1;
    newLight.intensity.target(500);
    movingLights.add(newLight);
    lightPoints.add(newLight);
  }
   
  if(movingLights.size() > 1)
  {
    movingLights.remove(0);
    lightPoints.remove(0);
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

void fillThenDance()
{
  if(beat.isOnset())
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
    if(beat.isOnset())
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

void PopThenDrop()
{
  if(beat.isOnset())
  {
    float sideCheck = random(1);
    int newIndex = 0;
    if(sideCheck < 0.125) newIndex = 339;
    else if(sideCheck < 0.25) newIndex = 71;
    else if(sideCheck < 0.375) newIndex = 443;
    else if(sideCheck < 0.5) newIndex = 254;
    else if(sideCheck < 0.625) newIndex = 286;
    else if(sideCheck < 0.75) newIndex = 112;
    else if(sideCheck < 0.875) newIndex = 185;
    else if(sideCheck < 1.0) newIndex = 145;
    lightPoint newLight = new lightPoint(LEDs[newIndex], color(255, 0, 0), 30);
    newLight.acceleration = new PVector(0, random(0, 5), 0);
    newLight.intensity.target(50);
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

void pairOfSpotsSetup(float largeSize)
{
  lightPoints.add(new lightPoint(-100, 0, 0, color(255, 255, 255), largeSize));
  lightPoints.add(new lightPoint(100, 0, 0, color(255, 255, 255), 0));
}

void pairOfSpotsRun(float largeSize)
{
  lightPoint leftLight = lightPoints.get(0);
  lightPoint rightLight = lightPoints.get(1);
  leftLight.intensity.attraction = 0.5;
  
  if(beat.isOnset())
  {
    if(leftLight.intensity.target == largeSize || leftLight.intensity.value >= largeSize)
    {
      leftLight.intensity.target(20);
    }
    else if(leftLight.intensity.target == 20 || leftLight.intensity.value <= 20)
    {
      leftLight.intensity.target(largeSize);
    }
    if(rightLight.intensity.target == largeSize || rightLight.intensity.value >= largeSize)
    {
      rightLight.intensity.target(20);
    }
    else if(rightLight.intensity.target == 20 || rightLight.intensity.value <= 20)
    {
      rightLight.intensity.target(largeSize);
    }
  }
  
  for(int i = 0; i < lightPoints.size(); i++)
  {
    lightPoint myLight = lightPoints.get(i);
    myLight.move();
    myLight.update();
    myLight.findNearestLED();
  }
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
