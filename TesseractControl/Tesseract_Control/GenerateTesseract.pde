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
  
  //Dummy mapLocation Variable to be set later because generating an LED wants a map location too
  PVector mapLocation = new PVector(0, 0);
  
  //initialize LED index
  int LEDindex = 0;
  
  //Begin generating Tesseract in order of wiring
  
    //-----------------------ENTRY H-----------------------
  
  //H to D
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideY, i);
    PVector newRealLocation = PVector.add(vertices[7], newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideY);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripOutside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //D to A
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideZ, i);
    PVector newRealLocation = PVector.add(vertices[3], newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripOutside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //H to G
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideX, i);
    PVector newRealLocation = PVector.sub(vertices[7], newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideX);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripOutside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //G to F
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideZ, i);
    PVector newRealLocation = PVector.add(vertices[6], newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripOutside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //H to R
  for(int i = 0; i < lightsPerStripConnections; i++)
  {
    PVector newSpacingVectorX = PVector.mult(spacingVectorsConnectionsX, i);
    PVector newSpacingVectorY = PVector.mult(spacingVectorsConnectionsY, i);
    PVector newSpacingVectorZ = PVector.mult(spacingVectorsConnectionsZ, i);
    
    PVector newRealLocation = PVector.sub(vertices[7], newSpacingVectorX);
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
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripConnections - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //R to M
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideY, i);
    PVector newRealLocation = PVector.add(vertices[15], newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideY);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripInside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //M to D
  for(int i = 0; i < lightsPerStripConnections; i++)
  {
    PVector newSpacingVectorX = PVector.mult(spacingVectorsConnectionsX, i);
    PVector newSpacingVectorY = PVector.mult(spacingVectorsConnectionsY, i);
    PVector newSpacingVectorZ = PVector.mult(spacingVectorsConnectionsZ, i);
    
    PVector newRealLocation = PVector.add(vertices[11], newSpacingVectorX);
    newRealLocation.add(newSpacingVectorY);
    newRealLocation.sub(newSpacingVectorZ);
    newRealLocation.add(spacingVectorsConnectionsX);
    newRealLocation.add(spacingVectorsConnectionsY);
    newRealLocation.sub(spacingVectorsConnectionsZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.connections = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripConnections - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //-----------------------ENTRY D-----------------------
  
  //D to C
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideX, i);
    PVector newRealLocation = PVector.sub(vertices[3], newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideX);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripOutside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //C to G
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideY, i);
    PVector newRealLocation = PVector.sub(vertices[2], newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideY);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripOutside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //C to L
  for(int i = 0; i < lightsPerStripConnections; i++)
  {
    PVector newSpacingVectorX = PVector.mult(spacingVectorsConnectionsX, i);
    PVector newSpacingVectorY = PVector.mult(spacingVectorsConnectionsY, i);
    PVector newSpacingVectorZ = PVector.mult(spacingVectorsConnectionsZ, i);
    
    PVector newRealLocation = PVector.add(vertices[2], newSpacingVectorX);
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
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripConnections - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //L to Q
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideY, i);
    PVector newRealLocation = PVector.sub(vertices[10], newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideY);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripInside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //Q to G
  for(int i = 0; i < lightsPerStripConnections; i++)
  {
    PVector newSpacingVectorX = PVector.mult(spacingVectorsConnectionsX, i);
    PVector newSpacingVectorY = PVector.mult(spacingVectorsConnectionsY, i);
    PVector newSpacingVectorZ = PVector.mult(spacingVectorsConnectionsZ, i);
    
    PVector newRealLocation = PVector.sub(vertices[14], newSpacingVectorX);
    newRealLocation.sub(newSpacingVectorY);
    newRealLocation.sub(newSpacingVectorZ);
    newRealLocation.sub(spacingVectorsConnectionsX);
    newRealLocation.sub(spacingVectorsConnectionsY);
    newRealLocation.sub(spacingVectorsConnectionsZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.connections = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripConnections - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //M to L
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideX, i);
    PVector newRealLocation = PVector.sub(vertices[11], newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideX);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripInside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //L to K
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideZ, i);
    PVector newRealLocation = PVector.add(vertices[10], newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripInside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //K to J
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideX, i);
    PVector newRealLocation = PVector.add(vertices[9], newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideX);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripInside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //J to M
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideZ, i);
    PVector newRealLocation = PVector.sub(vertices[8], newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripInside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //-----------------------ENTRY A-----------------------
  //A to B
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideX, i);
    PVector newRealLocation = PVector.sub(vertices[0], newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideX);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripOutside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //B to C
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideZ, i);
    PVector newRealLocation = PVector.sub(vertices[1], newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripOutside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //A to E
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideY, i);
    PVector newRealLocation = PVector.sub(vertices[0], newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideY);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    setTesseractMap(newLED);
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripOutside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    LEDs[LEDindex] = newLED;
    newLED.LEDIndex = LEDindex;
    LEDindex++;
  }
  //E to H
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideZ, i);
    PVector newRealLocation = PVector.sub(vertices[4], newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripOutside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //B to K
  for(int i = 0; i < lightsPerStripConnections; i++)
  {
    PVector newSpacingVectorX = PVector.mult(spacingVectorsConnectionsX, i);
    PVector newSpacingVectorY = PVector.mult(spacingVectorsConnectionsY, i);
    PVector newSpacingVectorZ = PVector.mult(spacingVectorsConnectionsZ, i);
    
    PVector newRealLocation = PVector.add(vertices[1], newSpacingVectorX);
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
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripConnections - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //K to P
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideY, i);
    PVector newRealLocation = PVector.sub(vertices[9], newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideY);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripInside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex = LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //P to F
  for(int i = 0; i < lightsPerStripConnections; i++)
  {
    PVector newSpacingVectorX = PVector.mult(spacingVectorsConnectionsX, i);
    PVector newSpacingVectorY = PVector.mult(spacingVectorsConnectionsY, i);
    PVector newSpacingVectorZ = PVector.mult(spacingVectorsConnectionsZ, i);
    
    PVector newRealLocation = PVector.sub(vertices[13], newSpacingVectorX);
    newRealLocation.sub(newSpacingVectorY);
    newRealLocation.add(newSpacingVectorZ);
    newRealLocation.sub(spacingVectorsConnectionsX);
    newRealLocation.sub(spacingVectorsConnectionsY);
    newRealLocation.add(spacingVectorsConnectionsZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.connections = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripConnections - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex = LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //-----------------------ENTRY E-----------------------
  
  //E to F
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideX, i);
    PVector newRealLocation = PVector.sub(vertices[4], newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideX);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripOutside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //F to B
  for(int i = 0; i < lightsPerStripOutside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsOutsideY, i);
    PVector newRealLocation = PVector.add(vertices[5], newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideY);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.outside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripOutside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //E to N
  for(int i = 0; i < lightsPerStripConnections; i++)
  {
    PVector newSpacingVectorX = PVector.mult(spacingVectorsConnectionsX, i);
    PVector newSpacingVectorY = PVector.mult(spacingVectorsConnectionsY, i);
    PVector newSpacingVectorZ = PVector.mult(spacingVectorsConnectionsZ, i);
    
    PVector newRealLocation = PVector.sub(vertices[4], newSpacingVectorX);
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
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripConnections - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //N to J
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideY, i);
    PVector newRealLocation = PVector.add(vertices[12], newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideY);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripInside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
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
    
    PVector newRealLocation = PVector.add(vertices[8], newSpacingVectorX);
    newRealLocation.add(newSpacingVectorY);
    newRealLocation.add(newSpacingVectorZ);
    newRealLocation.add(spacingVectorsConnectionsX);
    newRealLocation.add(spacingVectorsConnectionsY);
    newRealLocation.add(spacingVectorsConnectionsZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.connections = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripConnections - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  
  //N to P
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideX, i);
    PVector newRealLocation = PVector.sub(vertices[12], newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideX);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripInside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //P to Q
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideZ, i);
    PVector newRealLocation = PVector.sub(vertices[13], newSpacingVector);
    newRealLocation.sub(spacingVectorsOutsideZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripInside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //Q to R
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideX, i);
    PVector newRealLocation = PVector.add(vertices[14], newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideX);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripInside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
  //R to N
  for(int i = 0; i < lightsPerStripInside; i++)
  {
    PVector newSpacingVector = PVector.mult(spacingVectorsInsideZ, i);
    PVector newRealLocation = PVector.add(vertices[15], newSpacingVector);
    newRealLocation.add(spacingVectorsOutsideZ);
    LED newLED = new LED(newRealLocation, mapLocation);
    newLED.inside = true;
    if(i == 0)
    {
      newLED.isCorner = true;
      newLED.nextLEDIndex = LEDindex+1;
    }
    else if(i == lightsPerStripInside - 1)
    {
      newLED.isCorner = true;
      newLED.lastLEDIndex = LEDindex-1;
    }
    else
    {
      newLED.nextLEDIndex = LEDindex+1;
      newLED.lastLEDIndex= LEDindex-1;
    }
    setTesseractMap(newLED);
    newLED.LEDIndex = LEDindex;
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
      newMapLocation.x += (int)width/2;
      newMapLocation.y += (int)height/2;
      newMapLocation.x = int(newMapLocation.x);
      newMapLocation.y = int(newMapLocation.y);
      myLED.setMapLocation(newMapLocation);
      newMapLocation.x -= 150;
      newMapLocation.y -= 150;
    }
    else if(myLED.realLocation.z > -99)
    {
      PVector newMapLocation = new PVector(myLED.realLocation.x, myLED.realLocation.y);
      newMapLocation.rotate(HALF_PI/2);
      float scale = map(myLED.realLocation.z, -99, 99, 2.5, 1);
      newMapLocation.mult(abs(scale));
      newMapLocation.x += (int)width/2;
      newMapLocation.y += (int)height/2;
      newMapLocation.x = int(newMapLocation.x);
      newMapLocation.y = int(newMapLocation.y);
      myLED.setMapLocation(newMapLocation);
      newMapLocation.x -= 150;
      newMapLocation.y -= 150;
    }
    else
    {
      PVector newMapLocation = new PVector(myLED.realLocation.x, myLED.realLocation.y);
      newMapLocation.rotate(HALF_PI/2);
      int dif  = 0 - (int)newMapLocation.x;
      newMapLocation.x += 2*dif;
      newMapLocation.x += (int)width/2;
      newMapLocation.y += (int)height/2;
      newMapLocation.x = int(newMapLocation.x);
      newMapLocation.y = int(newMapLocation.y);
      myLED.setMapLocation(newMapLocation);
      newMapLocation.x += 350;
      newMapLocation.y -= 150;
    }
  }
  else if(myLED.inside)
  {
    if(myLED.realLocation.z > 49)
    {
      PVector newMapLocation = new PVector(myLED.realLocation.x, myLED.realLocation.y);
      newMapLocation.rotate(HALF_PI/2);
      newMapLocation.x += (int)width/2;
      newMapLocation.y += (int)height/2;
      newMapLocation.x = int(newMapLocation.x);
      newMapLocation.y = int(newMapLocation.y);
      myLED.setMapLocation(newMapLocation);
      newMapLocation.x -= 225;
      newMapLocation.y += 300;
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
      newMapLocation.x += width/2;
      newMapLocation.y += height/2;
      myLED.setMapLocation(newMapLocation);
      newMapLocation.x -= 225;
      newMapLocation.y += 300;
    }
    else
    {
      PVector newMapLocation = new PVector(myLED.realLocation.x, myLED.realLocation.y);
      newMapLocation.rotate(HALF_PI/2);
      //int dif  = 0 - (int)newMapLocation.x;
      //newMapLocation.x += 2*dif;
      newMapLocation.x += width/2;
      newMapLocation.y += height/2;
      newMapLocation.x = int(newMapLocation.x);
      newMapLocation.y = int(newMapLocation.y);
      myLED.setMapLocation(newMapLocation);
      newMapLocation.x += 25;
      newMapLocation.y += 300;
    }
  }
  else if(myLED.connections)
  {
    if(myLED.realLocation.z > 0)
    {
      PVector newMapLocation = new PVector(myLED.realLocation.x, myLED.realLocation.y);
      newMapLocation.rotate(HALF_PI/2);
      newMapLocation.x += width/2;
      newMapLocation.y += height/2;
      newMapLocation.x = int(newMapLocation.x);
      newMapLocation.y = int(newMapLocation.y);
      myLED.setMapLocation(newMapLocation);
      newMapLocation.x -= 150;
      newMapLocation.y -= 150;
    }
    else
    {
      PVector newMapLocation = new PVector(myLED.realLocation.x, myLED.realLocation.y);
      newMapLocation.rotate(HALF_PI/2);
      newMapLocation.x = int(newMapLocation.x);
      newMapLocation.y = int(newMapLocation.y);
      //int dif  = 0 - (int)newMapLocation.x;
      //newMapLocation.x += 2*dif;
      newMapLocation.x += width/2;
      newMapLocation.y += height/2;
      myLED.setMapLocation(newMapLocation);
      newMapLocation.x += 350;
      newMapLocation.y -= 150;
    }
  }
  popMatrix();
}



