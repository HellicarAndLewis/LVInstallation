class lightBlock
{
  PVector location = new PVector(0, 0, 0);
  PVector velocity = new PVector(0, 0, 0);
  PVector acceleration;
  
  color blockColor;
  
  PVector dimensions;
  Integrator w, h, d;
  
  public lightBlock(PVector newLocation, PVector newDimensions)
  {
    location = newLocation;
    dimensions = newDimensions;
    w = new Integrator(dimensions.x);
    h = new Integrator(dimensions.y);
    d = new Integrator(dimensions.z);
  }
  
  public lightBlock(float x, float y, float z, float newW, float newH, float newD)
  {
    location = new PVector(x, y, z);
    dimensions = new PVector(newW, newH, newD);
    w = new Integrator(dimensions.x);
    h = new Integrator(dimensions.y);
    d = new Integrator(dimensions.z);
  }
  
  void display(float x, float y, float z)
  {
    pushMatrix();
    noStroke();
    translate(x, y, z);
    translate(location.x, location.y, location.z);
    stroke(255);
    //fill(blockColor, 100);
    box(w.value, h.value, d.value);
    popMatrix();
  }
  
  //checks if a point is inside this block
  boolean isThisInside(PVector newVector)
  {
    if( (newVector.x < location.x + w.value/2) && (newVector.x > location.x - w.value/2) )
    {
      if( (newVector.y < location.y + h.value/2) && (newVector.y > location.y - h.value/2) )
      {
        if( (newVector.z < location.z + d.value/2) && (newVector.z > location.z - d.value/2) )
        {
          return true;
        }
        else
        {
          return false;
        }
      }
      else
      {
        return false;
      }
    }
    else
    {
      return false;
    }
  }
  
  void move()
  {
    //velocity.add(acceleration);
    location.add(velocity);
  }
  
  void changeWidth(float newW)
  {
    w.target(newW);
  }
  
  void changeHeight(float newH)
  {
    h.target(newH);
  }

  void changeDepth(float newD)
  {
    d.target(newD);
  }
  
  void updateSize()
  {
    w.update();
    h.update();
    d.update();
  }
  
  void checkEdges()
  {
    float x = location.x;
    float y = location.y;
    float z = location.z;
    
    if(x > 100)
    {
      location.x = 100;
      velocity.x = 0;
      velocity.z = 1;
    }
    else if(x < -100)
    {
      location.x = -100;
      velocity.x = 0;
      velocity.z = -1;
    }
    if(z > 100)
    {
      location.z = 100;
      velocity.z = 0;
      velocity.x = -1;
    }
    else if(z < -100)
    {
      location.z = -100;
      velocity.z = 0;
      velocity.x = 1;
    }
  }
}
