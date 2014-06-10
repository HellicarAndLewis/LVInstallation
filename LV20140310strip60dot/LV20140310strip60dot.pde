OPC opc;
PImage dot;

void setup()
{
  size(800, 800);

  // Load a sample image
  dot = loadImage("color-dot.png");

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  // Map one 64-LED strip to the center of the window
  // 60 in this case
  // opc.ledStrip(0, 60, width/2, height/2, width / 70.0, 0, false);

  // 612 in total
  // OUTER: 29 LED, PERCIEVED LENGTH 940 MMM FULL LENGTH 1000MM 12 EDGES
  // MIDDLE: 12 LED, PERCIEVED LENGTH 373MM FULL LENGTH 433MM 8 EDGES
  // INNER: 14 LED, PERCIEVED LENGTH 440MM FULL LENGTH 500MM 12 EDGES
  
  // outer cube is 6 strips of LED, each with 2*29 = 58 LEDs in total, 2 edges each
  // 12 edges in total, 29*12 = 348 pixels undercontrol
  int numberOfStripsInOuterControl = 6;
  int startPixel = 0;
  int numberOfLEDsPerOuterEdge = 29;
  int spacing = 1;
  int angle = 0;
  boolean reversed = false;
  int centreX = width/2;
  int yForOuter = 10;

  for(int i=0; i < numberOfStripsInOuterControl; i++){
      opc.ledStrip(startPixel, numberOfLEDsPerOuterEdge, centreX, yForOuter, spacing, angle, reversed);
      /*  opc.ledStrip(index, count, x, y, spacing, angle, reversed)
      Place a rigid strip of LEDs on the screen
      index: Number for the first LED in the strip, starting with zero
      count: How many LEDs are in the strip?
      x, y: Center location, in pixels
      spacing: Spacing between LEDs, in pixels
      angle: Angle, in radians. Positive is clockwise, 0 is to the right.
      reversed: true = Right to left, false = Left to right*/
      startPixel += numberOfLEDsPerOuterEdge; //move along to the next strips worth of LED
      yForOuter += 1; //move down the screen 1 pixel
      
      opc.ledStrip(startPixel, numberOfLEDsPerOuterEdge, centreX, yForOuter, spacing, angle, reversed);
      startPixel += numberOfLEDsPerOuterEdge; //move along to the next strips worth of LED
      yForOuter += 1; //move down the screen 1 pixel
  }
  
  
  // numberOfStripsInMiddleControl is 4 strips of LED, each with (12*2) + 14 = 38 pixels
  // 12 edges in total, 3 per strip, 38*4 = 152 under control here
  int numberOfStripsInMiddleControl = 4;
  int numberOfLEDsPerMiddleEdge = 12;
  int numberOfLEDsPerInnerEdge = 14;
  int yForMiddle = 110;
  int yForInner = 210;

  for(int i=0; i< numberOfStripsInMiddleControl; i++){
      opc.ledStrip(startPixel, numberOfLEDsPerMiddleEdge, centreX, yForMiddle, spacing, angle, reversed);
      startPixel += numberOfLEDsPerMiddleEdge; //just did a middle edge
      yForMiddle += 1; //move down the screen 1 pixel
      opc.ledStrip(startPixel, numberOfLEDsPerInnerEdge, centreX, yForInner, spacing, angle, reversed);
      startPixel += numberOfLEDsPerInnerEdge; //just did an inner edge
      yForInner += 1; //move down the screen 1 pixel
      opc.ledStrip(startPixel, numberOfLEDsPerMiddleEdge, centreX, yForMiddle, spacing, angle, reversed);
      startPixel += numberOfLEDsPerMiddleEdge; //just did a middle edge
      yForMiddle += 1; //move down the screen 1 pixel
  }

  // numberOfStripsInInnderControl is 2 strips of LED, each with 14*4 = 56 pixels
  // 8 edges in total, 56*2 = 112 pixels under control
  int numberOfStripsInInnerControl = 2;

  for(int i=0; i< numberOfStripsInInnerControl; i++){
      opc.ledStrip(startPixel, numberOfLEDsPerInnerEdge, centreX, yForInner, spacing, angle, reversed);
      startPixel += numberOfLEDsPerInnerEdge; //just did an inner edge
      yForInner += 1; //move down the screen 1 pixel
      
      opc.ledStrip(startPixel, numberOfLEDsPerInnerEdge, centreX, yForInner, spacing, angle, reversed);
      startPixel += numberOfLEDsPerInnerEdge; //just did an inner edge
      yForInner += 1; //move down the screen 1 pixel
      
      opc.ledStrip(startPixel, numberOfLEDsPerInnerEdge, centreX, yForInner, spacing, angle, reversed);
      startPixel += numberOfLEDsPerInnerEdge; //just did an inner edge
      yForInner += 1; //move down the screen 1 pixel
      
      opc.ledStrip(startPixel, numberOfLEDsPerInnerEdge, centreX, yForInner, spacing, angle, reversed);
      startPixel += numberOfLEDsPerInnerEdge; //just did an inner edge
      yForInner += 1; //move down the screen 1 pixel
  }
}

void draw()
{
  background(0);

  // Draw the image, centered at the mouse location
  float dotSize = width * 0.2;
  image(dot, mouseX - dotSize/2, mouseY - dotSize/2, dotSize, dotSize);
}

