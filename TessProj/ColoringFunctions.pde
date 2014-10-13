//Rainbow colors
void colorRainbow()
{
  for(int i = 0; i < LEDs.length; i++)
  {
    LED myLED = LEDs[i];
    float red = map(myLED.realLoc.x, -100, 100, 0, 255);
    float green = map(myLED.realLoc.y, -100, 100, 0, 255);
    float blue = map(myLED.realLoc.z, -100, 100, 0, 255);
    myLED.trueColor = color(red, green, blue);
  }
}

//all one solid color
void colorSolid(int red, int green, int blue)
{
  for(int i = 0; i < LEDs.length; i++)
  {
    LED myLED = LEDs[i];
    myLED.trueColor = color(red, green, blue);
  }
}
//random black and white
void colorRandomBlackAndWhite()
{
  for(int i = 0; i < LEDs.length; i++)
  {
    float colour = random(0,255);
    LEDs[i].trueColor = color(colour, colour, colour);
  }
}
