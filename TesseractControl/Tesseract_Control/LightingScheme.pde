class lightingScheme
{
  ArrayList<Integer> colors = new ArrayList<Integer>();
  
  public lightingScheme(ArrayList<Integer> newColors)
  {
    for(int i = 0; i < newColors.size(); i++)
    {
      color newColor = newColors.get(i);
      colors.add(newColor);
    }
  }
  
  public lightingScheme(int[] newColors)
  {
    for(int i = 0; i < newColors.length; i++)
    {
      color newColor = newColors[i];
      colors.add(newColor);
    }
  }
  
  void emptyColors()
  {
    colors.clear();
  }
  
  void colorLights(ArrayList<lightPoint> newLightPoints)
  {
    for(int i = 0; i < newLightPoints.size(); i++)
    {
      lightPoint myLight = newLightPoints.get(i);
      boolean isRecolored = false;
      for(int j = 0; j < colors.size(); j++)
      {
        color newColor = colors.get(j);
        if(myLight.lightColor == newColor)
        {
          isRecolored = true;
        }
      }
      if(!isRecolored)
      {
        color newColor = int(random(0, colors.size()));
        myLight.setColor(colors.get(newColor));
      }
    }
  }
}

