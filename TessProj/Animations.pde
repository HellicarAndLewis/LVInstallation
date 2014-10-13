void popOnBeat()
{
  if(beat.isKick())
  {
    lightPoint newLight = new lightPoint(LEDs[int(random(LEDs.length))], color(255, 255, 255), 20/2);
    newLight.intensity.attraction = 0.1;
    newLight.intensity.target(500/2);
    newLight.intensity.attraction = 1.0;
    lightPoints.add(newLight);
  }
  if(lightPoints.size() > 1)
  {
    for(int i = 0; i < lightPoints.size() - 1; i++)
    {
      lightPoints.get(i).intensity.target(0);
      if(lightPoints.get(i).intensity.value < 10)
      {
        lightPoints.remove(i);
      }
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

void PopThenDrop()
{
  if(beat.isKick())
  {
    float sideCheck = random(1);
    int newIndex = 0;
    if(sideCheck < 0.125) newIndex = 3750;
    else if(sideCheck < 0.25) newIndex = 3010;
    else if(sideCheck < 0.375) newIndex = 3250;
    else if(sideCheck < 0.5) newIndex = 1680;
    else if(sideCheck < 0.625) newIndex = 3420;
    else if(sideCheck < 0.75) newIndex = 4070;
    else if(sideCheck < 0.875) newIndex = 1850;
    else if(sideCheck < 1.0) newIndex = 1040;
    lightPoint newLight = new lightPoint(LEDs[newIndex], color(255, 255, 255), 30/2);
    newLight.acceleration = new PVector(0, random(10, 15), 0);
    newLight.intensity.target(200/2);
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


void fillThenDance()
{
  if(beat.isKick())
  {
    lightPoint newLight = new lightPoint(LEDs[int(random(LEDs.length))], color(255, 255, 255), 70/2);
    newLight.velocity = new PVector(random(5, 10), random(5, 10), random(5, 10));
    lightPoints.add(newLight);
    lightPoints.add(newLight);
    for(int i = 0; i < lightPoints.size(); i++)
    {
      lightPoints.get(i).intensity.target(200/2);
      lightPoints.get(i).intensity.update();
    }
  }
   
  if(lightPoints.size() > 10)
  {
    lightPoints.remove(0);
    lightPoints.remove(0);
    if(beat.isKick())
    {
      for(int i = 0; i < lightPoints.size(); i++)
      {
        lightPoints.get(i).velocity.mult(-1);
      }
    }
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

void rain(float speed, int danceNum)
{
  if(beat.isKick() || beat.isSnare() || beat.isHat())
  {
    int sideCheck = int(random(4));
    int randomLEDIndex = 0;
    switch (sideCheck)
    {
      case 0:
        randomLEDIndex = int(random(480, 710));
        break;
      case 1:
        randomLEDIndex = int(random(3510, 3740));
        break;
      case 2:
        randomLEDIndex = int(random(3020, 3250));
        break;
      case 3:
        randomLEDIndex = int(random(720, 950));
        break;
    }
    
    lightPoint newLight = new lightPoint(LEDs[randomLEDIndex], color(255, 255, 255), 100/2);
    newLight.intensity.attraction = 0.1;
    newLight.intensity.target(20/2);

    float randomDir = random(1);
    lightPoints.add(newLight);
    
    if(danceNum != 0)
    {
      if(lightPoints.size() > danceNum)
      {
        for(int i = 0; i < lightPoints.size(); i++)
        {
          lightPoints.get(i).velocity.mult(-1);
        }
      }
    }
    
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
    if(lightPoints.get(i).location.y + 10 > outerSize/2)
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
    
    if(y == -outerSize/2)
    {
      if((x > outerSize/2 || x < -outerSize/2 || z > outerSize/2 || z < -outerSize/2))
      {
        float check = random(1);
        if(check < 0.5)
        {
          myLight.velocity = new PVector(0, speed, 0);
        }
        else
        {
          myLight.velocity = new PVector(-speed * x/(outerSize/2), speed, -speed * z/(outerSize/2));
        }
      }
    }
    else if((y > -(innerSize/2+3) && y < -(innerSize/2-3)) && (LEDs[myLight.nearestLEDIndex].inside || LEDs[myLight.nearestLEDIndex].connections) && (x > innerSize/2 || x < -innerSize/2 || z > innerSize/2 || z < -innerSize/2))
    {
      float check = random(1);
      if(check < 0.33)
      {
        myLight.velocity = new PVector(0, speed, 0);
      }
      else if(check > 0.66)
      {
        myLight.velocity = new PVector(-speed * x/(innerSize/2), 0, 0);
      }
      else
      {
        myLight.velocity = new PVector(0, 0, -speed * z/(innerSize/2));
      }
    }
    else if((y < innerSize/2+3 && y > innerSize/2-3) && (LEDs[myLight.nearestLEDIndex].inside || LEDs[myLight.nearestLEDIndex].connections) && (x > innerSize/2 || x < -innerSize/2 || z > innerSize/2 || z < -innerSize/2))
    {
      float check = random(1);
      if(check < 0.33)
      {
        myLight.velocity = new PVector(speed * x/(innerSize/2), speed, speed * z/(innerSize/2));      
      }
      else if(check > 0.66)
      {
        myLight.velocity = new PVector(-speed * x/(innerSize/2), 0, 0);
      }
      else
      {
        myLight.velocity = new PVector(0, 0, -speed * z/(innerSize/2));
      }
    }
    
    myLight.update();
    myLight.findNearestLED();
  }
}

void evenEqualizerSetup()
{
  lightBlock blockHor1 = new lightBlock(0, outerSize/2, 0, 10, 10, outerSize+50);
  lightBlock blockHor2 = new lightBlock(0, -outerSize/2, 0, 10, 10, outerSize+50);
  lightBlock blockHor3 = new lightBlock(0, innerSize/2, 0, 10, 10, outerSize+50);
  lightBlock blockHor4 = new lightBlock(0, -innerSize/2, 0, 10, 10, outerSize+50);
  
  lightBlock blockHor5 = new lightBlock(0, outerSize/2, 0, outerSize+50, 10, 10);
  lightBlock blockHor6 = new lightBlock(0, -outerSize/2, 0, outerSize+50, 10, 10);
  lightBlock blockHor7 = new lightBlock(0, innerSize/2, 0, outerSize+50, 10, 10);
  lightBlock blockHor8 = new lightBlock(0, -innerSize/2, 0, outerSize+50, 10, 10);
  
  lightBlock blockVert1 = new lightBlock(outerSize/2, 0, 0, 10, 10, outerSize+50);
  lightBlock blockVert2 = new lightBlock(-outerSize/2, 0, 0, 10, 10, outerSize+50);
  lightBlock blockVert3 = new lightBlock(innerSize/2, 0, 0, 10, 10, outerSize+50);
  lightBlock blockVert4 = new lightBlock(-innerSize/2, 0, 0, 10, 10, outerSize+50);

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
    float blockHeight = map(centerFrequency, 0, 20, 0, outerSize);
    lightBlocks.get(i).w.target(blockHeight);
    lightBlocks.get(i).w.update();
  }
  for(int i = 4; i < 8; i++)
  {
    //float max = map(i-4, 0, 15, 2, 0.01);
    float centerFrequency = fft.getAvg(0);
    float blockHeight = map(centerFrequency, 0, 20, 0, outerSize);
    lightBlocks.get(i).d.target(blockHeight);
    lightBlocks.get(i).d.update();
  }
  for(int i = 8; i < 12; i++)
  {
    //float max = map(i-8, 0, 12, 2, 0.01);
    float centerFrequency = fft.getAvg(0);
    float blockHeight = map(centerFrequency, 0, 20, 0, outerSize);
    lightBlocks.get(i).h.target(blockHeight);
    lightBlocks.get(i).h.update();
  }
}

void whirlwindSetup()
{
  lightBlock block1 = new lightBlock(0, outerSize/2 + 10, outerSize/2, outerSize + 50, 0, 10);
  lightBlock block2 = new lightBlock(outerSize/2, outerSize/2 + 10, 0, 10, 0, outerSize + 50);
  lightBlock block3 = new lightBlock(0, outerSize/2 + 10, -outerSize/2, outerSize + 50, 0, 10);
  lightBlock block4 = new lightBlock(-outerSize/2, outerSize/2 + 10, 0, 10, 0, outerSize + 50);
  lightBlocks.add(block1);
  lightBlocks.add(block2);
  lightBlocks.add(block3);
  lightBlocks.add(block4);
  
  lightBlock block5 = new lightBlock(0, outerSize/2 + 10, innerSize/2, innerSize + 50, 0, 10);
  lightBlock block6 = new lightBlock(innerSize/2, outerSize/2 + 10, 0, 10, 0, innerSize + 50);
  lightBlock block7 = new lightBlock(0, outerSize/2 + 10, -innerSize/2, innerSize + 50, 0, 10);
  lightBlock block8 = new lightBlock(-innerSize/2, outerSize/2 + 10, 0, 10, 0, innerSize + 50);
  lightBlocks.add(block5);
  lightBlocks.add(block6);
  lightBlocks.add(block7);
  lightBlocks.add(block8);
  
  whirlwindStep = 1000;
}

void whirlwindRun()
{
  if(millis() - savedTime > whirlwindStep)
  {
    int litOuterBlockIndex = 1;
    int litInnerBlockIndex = 1;
    
    for(int i = 0; i < 4; i++)
    {
      if(lightBlocks.get(i).h.value > 1)
      {
        lightBlocks.get(i).h.value = 1;
        litOuterBlockIndex = i;
      }
    }
    litOuterBlockIndex += 1;
    litOuterBlockIndex %= 4;
    lightBlocks.get(litOuterBlockIndex).h.value = outerSize * 5 + 10;
    
    for(int i = 4; i < 8; i++)
    {
      if(lightBlocks.get(i).h.value > 1)
      {
        lightBlocks.get(i).h.value = 1;
        litInnerBlockIndex = i;
      }
    }
    litInnerBlockIndex -= 1;
    litInnerBlockIndex %= 4;
    litInnerBlockIndex += 4;
    lightBlocks.get(litInnerBlockIndex).h.value = outerSize * 2 + 10;
    
    savedTime = millis();
  }
  if(beat.isKick())
  {
    whirlwindStep *= 0.95;
    whirlwindStep = max(1, whirlwindStep);
  }
}

lightBlock[] climbOnSetup()
{
  int midLoc = int(outerSize/2 - (outerSize/2 - innerSize/2)/2);
  int midSize = int(outerSize/2 - innerSize/2);
  lightBlock[] setupArray = new lightBlock[32];
  setupArray[0] = new lightBlock(0, outerSize/2, outerSize/2, outerSize + 10, 10, 10);
  setupArray[1] = new lightBlock(outerSize/2, outerSize/2, 0, 10, 10, outerSize + 10);
  setupArray[2] = new lightBlock(outerSize/2, 0, outerSize/2, 10, outerSize + 10, 10);
  setupArray[3] = new lightBlock(midLoc, midLoc, midLoc, midSize, midSize, midSize);
  setupArray[4] = new lightBlock(0, innerSize/2, innerSize/2, innerSize + 10, 10, 10);
  setupArray[5] = new lightBlock(innerSize/2, innerSize/2, 0, 10, 10, innerSize + 10);
  setupArray[6] = new lightBlock(innerSize/2, 0, innerSize/2, 10, innerSize + 10, 10);
  setupArray[7] = new lightBlock(-innerSize/2, innerSize/2, 0, 10, 10, innerSize + 10);
  setupArray[8] = new lightBlock(-innerSize/2, 0, innerSize/2, 10, innerSize + 10, 10);
  setupArray[9] = new lightBlock(-midLoc, midLoc, midLoc, midSize, midSize, midSize);
  setupArray[10] = new lightBlock(-outerSize/2, outerSize/2, 0, 10, 10, outerSize + 10);
  setupArray[11] = new lightBlock(-midLoc, midLoc, -midLoc, midSize, midSize, midSize);
  setupArray[12] = new lightBlock(0, outerSize/2, -outerSize/2, outerSize + 10, 10, 10);
  setupArray[13] = new lightBlock(-outerSize/2, 0, outerSize/2, 10, outerSize + 10, 10);
  setupArray[14] = new lightBlock(0, -innerSize/2, innerSize/2, innerSize + 10, 10, 10);
  setupArray[15] = new lightBlock(outerSize/2, -outerSize/2, 0, 10, 10, outerSize + 10);
  setupArray[16] = new lightBlock(innerSize/2, -innerSize/2, 0, 10, 10, innerSize + 10);
  setupArray[17] = new lightBlock(midLoc, midLoc, -midLoc, midSize, midSize, midSize);
  setupArray[18] = new lightBlock(innerSize/2, 0, -innerSize/2, 10, innerSize + 10, 10);
  setupArray[19] = new lightBlock(0, innerSize/2, -innerSize/2, innerSize + 10, 10, 10);
  setupArray[20] = new lightBlock(0, -outerSize/2, outerSize/2, outerSize + 10, 10, 10);
  setupArray[21] = new lightBlock(outerSize/2, 0, -outerSize/2, 10, outerSize + 10, 10);
  setupArray[22] = new lightBlock(midLoc, -midLoc, midLoc, midSize, midSize, midSize);
  setupArray[23] = new lightBlock(midLoc, -midLoc, -midLoc, midSize, midSize, midSize);
  setupArray[24] = new lightBlock(0, -outerSize/2, -outerSize/2, outerSize + 10, 10, 10);
  setupArray[25] = new lightBlock(-innerSize/2, 0, -innerSize/2, 10, innerSize + 10, 10);
  setupArray[26] = new lightBlock(-midLoc, -midLoc, midLoc, midSize, midSize, midSize);
  setupArray[27] = new lightBlock(-innerSize/2, -innerSize/2, 0, 10, 10, innerSize + 10);
  setupArray[28] = new lightBlock(0, -innerSize/2, -innerSize/2, innerSize + 10, 10, 10);
  setupArray[29] = new lightBlock(-outerSize/2, -outerSize/2, 0, 10, 10, outerSize + 10);
  setupArray[30] = new lightBlock(-midLoc, -midLoc, -midLoc, midSize, midSize, midSize);
  setupArray[31] = new lightBlock(-outerSize/2, 0, -outerSize/2, 10, outerSize + 10, 10);
  return setupArray;
}

void climbOnRun(lightBlock[] climbOnBlocks, boolean climbOn)
{ 
  if(beat.isKick())
  {
    if(climbOn)
    {
      int sideChoice = int(random(0, 32));
      if(!lightBlocks.contains(climbOnBlocks[sideChoice]))
      {
        lightBlocks.add(climbOnBlocks[sideChoice]);
      }
      else
      {
        climbOnRun(climbOnBlocks, climbOn);
      }
    }
    else
    {
      lightBlocks.remove(0);
    }
  }
}

void novaSetup()
{
  lightPoint centerPoint = new lightPoint(0, 0, 0, color(255), 10/2);
  centerPoint.intensity.attraction  = 1.0;
  centerPoint.intensity.damping = 0.45;
  lightPoints.add(centerPoint);
}

void novaRun(float newMinLight)
{
  lightPoint lightSource = lightPoints.get(0);
  float average = fft.getAvg(0);
  float newIntensity = map(average, 0, 5, newMinLight, outerSize);
  newIntensity = max(newMinLight, newIntensity);
  lightSource.intensity.target(newIntensity/2);
  lightSource.intensity.update();
  newMinLight++;
}
