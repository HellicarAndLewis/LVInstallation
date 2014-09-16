class lightPoint
{
  PVector location;
  PVector velocity;
  PVector acceleration;

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
    location = LEDs[newLEDIndex].realLocation.get();
    nearestLEDIndex = newLEDIndex;
    lightColor = newLightColor;
    intensity = new Integrator(newIntensity);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
  }
  
  public lightPoint(LED newLED, color newLightColor, float newIntensity)
  {
    location = newLED.realLocation.get();
    lightColor = newLightColor;
    intensity = new Integrator(newIntensity);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
  }
  
  void display(float x, float y, float z)
  {
    pushMatrix();
    noStroke();
    translate(x, y, z);
    translate(location.x, location.y, location.z);
    fill(lightColor, 100);
    sphere(intensity.value);
    popMatrix();
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
    
    if(x > 100)
    {
      location.x = 100;
      velocity.x *= -1;
    }
    else if(x < -100)
    {
      location.x = -100;
      velocity.x *= -1;
    }
    if(y > 100)
    {
      location.y = 100;
      velocity.y *= -1;
    }
    else if(y < -100)
    {
      location.y = -100;
      velocity.y *= -1;
    }
    if(z > 100)
    {
      location.z = 100;
      velocity.z *= -1;
    }
    else if(z < -100)
    {
      location.z = -100;
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
      float dist = dist(location.x, location.y, location.z, myLED.realLocation.x, myLED.realLocation.y, myLED.realLocation.z);
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

    currentX = currentLED.realLocation.x;
    currentY = currentLED.realLocation.y;
    currentZ = currentLED.realLocation.z;
    
    nextX = nextLED.realLocation.x;
    nextY = nextLED.realLocation.y;
    nextZ = nextLED.realLocation.z;
    
    lastX = lastLED.realLocation.x;
    lastY = lastLED.realLocation.y;
    lastZ = lastLED.realLocation.z;
    
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
        distToCorner[i] = dist(lightX, lightY, lightZ, cornerLEDs[i].realLocation.x, cornerLEDs[i].realLocation.y, cornerLEDs[i].realLocation.z);
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
  
  void wobble(float a, float b)
  {
    if(intensity.value >= b)
    {
      intensity.target(a);
      intensity.update();
    }
    else if(intensity.value <= a)
    {
      intensity.target(b);
      intensity.update();
    }
  }
}


