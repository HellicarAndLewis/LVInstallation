void findCornerConnections()
{
  for(int i = 0; i < cornerLEDs.length; i++)
  {
    LED myLED = cornerLEDs[i];
    HashMap<Float, Integer> cornerDistMap = new HashMap<Float, Integer>(64);
    float[] distances = new float[64];
    for(int j = 0; j < distances.length; i++)
    {
      LED testLED = cornerLEDs[j];
      float dist = dist(myLED.realLocation.x, myLED.realLocation.y, myLED.realLocation.z, testLED.realLocation.x, testLED.realLocation.y, testLED.realLocation.z);
      cornerDistMap.put(dist, j);
      distances[j] = dist;
    }
    
    sort(distances);
    for(int j = 1; j < 4; j++)
    {
      myLED.cornerLEDs[j] = LEDs[cornerDistMap.get(distances[j])];
    }
  }
}
