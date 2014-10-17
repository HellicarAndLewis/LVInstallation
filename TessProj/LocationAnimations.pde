void handleLoc()
{
  if(millis() - savedLocTime > 18000)
  {
    int animCheck = int(random(1, 5));
    switch(animCheck)
    {
      case 1:
          returnToTess(5);
          locAnim = 1;
          savedLocTime = millis();
          break;
        case 2:
          freeze();
          locAnim = 0;
          savedLocTime = millis();
          break;
        case 3:
          explode();
          locAnim = 0;
          savedLocTime = millis();
          break;
        case 4:
          returnToTess(50);
          locAnim = 2;
          savedLocTime = millis();
          break;
    }
    savedLocTime = millis();
  }
}

void freeze()
{
  for(int i = 0; i < LEDs.length; i++)
  {
    LEDs[i].vel = new PVector(0, 0, 0);
    LEDs[i].acc = new PVector(0, 0, 0);
  }
}

void forceReturn()
{
  for(int i = 0; i < LEDs.length; i++)
  {
    LEDs[i].realLoc = new PVector(LEDs[i].tesLoc.x, LEDs[i].tesLoc.y, LEDs[i].tesLoc.z);
  }
}

void explode()
{
  for(int i = 0; i < LEDs.length; i++)
  {
    LED myLED = LEDs[i];
    myLED.acc = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    myLED.move();
  }
}

void pulseRight()
{
  for(int i = 0; i < LEDs.length; i++)
  {
    LED myLED = LEDs[i];
    myLED.acc = new PVector(random(0, 1), random(0, 1), random(0, 1));
    myLED.move();
  }
}

void bendOut()
{
  PVector zero = new PVector(0, 0, 0);
  for(int i = 0; i < LEDs.length; i++)
  {
    PVector dir = PVector.sub(LEDs[i].realLoc, zero);
    LEDs[i].acc = dir;
  }
}

void returnToTess(float thresh)
{
  for(int i = 0; i < LEDs.length; i++)
  {
    PVector dir = PVector.sub(LEDs[i].tesLoc, LEDs[i].realLoc);
    if(dir.mag() > thresh)
    {
      LEDs[i].acc = dir;
    }
    else
    {
      LEDs[i].realLoc = new PVector(LEDs[i].tesLoc.x, LEDs[i].tesLoc.y, LEDs[i].tesLoc.z);
      LEDs[i].vel = new PVector(0, 0, 0);
      LEDs[i].acc = new PVector(0, 0, 0);
    }
  }
}
