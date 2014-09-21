void popOnBeat()
{
  if(beat.isKick())
  {
    lightPoint newLight = new lightPoint(LEDs[int(random(460))], color(255, 255, 255), 20);
    newLight.intensity.attraction = 0.1;
    newLight.intensity.target(300);
    lightPoints.add(newLight);
  }
   
  if(lightPoints.size() > 1)
  {
    lightPoints.remove(0);
    lightPoints.remove(0);
  }
  
  for(int i = 0; i < lightPoints.size(); i++)
  {
    lightPoint myLight = lightPoints.get(i);
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
    lightPoint newLight = new lightPoint(LEDs[int(random(460))], color(255, 255, 255), 70);
    newLight.velocity = new PVector(random(0, 5), random(0, 5), random(0, 5));
    lightPoints.add(newLight);
    lightPoints.add(newLight);
    for(int i = 0; i < lightPoints.size(); i++)
    {
      lightPoints.get(i).intensity.target(100);
      lightPoints.get(i).intensity.update();
    }
  }
   
  if(lightPoints.size() > 30)
  {
    lightPoints.remove(0);
    lightPoints.remove(0);
  }
  
  for(int i = 0; i < lightPoints.size(); i++)
  {
    lightPoint myLight = lightPoints.get(i);
    myLight.move();
    myLight.checkOuterEdges();
    myLight.update();
    myLight.findNearestLED();
  }
}

