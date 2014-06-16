//base object with screen and world position
class CubePixel {
  int screenPosX;
  int screenPosY;
  
  float worldPosX;
  float worldPosY;
  float worldPosZ;
  
  //index in the hypercube object
  int nextPixelIndex;
  int previousPixelIndex;
  
  CubePixel() {
    
  }
}
