void dropDown()
{
  for(int i = 0; i < LEDs.length; i++)
  {
    LED myLED = LEDs[i];
    myLED.acc = new PVector(0.0, random(1, 10), 0.0);
  }
}
/*
void returnToTess()
{
  for(int i = 0; i < 
  */