void PopThenDrop()
{
  if(beat.isKick())
  {
    float sideCheck = random(1);
    int newIndex = 0;
    if(sideCheck < 0.125) newIndex = 375;
    else if(sideCheck < 0.25) newIndex = 301;
    else if(sideCheck < 0.375) newIndex = 325;
    else if(sideCheck < 0.5) newIndex = 168;
    else if(sideCheck < 0.625) newIndex = 342;
    else if(sideCheck < 0.75) newIndex = 407;
    else if(sideCheck < 0.875) newIndex = 185;
    else if(sideCheck < 1.0) newIndex = 104;
    lightPoint newLight = new lightPoint(LEDs[newIndex], color(255, 255, 255), 30);
    newLight.acceleration = new PVector(0, random(0, 5), 0);
    newLight.intensity.target(50);
    lightPoints.add(newLight);
    lightPoints.add(newLight);
  }
  
  for(int i = 0; i < lightPoints.size(); i++)
  {
    lightPoint myLight = lightPoints.get(i);
    if (myLight.location.y > 200)
    {
      lightPoints.remove(i);
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
  
  //block1.blockColor = color(255, 0, 0);
  //block2.blockColor = color(0, 255, 0);
  //block3.blockColor = color(0, 0, 255);
  //block4.blockColor = color(255, 255, 255);
  
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
    else if(i == 1)
    {
      float blockHeight = map(centerFrequency, 0, 0.5, 0, 50);
      lightBlocks.get(i).h.target(blockHeight);
      lightBlocks.get(i).h.update();
    }
    else
    {
      float blockHeight = map(centerFrequency, 0, 0.2, 0, 50);
      lightBlocks.get(i).h.target(blockHeight);
      lightBlocks.get(i).h.update();
    }
  }
  
  for(int i = 0; i < lightBlocks.size(); i++)
  {
    //lightBlock myBlock = lightBlocks.get(i);
    //myBlock.velocity = new PVector(1, -1, 1);
    //myBlock.move();
    //myBlock.checkEdgesWeird();
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

void evenEqualizerSetup()
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
  
  for(int i = 0; i < lightBlocks.size(); i++)
  {
    lightBlocks.get(i).w.attraction = 0.9;
    lightBlocks.get(i).h.attraction = 0.9;
    lightBlocks.get(i).d.attraction = 0.9;
  }
  
}

void evenEqualizerRun()
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

void insideOutside()
{
  int passedTime = millis() - savedTime;
  //beat.setSensitivity(1000);
  
  if(beat.isKick()) //passedTime > 1000)
  {
    outsideOn = !outsideOn;
    savedTime = millis();
  }
  if(outsideOn)
  {
    clearLights();
    lightBlock block1 = new lightBlock(0, -100, 0, 210, 10, 210);
    lightBlock block2 = new lightBlock(0, 100, 0, 210, 10, 210);
    lightBlock block3 = new lightBlock(100, 0, 0, 10, 210, 210);
    lightBlock block4 = new lightBlock(-100, 0, 0, 10, 210, 210);
    lightBlocks.add(block1);
    lightBlocks.add(block2);
    lightBlocks.add(block3);
    lightBlocks.add(block4);
  }
  else
  {
    clearLights();
    lightBlock block1 = new lightBlock(0, -50, 0, 110, 10, 110);
    lightBlock block2 = new lightBlock(0, 50, 0, 110, 10, 110);
    lightBlock block3 = new lightBlock(50, 0, 0, 10, 110, 110);
    lightBlock block4 = new lightBlock(-50, 0, 0, 10, 110, 110);
    lightBlocks.add(block1);
    lightBlocks.add(block2);
    lightBlocks.add(block3);
    lightBlocks.add(block4);
  } 
}

void rain(float speed)
{
  if(beat.isKick() || beat.isSnare() || beat.isHat())
  {
    int sideCheck = int(random(4));
    int randomLEDIndex = 0;
    switch (sideCheck)
    {
      case 0:
        randomLEDIndex = int(random(48, 71));
        break;
      case 1:
        randomLEDIndex = int(random(351, 374));
        break;
      case 2:
        randomLEDIndex = int(random(302, 325));
        break;
      case 3:
        randomLEDIndex = int(random(72, 95));
        break;
    }
    
    lightPoint newLight = new lightPoint(LEDs[randomLEDIndex], color(255, 255, 255), 100);
    newLight.intensity.attraction = 0.1;
    newLight.intensity.target(20);

    float randomDir = random(1);
    lightPoints.add(newLight);
    lightPoints.add(newLight);
    
    if(sideCheck < 2)
    {
      newLight.velocity = (randomDir < 0.5) ? new PVector(speed, 0, 0) : new PVector(-speed, 0, 0);
    }
    else
    {
      newLight.velocity = (randomDir < 0.5) ? new PVector(0, 0, speed) : new PVector(0, 0, -speed);
    }
  }
  
  for(int i = 0; i < lightPoints.size(); i++)
  {
    if(lightPoints.get(i).location.y + 10 > 100)
    {
      lightPoints.remove(i);
    }
    lightPoints.get(i).checkOuterEdges();
  }
  
  for(int i = 0; i < lightPoints.size(); i++)
  {
    lightPoint myLight = lightPoints.get(i);
    myLight.move();
    myLight.update();
    
    float x = myLight.location.x;
    float y = myLight.location.y;
    float z = myLight.location.z;
    
    if(y == -100)
    {
      if((x > 100 || x < -100 || z > 100 || z < -100))
      {
        float check = random(1);
        if(check < 0.5)
        {
          myLight.velocity = new PVector(0, speed, 0);
        }
        else
        {
          myLight.velocity = new PVector(-speed * x/100, speed, -speed * z/100);
        }
      }
    }
    else if((y > -53 && y < -47) && (LEDs[myLight.nearestLEDIndex].inside || LEDs[myLight.nearestLEDIndex].connections) && (x > 50 || x < -50 || z > 50 || z < -50))
    {
      float check = random(1);
      if(check < 0.33)
      {
        myLight.velocity = new PVector(0, speed, 0);
      }
      else if(check > 0.66)
      {
        myLight.velocity = new PVector(-speed * x/50, 0, 0);
      }
      else
      {
        myLight.velocity = new PVector(0, 0, -speed * z/50);
      }
    }
    else if((y < 53 && y > 47) && (LEDs[myLight.nearestLEDIndex].inside || LEDs[myLight.nearestLEDIndex].connections) && (x > 50 || x < -50 || z > 50 || z < -50))
    {
      float check = random(1);
      if(check < 0.33)
      {
        myLight.velocity = new PVector(speed * x/50, speed, speed * z/50);      
      }
      else if(check > 0.66)
      {
        myLight.velocity = new PVector(-speed * x/50, 0, 0);
      }
      else
      {
        myLight.velocity = new PVector(0, 0, -speed * z/50);
      }
    }
    
    myLight.update();
    myLight.findNearestLED();
  }
}

void rainOutside()
{
  if(beat.isRange(0, 5, 1))
  {
    int sideCheck = int(random(4));
    int randomLEDIndex = 0;
    switch (sideCheck)
    {
      case 0:
        randomLEDIndex = int(random(411, 434));
        break;
      case 1:
        randomLEDIndex = int(random(72, 96));
        break;
      case 2:
        randomLEDIndex = int(random(230, 254));
        break;
      case 3:
        randomLEDIndex = int(random(387, 411));
        break;
    }
    
    lightPoint newLight = new lightPoint(LEDs[randomLEDIndex], color(255, 255, 255), 10);
    float randomDir = random(1);
    if(sideCheck < 2)
    {
      newLight.velocity = (randomDir < 0.5) ? new PVector(0, 0, 1) : new PVector(0, 0, -1);
    }
    else
    {
      newLight.velocity = (randomDir < 0.5) ? new PVector(1, 0, 0) : new PVector(-1, 0, 0);
    }
    
    lightPoints.add(newLight);
    lightPoints.add(newLight);
  }
  
  for(int i = 0; i < lightPoints.size(); i++)
  {
    if(lightPoints.get(i).location.y + 10 > 100)
    {
      lightPoints.remove(i);
    }
  }
  
  for(int i = 0; i < lightPoints.size(); i++)
  {
    lightPoint myLight = lightPoints.get(i);
    myLight.move();
    
    float x = myLight.location.x;
    float z = myLight.location.z;
    
    if(x > 100 || x < -100 || z > 100 || z < -100)
    {
      myLight.velocity = new PVector(0, 1, 0);
    }
    
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
  
  /*
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
*/
/*
void shadeCornersOnBeat()
{
  if(beat.isOnset() && vertexIndex < 16)
  { 
    lightPoint newLight = new lightPoint(vertices[vertexIndex], color(255, 255, 255), 30);
    newLight.intensity.target(20);
    lightPoints.add(newLight);
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
    for(int i = 0; i < lightPoints.size(); i++)
    {
      lightPoints.get(i).intensity.target += (lightPoints.get(i).intensity.target == 100) ? 0 : 20;
      lightPoints.get(i).intensity.update();
    }
  }
}
*/
