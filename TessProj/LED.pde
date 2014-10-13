class LED
{
  //realLoc in 3D space
  PVector realLoc;
  PVector tesLoc;
  PVector vel;
  PVector acc;
  float maxVel;
  float maxAcc;
  //Are you a vertex?
  boolean isCorner = false;
  
  //Colors
  color shade = 0;
  color trueColor;
  color stroke;
  
  Integrator rad;
  
  //Type of strip you are in
  boolean outside = false;
  boolean inside = false;
  boolean connections = false;
  
  //Next and Last LEDs in the chain
  int nextLEDIndex;
  int lastLEDIndex;
  int LEDIndex;
  
  //Array of LEDs you are linked to if you are a corner,
  int[] cornerIndices = new int[3];
  
  public LED(PVector newLoc)
  {
    realLoc = new PVector(newLoc.x, newLoc.y, newLoc.z);;
    tesLoc = new PVector(newLoc.x, newLoc.y, newLoc.z);
    maxVel = 10.0;
    maxAcc = 1.0;
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
    stroke = 0;
    rad = new Integrator(0, 0.5, 0.9);
  }
  
  void draw3D(PGraphics src)
  {
    src.pushMatrix();
    src.translate(realLoc.x, realLoc.y, realLoc.z);
    src.noStroke();
    src.rotateY(-frameCount * 0.005f);
    int radVal = int(red(shade) + green(shade) + blue(shade));
    float fftVal = map(fft.getAvg(0), 0, 20, 0, 300);
    radVal = int(map(radVal, 0, 765, 0, fftVal));
    rad.target(radVal);
    rad.update();
    if(shade == 0)  rad.set(0);
    src.fill(shade);
    src.ellipse(0, 0, rad.value/2, rad.value/2);
    src.popMatrix();
  }
  
  void highlight()
  {
    float strokeRed = map(shade, 0, 255, 255, 0);
    float strokeGreen = map(shade, 0, 255, 255, 0);
    float strokeBlue = map(shade, 0, 255, 255, 0);
    stroke = color(strokeRed, strokeGreen, strokeBlue);
  }
  
  void move()
  {
    acc.limit(maxAcc);
    vel.add(acc);
    vel.limit(maxVel);
    realLoc.add(vel);
  }
  
  void checkEdges()
  {
    float x = realLoc.x;
    float y = realLoc.y;
    float z = realLoc.z;
    
    if(x > outerSize/2)
    {
      realLoc.x = outerSize/2;
      vel.x *= -1;
    }
    else if(x < -outerSize/2)
    {
      realLoc.x = -outerSize/2;
      vel.x *= -1;
    }
    if(y > outerSize)
    {
      realLoc.y = outerSize/2;
      vel.y *= -1;
    }
    else if(y < -outerSize/2)
    {
      realLoc.y = -outerSize/2;
      vel.y *= -1;
    }
    if(z > outerSize)
    {
      realLoc.z = outerSize/2;
      vel.z *= -1;
    }
    else if(z < -outerSize/2)
    {
      realLoc.z = -outerSize/2;
      vel.z *= -1;
    }
  }
};
