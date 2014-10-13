class lightPoint
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  boolean pulsing;
  
  float initIntensity;

  color lightColor;
  Integrator intensity;
  int nearestLEDIndex;
  boolean wobInit = true;
  
  public lightPoint(PVector newLocation, color newLightColor, float newIntensity)
  {
    location = newLocation.get();
    lightColor = newLightColor;
    intensity = new Integrator(newIntensity);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    pulsing = false;
  }
  
  public lightPoint(float x, float y, float z, color newLightColor, float newIntensity)
  {
    location = new PVector(x, y, z);
    lightColor = newLightColor;
    intensity = new Integrator(newIntensity);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
  }
  
  public lightPoint(int newLEDIndex, color newLightColor, float newIntensity)
  {
    location = LEDs[newLEDIndex].tesLoc.get();
    nearestLEDIndex = newLEDIndex;
    lightColor = newLightColor;
    intensity = new Integrator(newIntensity);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
  }
  
  public lightPoint(LED newLED, color newLightColor, float newIntensity)
  {
    location = newLED.tesLoc.get();
    lightColor = newLightColor;
    intensity = new Integrator(newIntensity);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
  }
  
  void display(PGraphics src)
  {
    src.pushMatrix();
    src.translate(location.x, location.y, location.z);
    src.noFill();
    src.stroke(lightColor);
    src.rotateY(frameCount * 0.005f);
    src.sphere(intensity.value);
    src.popMatrix();
  }
  
  //move the light
  void move()
  {
    velocity.add(acceleration);
    velocity.limit(5);
    location.add(velocity);
  }
  
  //Bounces off of the edges of the cube, only good for points stuck on the cube
  void checkOuterEdges()
  {
    float x = location.x;
    float y = location.y;
    float z = location.z;
    
    if(x > outerSize/2)
    {
      location.x = outerSize/2;
      velocity.x *= -1;
    }
    else if(x < -outerSize/2)
    {
      location.x = -outerSize/2;
      velocity.x *= -1;
    }
    if(y > outerSize/2)
    {
      location.y = outerSize/2;
      velocity.y *= -1;
    }
    else if(y < -outerSize/2)
    {
      location.y = -outerSize/2;
      velocity.y *= -1;
    }
    if(z > outerSize/2)
    {
      location.z = outerSize/2;
      velocity.z *= -1;
    }
    else if(z < -outerSize/2)
    {
      location.z = -outerSize/2;
      velocity.z *= -1;
    }
  }
  
  void checkInnerEdges()
  {
    float x = location.x;
    float y = location.y;
    float z = location.z;
    
    if(x > 50)
    {
      location.x = 50;
      velocity.x *= -1;
    }
    else if(x < -50)
    {
      location.x = -50;
      velocity.x *= -1;
    }
    if(y > 100)
    {
      location.y = 50;
      velocity.y *= -1;
    }
    else if(y < -50)
    {
      location.y = -50;
      velocity.y *= -1;
    }
    if(z > 100)
    {
      location.z = 50;
      velocity.z *= -1;
    }
    else if(z < -50)
    {
      location.z = -50;
      velocity.z *= -1;
    }
  }
  
  //To be called once, looks through all points to find the nearest LED
  void findNearestLED()
  {
    float minDistance = MAX_FLOAT;
    for(int i = 0; i < LEDs.length; i++)
    {
      LED myLED = LEDs[i];
      float dist = dist(location.x, location.y, location.z, myLED.tesLoc.x, myLED.tesLoc.y, myLED.tesLoc.z);
      if(dist < minDistance)
      {
        minDistance = dist;
        nearestLEDIndex = i;
      }
    }
  }
  
  void updateNearestLED()
  {
    float lightX, lightY, lightZ;
    float currentX, currentY, currentZ;
    float nextX, nextY, nextZ;
    float lastX, lastY, lastZ;
    
    lightX = location.x;
    lightY = location.y;
    lightZ = location.z;
    
    LED currentLED = LEDs[nearestLEDIndex];
    LED nextLED = LEDs[currentLED.nextLEDIndex];
    LED lastLED = LEDs[currentLED.lastLEDIndex];

    currentX = currentLED.tesLoc.x;
    currentY = currentLED.tesLoc.y;
    currentZ = currentLED.tesLoc.z;
    
    nextX = nextLED.tesLoc.x;
    nextY = nextLED.tesLoc.y;
    nextZ = nextLED.tesLoc.z;
    
    lastX = lastLED.tesLoc.x;
    lastY = lastLED.tesLoc.y;
    lastZ = lastLED.tesLoc.z;
    
    if(currentLED.isCorner)
    {
      float distToCurrent = dist(lightX, lightY, lightZ, currentX, currentY, currentZ);
      float distToNext = dist(lightX, lightY, lightZ, nextX, nextY, nextZ);
      float distToLast = dist(lightX, lightY, lightZ, lastX, lastY, lastZ);
      
      LED cornerLEDs[] = new LED[3];
      for(int i = 0; i < 3; i++)
      {
        cornerLEDs[i] = LEDs[currentLED.cornerIndices[i]];
      }
      
      float[] distToCorner = new float[3];
      for(int i = 0; i < 3; i++)
      {
        distToCorner[i] = dist(lightX, lightY, lightZ, cornerLEDs[i].tesLoc.x, cornerLEDs[i].tesLoc.y, cornerLEDs[i].tesLoc.z);
      }
      float minDist = min(distToCurrent, distToNext, distToLast);
      float minDistToCorners = min(distToCorner);
      if(minDistToCorners < minDist)
      {
        minDist = minDistToCorners;
      }
      if (minDist == distToNext)
      {
        nearestLEDIndex = nextLED.LEDIndex;
      }
      else if (minDist == distToLast)
      {
        nearestLEDIndex = lastLED.LEDIndex;
      }
      else if (minDist == distToCorner[0])
      {
        nearestLEDIndex = cornerLEDs[0].LEDIndex;
      }
      else if (minDist == distToCorner[1])
      {
        nearestLEDIndex = cornerLEDs[1].LEDIndex;
      }
      else if (minDist == distToCorner[2])
      {
        nearestLEDIndex = cornerLEDs[2].LEDIndex;
      }
    }
    else
    {
      float distToCurrent = dist(lightX, lightY, lightZ, currentX, currentY, currentZ);
      float distToNext = dist(lightX, lightY, lightZ, nextX, nextY, nextZ);
      float distToLast = dist(lightX, lightY, lightZ, lastX, lastY, lastZ);
      float minDist = min(distToCurrent, distToNext, distToLast);
      
      if (minDist == distToNext)
      {
        nearestLEDIndex = nextLED.LEDIndex;
      }
      else if (minDist == distToLast)
      {
        nearestLEDIndex = lastLED.LEDIndex;
      }
    }
  }
  
  void update()
  {
    intensity.update();
  }
  
  void setColor(color newColor)
  {
    lightColor = newColor;
  }
}


