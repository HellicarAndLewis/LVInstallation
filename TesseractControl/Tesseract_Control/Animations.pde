void popOnBeat()
{
  if(beat.isRange(0, 5, 1))
  {
    lightPoint newLight = new lightPoint(LEDs[int(random(460))], color(255, 255, 255), 20);
    newLight.intensity.attraction = 0.1;
    newLight.intensity.target(300);
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
  if(beat.isKick())
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
  if(beat.isHat())
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
    lightPoint newLight = new lightPoint(LEDs[newIndex], color(255, 255, 255), 30);
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

void shadeCornersOnBeat()
{
  if(beat.isOnset() && vertexIndex < 16)
  { 
    lightPoint newLight = new lightPoint(vertices[vertexIndex], color(255, 255, 255), 30);
    newLight.intensity.target(20);
    staticLights.add(newLight);
    lightPoints.add(newLight);
    vertexIndex++;
  }
  else if(beat.isOnset())
  {
    for(int i = 0; i < LEDs.length; i++)
    {
      LED myLED = LEDs[i];
      if(!myLED.isCorner) colorRandomBlackAndWhite(myLED);
    }
    for(int i = 0; i < staticLights.size(); i++)
    {
      staticLights.get(i).intensity.target += (staticLights.get(i).intensity.target == 100) ? 0 : 20;
      staticLights.get(i).intensity.update();
    }
  }
}

void quadBoxRotSetup()
{
  lightBlock block1 = new lightBlock(100.0, 100.0, 100.0, 200.0, 200.0, 200.0);
  block1.velocity = new PVector(-1, 0, 0);
  lightBlock block2 = new lightBlock(-100.0, 100.0, 100.0, 200.0, 200.0, 200.0);
  block2.velocity = new PVector(0, 0, -1);
  lightBlock block3 = new lightBlock(100.0, 100.0, -100.0, 200.0, 200.0, 200.0);
  block3.velocity = new PVector(0, 0, 1);
  lightBlock block4 = new lightBlock(-100.0, 100.0, -100.0, 200.0, 200.0, 200.0);
  block4.velocity = new PVector(1, 0, 0);
  lightBlocks.add(block1);
  lightBlocks.add(block2);
  lightBlocks.add(block3);
  lightBlocks.add(block4);
}

void quadBoxRotRun()
{
    for(int i = 0; i < lightBlocks.size(); i++)
  {
    float centerFrequency = fft.getAvg(i);
    if(i == 0)
    {
      float blockHeight = map(centerFrequency, 0, 3, 0, 50);
      lightBlocks.get(i).h.target(blockHeight);
      lightBlocks.get(i).h.update();
    }
    else
    {
      float blockHeight = map(centerFrequency, 0, 1, 0, 50);
      lightBlocks.get(i).h.target(blockHeight);
      lightBlocks.get(i).h.update();
    }
  }
  
  for(int i = 0; i < lightBlocks.size(); i++)
  {
    lightBlock myBlock = lightBlocks.get(i);
    //myBlock.velocity = new PVector(1, -1, 1);
    //myBlock.move();
    //myBlock.checkEdges();
  }
}

void octoBoxSetup()
{
  lightBlock block1 = new lightBlock(50.0, 0.0, 100.0, 110.0, 200.0, 10.0);
  lightBlock block2 = new lightBlock(100.0, 0.0, 50.0, 10.0, 200.0, 110.0);
  lightBlock block3 = new lightBlock(-50.0, 0.0, 100.0, 110.0, 200.0, 10.0);
  lightBlock block4 = new lightBlock(-100.0, 0.0, 50.0, 10.0, 200.0, 110.0);
  lightBlock block5 = new lightBlock(50.0, 0.0, -100.0, 110.0, 200.0, 10.0);
  lightBlock block6 = new lightBlock(100.0, 0.0, -50.0, 10.0, 200.0, 110.0);
  lightBlock block7 = new lightBlock(-50.0, 0.0, -100.0, 110.0, 200.0, 10.0);
  lightBlock block8 = new lightBlock(-100.0, 0.0, -50.0, 10.0, 200.0, 110.0);
  
  lightBlock block9 = new lightBlock(50.0, 0.0, 50.0, 100.0, 200.0, 100.0);
  lightBlock block10 = new lightBlock(-50.0, 0.0, 50.0, 100.0, 200.0, 100.0); 
  lightBlock block11 = new lightBlock(-50.0, 0.0, -50.0, 100.0, 200.0, 100.0); 
  lightBlock block12 = new lightBlock(50.0, 0.0, -50.0, 100.0, 200.0, 100.0);

  lightBlocks.add(block1);
  lightBlocks.add(block2);
  lightBlocks.add(block3);
  lightBlocks.add(block4);
  lightBlocks.add(block5);
  lightBlocks.add(block6);
  lightBlocks.add(block7);
  lightBlocks.add(block8);
  lightBlocks.add(block9);
  lightBlocks.add(block10);
  lightBlocks.add(block11);
  lightBlocks.add(block12);
}

void octoBoxRun()
{
  for(int i = 0; i < lightBlocks.size(); i++)
  {
    float max = map(i, 0, 12, 2, 0.01);
    float centerFrequency = fft.getAvg(i);
    float blockHeight = map(centerFrequency, 0, max, 0, 50);
    lightBlocks.get(i).h.target(blockHeight);
    lightBlocks.get(i).h.update();
  }
}

void equalizer3DSetup()
{
  lightBlock blockHor1 = new lightBlock(0, 100, 0, 10, 10, 250);
  lightBlock blockHor2 = new lightBlock(0, -100, 0, 10, 10, 250);
  lightBlock blockHor3 = new lightBlock(0, 50, 0, 10, 10, 250);
  lightBlock blockHor4 = new lightBlock(0, -50, 0, 10, 10, 250);
  
  lightBlock blockHor5 = new lightBlock(0, 100, 0, 250, 10, 10);
  lightBlock blockHor6 = new lightBlock(0, -100, 0, 250, 10, 10);
  lightBlock blockHor7 = new lightBlock(0, 50, 0, 250, 10, 10);
  lightBlock blockHor8 = new lightBlock(0, -50, 0, 250, 10, 10);
  
  lightBlock blockVert1 = new lightBlock(100, 0, 0, 10, 10, 250);
  lightBlock blockVert2 = new lightBlock(-100, 0, 0, 10, 10, 250);
  lightBlock blockVert3 = new lightBlock(50, 0, 0, 10, 10, 250);
  lightBlock blockVert4 = new lightBlock(-50, 0, 0, 10, 10, 250);
  
  lightBlock blockVert5 = new lightBlock(100, 0, 0, 10, 250, 10);
  lightBlock blockVert6 = new lightBlock(-100, 0, 0, 10, 250, 10);
  lightBlock blockVert7 = new lightBlock(50, 0, 0, 10, 250, 10);
  lightBlock blockVert8 = new lightBlock(-50, 0, 0, 10, 250, 10);

  lightBlocks.add(blockHor1);
  lightBlocks.add(blockHor2);
  lightBlocks.add(blockHor3);
  lightBlocks.add(blockHor4);
  lightBlocks.add(blockHor5);
  lightBlocks.add(blockHor6);
  lightBlocks.add(blockHor7);
  lightBlocks.add(blockHor8);
  
  lightBlocks.add(blockVert1);
  lightBlocks.add(blockVert2);
  lightBlocks.add(blockVert3);
  lightBlocks.add(blockVert4);
  lightBlocks.add(blockVert5);
  lightBlocks.add(blockVert6);
  lightBlocks.add(blockVert7);
  lightBlocks.add(blockVert8);
  
  for(int i = 0; i < lightBlocks.size(); i++)
  {
    lightBlocks.get(i).w.attraction = 0.9;
    lightBlocks.get(i).h.attraction = 0.9;
    lightBlocks.get(i).d.attraction = 0.9;
  }
  
}

void equalizer3DRun()
{
  for(int i = 0; i < 4; i++)
  {
    //float max = map(i, 0, 15, 2, 0.01);
    float centerFrequency = fft.getAvg(0);
    float blockHeight = map(centerFrequency, 0, 10, 0, 50);
    lightBlocks.get(i).w.target(blockHeight);
    lightBlocks.get(i).w.update();
  }
  for(int i = 4; i < 8; i++)
  {
    //float max = map(i-4, 0, 15, 2, 0.01);
    float centerFrequency = fft.getAvg(0);
    float blockHeight = map(centerFrequency, 0, 10, 0, 50);
    lightBlocks.get(i).d.target(blockHeight);
    lightBlocks.get(i).d.update();
  }
  for(int i = 8; i < 12; i++)
  {
    //float max = map(i-8, 0, 12, 2, 0.01);
    float centerFrequency = fft.getAvg(0);
    float blockHeight = map(centerFrequency, 0, 10, 0, 50);
    lightBlocks.get(i).h.target(blockHeight);
    lightBlocks.get(i).h.update();
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
