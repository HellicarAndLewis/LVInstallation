void generateTesseract()
{
  //Set Lights Per Strip
  int lightsPerStripOutside = 240;
  int lightsPerStripInside = 90;
  int lightsPerStripConnections = 80;
  println(lightsPerStripOutside * 12 + lightsPerStripInside * 12 + lightsPerStripConnections * 8);
  //Set Side Lengths
  float sideLengthOutside = vertices[0].x - vertices[1].x;
  float sideLengthInside = vertices[8].x -vertices[9].x;
  float sideLengthConnections = sideLengthInside/2;
  
  //Set Corner Gaps
  float gap = 0; // 20
  
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    LED newLED = new LED(newRealLocation);
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
    newLED.LEDIndex = LEDindex;
    LEDs[LEDindex] = newLED;
    LEDindex++;
  }
}


