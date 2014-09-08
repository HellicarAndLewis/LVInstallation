class LED
{
  //Location in 3D space
  PVector realLocation;
  //Location in 2D Map Space
  PVector mapLocation;
  //Are you a vertex?
  boolean corner = false;
  
  //Colors
  color shade;
  color stroke;
  
  //Type of strip you are in
  boolean outside = false;
  boolean inside = false;
  boolean connections = false;
  
  //Next and Last LEDs in the chain
  int nextLEDIndex;
  int lastLEDIndex;
  //Array of LEDs you are linked to if you are a corner,
  LED[] cornerLEDs = new LED[3];
  
  public LED(PVector newRealLocation, PVector newMapLocation)
  {
    realLocation = newRealLocation;
    mapLocation = newMapLocation;
    shade = 255;
    stroke = 0;
    noStroke();
  }
  
  void draw3D(float x, float y)
  {
    pushMatrix();
    translate(x, y);
    translate(realLocation.x, realLocation.y, realLocation.z);
    fill(shade);
    stroke(stroke);
    box(5);
    popMatrix();
  }
  
  void drawMap(float x, float y)
  {
    pushMatrix();
    translate(x, y);
    fill(shade);
    stroke(stroke);
    ellipse(mapLocation.x, mapLocation.y, 5, 5);
    popMatrix();
  }
  
  void setMapLocation(PVector newMapLocation)
  {
    mapLocation = newMapLocation;
  }
  
  void highlight()
  {
    float strokeRed = map(shade, 0, 255, 255, 0);
    float strokeGreen = map(shade, 0, 255, 255, 0);
    float strokeBlue = map(shade, 0, 255, 255, 0);
    stroke = color(strokeRed, strokeGreen, strokeBlue);
  }
};
