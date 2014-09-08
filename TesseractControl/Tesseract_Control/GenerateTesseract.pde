void generateTesseract()
{
  //Set Lights Per Strip
  int lightsPerStripOutside = 24;
  int lightsPerStripInside = 9;
  int lightsPerStripConnections = 8;
  
  //Set Side Lengths
  float sideLengthOutside = 200;
  float sideLengthInside = 100;
  float sideLengthConnections = 50;
  
  //Set Corner Gaps
  float gap = 10;
  
  sideLengthOutside -= gap;
  sideLengthInside -= gap;
  sideLengthConnections -= gap;
  
  //GenerateSpacingVectors
  PVector spacingVectorsOutsideX = new PVector(sideLengthOutside/lightsPerStripOutside, 0, 0);
  PVector spacingVectorsOutsideY = new PVector(0, sideLengthOutside/lightsPerStripOutside, 0);
  PVector spacingVectorsOutsideZ = new PVector(0, 0, sideLengthOutside/lightsPerStripOutside);

  PVector spacingVectorsInsideX = new PVector(sideLengthInside/lightsPerStripInside, 0, 0);
  PVector spacingVectorsInsideY = new PVector(0, sideLengthInside/lightsPerStripInside, 0);
  PVector spacingVectorsInsideZ = new PVector(0, 0, sideLengthInside/lightsPerStripInside);
 
  PVector spacingVectorsConnectionsX = new PVector(sideLengthConnections/lightsPerStripConnections, 0, 0);
  PVector spacingVectorsConnectionsY = new PVector(0, sideLengthConnections/lightsPerStripConnections, 0);
  PVector spacingVectorsConnectionsZ = new PVector(0, 0, sideLengthConnections/lightsPerStripConnections);
  
  //Generate All Vertices
  PVector vertexA = new PVector(100, 100, 100);
  PVector vertexB = new PVector(-100, 100, 100);
  PVector vertexC = new PVector(-100, 100, -100);
  PVector vertexD = new PVector(100, 100, -100);
  PVector vertexE = new PVector(100, -100, 100);
  PVector vertexF = new PVector(-100, -100, 100);
  PVector vertexG = new PVector(-100, -100, -100);
  PVector vertexH = new PVector(100, -100, -100);
  
  PVector vertexJ = new PVector(50, 50, 50);
  PVector vertexK = new PVector(-50, 50, 50);
  PVector vertexL = new PVector(-50, 50, -50);
  PVector vertexM = new PVector(50, 50, -50);
  PVector vertexN = new PVector(50, -50, 50);
  PVector vertexP = new PVector(-50, -50, 50);
  PVector vertexQ = new PVector(-50, -50, -50);
  PVector vertexR = new PVector(50, -50, -50);
  
  //Dummy mapLocation Variable to be set later because generating an LED wants a map location too
  PVector mapLocation = new PVector(0, 0);
  
  //initialize LED index
  int LEDindex = 0;
  int cornerLEDIndex = 0;
  
  //Begin generating Tesseract in order of wiring
  //-----------------------ENTRY A-----------------------
  
  //A to B
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideX, i);
    PVector newRealLocation = PVector.sub(vertexA, newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideX);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0 || i == lightsPerStripOutside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //B to C
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideZ, i);
    PVector newRealLocation = PVector.sub(vertexB, newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0 || i == lightsPerStripOutside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //A to E
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideY, i);
    PVector newRealLocation = PVector.sub(vertexA, newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideY);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    setTesseractMap(newLED);
    if(i == 0 || i == lightsPerStripOutside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //E to H
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideZ, i);
    PVector newRealLocation = PVector.sub(vertexE, newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0 || i == lightsPerStripOutside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //B to K
  for(int i = 0; i < lightsPerStripConnections; i++)
  {
    PVector newSpacingVectorX = PVector.mult(spacingVectorsConnectionsX, i);
    PVector newSpacingVectorY = PVector.mult(spacingVectorsConnectionsY, i);
    PVector newSpacingVectorZ = PVector.mult(spacingVectorsConnectionsZ, i);
    
    PVector newRealLocation = PVector.add(vertexB, newSpacingVectorX);
    newRealLocation.sub(newSpacingVectorY);
    newRealLocation.sub(newSpacingVectorZ);
    newRealLocation.add(spacingVectorsConnectionsX);
    newRealLocation.add(spacingVectorsConnectionsX);
    newRealLocation.sub(spacingVectorsConnectionsY);
    newRealLocation.sub(spacingVectorsConnectionsY);
    newRealLocation.sub(spacingVectorsConnectionsZ);
    newRealLocation.sub(spacingVectorsConnectionsZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.connections = true;
    if(i == 0 || i == lightsPerStripConnections - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //K to P
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideY, i);
    PVector newRealLocation = PVector.sub(vertexK, newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideY);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0 || i == lightsPerStripInside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //P to F
  for(int i = 0; i < lightsPerStripConnections; i++)
  {
    PVector newSpacingVectorX = PVector.mult(spacingVectorsConnectionsX, i);
    PVector newSpacingVectorY = PVector.mult(spacingVectorsConnectionsY, i);
    PVector newSpacingVectorZ = PVector.mult(spacingVectorsConnectionsZ, i);
    
    PVector newRealLocation = PVector.sub(vertexP, newSpacingVectorX);
    newRealLocation.sub(newSpacingVectorY);
    newRealLocation.add(newSpacingVectorZ);
    newRealLocation.sub(spacingVectorsConnectionsX);
    newRealLocation.sub(spacingVectorsConnectionsY);
    newRealLocation.add(spacingVectorsConnectionsZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.connections = true;
    if(i == 0 || i == lightsPerStripConnections - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //-----------------------ENTRY D-----------------------
  
  //D to C
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideX, i);
    PVector newRealLocation = PVector.sub(vertexD, newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideX);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0 || i == lightsPerStripOutside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //C to G
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideY, i);
    PVector newRealLocation = PVector.sub(vertexC, newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideY);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0 || i == lightsPerStripOutside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //C to L
  for(int i = 0; i < lightsPerStripConnections; i++)
  {
    PVector newSpacingVectorX = PVector.mult(spacingVectorsConnectionsX, i);
    PVector newSpacingVectorY = PVector.mult(spacingVectorsConnectionsY, i);
    PVector newSpacingVectorZ = PVector.mult(spacingVectorsConnectionsZ, i);
    
    PVector newRealLocation = PVector.add(vertexC, newSpacingVectorX);
    newRealLocation.sub(newSpacingVectorY);
    newRealLocation.add(newSpacingVectorZ);
    newRealLocation.add(spacingVectorsConnectionsX);
    newRealLocation.add(spacingVectorsConnectionsX);
    newRealLocation.sub(spacingVectorsConnectionsY);
    newRealLocation.sub(spacingVectorsConnectionsY);
    newRealLocation.add(spacingVectorsConnectionsZ);
    newRealLocation.add(spacingVectorsConnectionsZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.connections = true;
    if(i == 0 || i == lightsPerStripConnections - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //L to Q
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideY, i);
    PVector newRealLocation = PVector.sub(vertexL, newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideY);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0 || i == lightsPerStripInside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //Q to G
  for(int i = 0; i < lightsPerStripConnections; i++)
  {
    PVector newSpacingVectorX = PVector.mult(spacingVectorsConnectionsX, i);
    PVector newSpacingVectorY = PVector.mult(spacingVectorsConnectionsY, i);
    PVector newSpacingVectorZ = PVector.mult(spacingVectorsConnectionsZ, i);
    
    PVector newRealLocation = PVector.sub(vertexQ, newSpacingVectorX);
    newRealLocation.sub(newSpacingVectorY);
    newRealLocation.sub(newSpacingVectorZ);
    newRealLocation.sub(spacingVectorsConnectionsX);
    newRealLocation.sub(spacingVectorsConnectionsY);
    newRealLocation.sub(spacingVectorsConnectionsZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.connections = true;
    if(i == 0 || i == lightsPerStripConnections - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //M to L
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideX, i);
    PVector newRealLocation = PVector.sub(vertexM, newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideX);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0 || i == lightsPerStripInside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //L to K
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideZ, i);
    PVector newRealLocation = PVector.add(vertexL, newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0 || i == lightsPerStripInside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //K to J
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideX, i);
    PVector newRealLocation = PVector.add(vertexK, newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideX);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0 || i == lightsPerStripInside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //J to M
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideZ, i);
    PVector newRealLocation = PVector.sub(vertexJ, newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0 || i == lightsPerStripInside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //-----------------------ENTRY E-----------------------
  
  //E to F
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideX, i);
    PVector newRealLocation = PVector.sub(vertexE, newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideX);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0 || i == lightsPerStripOutside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //F to B
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideY, i);
    PVector newRealLocation = PVector.add(vertexF, newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideY);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0 || i == lightsPerStripOutside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //E to N
  for(int i = 0; i < lightsPerStripConnections; i++)
  {
    PVector newSpacingVectorX = PVector.mult(spacingVectorsConnectionsX, i);
    PVector newSpacingVectorY = PVector.mult(spacingVectorsConnectionsY, i);
    PVector newSpacingVectorZ = PVector.mult(spacingVectorsConnectionsZ, i);
    
    PVector newRealLocation = PVector.sub(vertexE, newSpacingVectorX);
    newRealLocation.add(newSpacingVectorY);
    newRealLocation.sub(newSpacingVectorZ);
    newRealLocation.sub(spacingVectorsConnectionsX);
    newRealLocation.sub(spacingVectorsConnectionsX);
    newRealLocation.add(spacingVectorsConnectionsY);
    newRealLocation.add(spacingVectorsConnectionsY);
    newRealLocation.sub(spacingVectorsConnectionsZ);
    newRealLocation.sub(spacingVectorsConnectionsZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.connections = true;
    if(i == 0 || i == lightsPerStripConnections - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //N to J
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideY, i);
    PVector newRealLocation = PVector.add(vertexN, newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideY);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0 || i == lightsPerStripInside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //J to A
  for(int i = 0; i < lightsPerStripConnections; i++)
  {
    PVector newSpacingVectorX = PVector.mult(spacingVectorsConnectionsX, i);
    PVector newSpacingVectorY = PVector.mult(spacingVectorsConnectionsY, i);
    PVector newSpacingVectorZ = PVector.mult(spacingVectorsConnectionsZ, i);
    
    PVector newRealLocation = PVector.add(vertexJ, newSpacingVectorX);
    newRealLocation.add(newSpacingVectorY);
    newRealLocation.add(newSpacingVectorZ);
    newRealLocation.add(spacingVectorsConnectionsX);
    newRealLocation.add(spacingVectorsConnectionsY);
    newRealLocation.add(spacingVectorsConnectionsZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.connections = true;
    if(i == 0 || i == lightsPerStripConnections - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //N to P
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideX, i);
    PVector newRealLocation = PVector.sub(vertexN, newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideX);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0 || i == lightsPerStripInside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //P to Q
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideZ, i);
    PVector newRealLocation = PVector.sub(vertexP, newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0 || i == lightsPerStripInside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //Q to R
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideX, i);
    PVector newRealLocation = PVector.add(vertexQ, newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideX);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0 || i == lightsPerStripInside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //R to N
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideZ, i);
    PVector newRealLocation = PVector.add(vertexR, newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0 || i == lightsPerStripInside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //-----------------------ENTRY H-----------------------
  
  //H to D
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideY, i);
    PVector newRealLocation = PVector.add(vertexH, newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideY);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0 || i == lightsPerStripOutside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //D to A
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideZ, i);
    PVector newRealLocation = PVector.add(vertexD, newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0 || i == lightsPerStripOutside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //H to G
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideX, i);
    PVector newRealLocation = PVector.sub(vertexH, newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideX);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0 || i == lightsPerStripOutside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //G to F
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideZ, i);
    PVector newRealLocation = PVector.add(vertexG, newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0 || i == lightsPerStripOutside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //H to R
  for(int i = 0; i < lightsPerStripConnections; i++)
  {
    PVector newSpacingVectorX = PVector.mult(spacingVectorsConnectionsX, i);
    PVector newSpacingVectorY = PVector.mult(spacingVectorsConnectionsY, i);
    PVector newSpacingVectorZ = PVector.mult(spacingVectorsConnectionsZ, i);
    
    PVector newRealLocation = PVector.sub(vertexH, newSpacingVectorX);
    newRealLocation.add(newSpacingVectorY);
    newRealLocation.add(newSpacingVectorZ);
    newRealLocation.sub(spacingVectorsConnectionsX);
    newRealLocation.sub(spacingVectorsConnectionsX);
    newRealLocation.add(spacingVectorsConnectionsY);
    newRealLocation.add(spacingVectorsConnectionsY);
    newRealLocation.add(spacingVectorsConnectionsZ);
    newRealLocation.add(spacingVectorsConnectionsZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.connections = true;
    if(i == 0 || i == lightsPerStripConnections - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //R to M
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideY, i);
    PVector newRealLocation = PVector.add(vertexR, newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideY);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0 || i == lightsPerStripInside - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //M to D
  for(int i = 0; i < lightsPerStripConnections; i++)
  {
    PVector newSpacingVectorX = PVector.mult(spacingVectorsConnectionsX, i);
    PVector newSpacingVectorY = PVector.mult(spacingVectorsConnectionsY, i);
    PVector newSpacingVectorZ = PVector.mult(spacingVectorsConnectionsZ, i);
    
    PVector newRealLocation = PVector.add(vertexM, newSpacingVectorX);
    newRealLocation.add(newSpacingVectorY);
    newRealLocation.sub(newSpacingVectorZ);
    newRealLocation.add(spacingVectorsConnectionsX);
    newRealLocation.add(spacingVectorsConnectionsY);
    newRealLocation.sub(spacingVectorsConnectionsZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.connections = true;
    if(i == 0 || i == lightsPerStripConnections - 1)
    {
      newLED.corner = true;
      cornerLEDs[cornerLEDIndex] = newLED;
      cornerLEDIndex++;
    }
    else
    {
      newLED.nextLEDIndex = i+1;
      newLED.lastLEDIndex= i-1;
    }
    setTesseractMap(newLED);
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
}

//Generate the Tesseract 2D map locations (used to replace dummy variables)
void setTesseractMap(LED myLED)
{
  pushMatrix();
  translate(width/2, height/2);
  if(myLED.outside)
  {
    if(myLED.realLocation.z > 99)
    {
      PVector newMapLocation = new PVector(myLED.realLocation.x, myLED.realLocation.y);
      newMapLocation.rotate(HALF_PI/2);
      newMapLocation.x -= 150;
      newMapLocation.y -= 150;
      newMapLocation.x += width/2;
      newMapLocation.y += height/2;
      newMapLocation.x = int(newMapLocation.x);
      newMapLocation.y = int(newMapLocation.y);
      myLED.setMapLocation(newMapLocation);
    }
    else if(myLED.realLocation.z > -99)
    {
      PVector newMapLocation = new PVector(myLED.realLocation.x, myLED.realLocation.y);
      newMapLocation.rotate(HALF_PI/2);
      float scale = map(myLED.realLocation.z, -99, 99, 2.5, 1);
      newMapLocation.mult(abs(scale));
      newMapLocation.x -= 150;
      newMapLocation.y -= 150;
      newMapLocation.x += width/2;
      newMapLocation.y += height/2;
      newMapLocation.x = int(newMapLocation.x);
      newMapLocation.y = int(newMapLocation.y);
      //int dif = 
      myLED.setMapLocation(newMapLocation);
    }
    else
    {
      PVector newMapLocation = new PVector(myLED.realLocation.x, myLED.realLocation.y);
      newMapLocation.rotate(HALF_PI/2);
      newMapLocation.x = int(newMapLocation.x);
      newMapLocation.y = int(newMapLocation.y);
      int dif  = 0 - (int)newMapLocation.x;
      newMapLocation.x += 2*dif;
      newMapLocation.x += 350;
      newMapLocation.y -= 150;
      newMapLocation.x += (int)width/2;
      newMapLocation.y += (int)height/2;
      newMapLocation.x = int(newMapLocation.x);
      newMapLocation.y = int(newMapLocation.y);
      myLED.setMapLocation(newMapLocation);
    }
  }
  else if(myLED.inside)
  {
    if(myLED.realLocation.z > 49)
    {
      PVector newMapLocation = new PVector(myLED.realLocation.x, myLED.realLocation.y);
      newMapLocation.rotate(HALF_PI/2);
      newMapLocation.x -= 225;
      newMapLocation.y += 300;
      newMapLocation.x += width/2;
      newMapLocation.y += height/2;
      newMapLocation.x = int(newMapLocation.x);
      newMapLocation.y = int(newMapLocation.y);
      myLED.setMapLocation(newMapLocation);
    }
    else if(myLED.realLocation.z > -49)
    {
      PVector newMapLocation = new PVector(myLED.realLocation.x, myLED.realLocation.y);
      newMapLocation.rotate(HALF_PI/2);
      float scale = map(myLED.realLocation.z, -49, 49, 2.5, 1);
      newMapLocation.mult(abs(scale));
      newMapLocation.x = int(newMapLocation.x);
      newMapLocation.y = int(newMapLocation.y);
      int dif  = 0 - (int)newMapLocation.x;
      newMapLocation.x += 2*dif;
      newMapLocation.x -= 225;
      newMapLocation.y += 300;
      newMapLocation.x += width/2;
      newMapLocation.y += height/2;
      myLED.setMapLocation(newMapLocation);
    }
    else
    {
      PVector newMapLocation = new PVector(myLED.realLocation.x, myLED.realLocation.y);
      newMapLocation.rotate(HALF_PI/2);
      newMapLocation.x += 25;
      newMapLocation.y += 300;
      newMapLocation.x += width/2;
      newMapLocation.y += height/2;
      newMapLocation.x = int(newMapLocation.x);
      newMapLocation.y = int(newMapLocation.y);
      myLED.setMapLocation(newMapLocation);
    }
  }
  else if(myLED.connections)
  {
    if(myLED.realLocation.z > 0)
    {
      PVector newMapLocation = new PVector(myLED.realLocation.x, myLED.realLocation.y);
      newMapLocation.rotate(HALF_PI/2);
      newMapLocation.x -= 150;
      newMapLocation.y -= 150;
      newMapLocation.x += width/2;
      newMapLocation.y += height/2;
      newMapLocation.x = int(newMapLocation.x);
      newMapLocation.y = int(newMapLocation.y);
      myLED.setMapLocation(newMapLocation);
    }
    else
    {
      PVector newMapLocation = new PVector(myLED.realLocation.x, myLED.realLocation.y);
      newMapLocation.rotate(HALF_PI/2);
      newMapLocation.x = int(newMapLocation.x);
      newMapLocation.y = int(newMapLocation.y);
      int dif  = 0 - (int)newMapLocation.x;
      newMapLocation.x += 2*dif;
      newMapLocation.x += 350;
      newMapLocation.y -= 150;
      newMapLocation.x += width/2;
      newMapLocation.y += height/2;
      myLED.setMapLocation(newMapLocation);
    }
  }
  popMatrix();
}



