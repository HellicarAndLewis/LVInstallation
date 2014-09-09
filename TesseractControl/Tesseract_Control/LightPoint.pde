class lightPoint
{
  PVector location;
  color lightColor;
  float intensity;
  int LEDIndex;
  
  public lightPoint(PVector newLocation, color newLightColor, float newIntensity)
  {
    location = newLocation.get();
    lightColor = newLightColor;
    intensity = newIntensity;
  }
  
  
  public lightPoint(float x, float y, float z, color newLightColor, float newIntensity)
  {
    location = new PVector(x, y, z);
    lightColor = newLightColor;
    intensity = newIntensity;
  }
  
  public lightPoint(int newLEDIndex, color newLightColor, float newIntensity)
  {
    location = LEDs[newLEDIndex].realLocation.get();
    LEDIndex = newLEDIndex;
    lightColor = newLightColor;
    intensity = newIntensity;
  }
  
  public lightPoint(LED newLED, color newLightColor, float newIntensity)
  {
    location = newLED.realLocation.get();
    lightColor = newLightColor;
    intensity = newIntensity;
  }
  
  void display(float x, float y, float z)
  {
    pushMatrix();
    noStroke();
    translate(x, y, z);
    translate(location.x, location.y, location.z);
    fill(lightColor, 100);
    sphere(intensity);
    popMatrix();
  }
}
