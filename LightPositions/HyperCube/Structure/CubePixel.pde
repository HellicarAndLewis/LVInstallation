//base object with screen and world position
class CubePixel {
  //index - this should correspond to both the LED and structure arraylist index
  int index;
  
  int screenPosX;
  int screenPosY;
  
  PVector worldPos;
  
  //index in the hypercube object
  int nextPixelIndex;
  int previousPixelIndex;
  
  CubePixel() {
  }
}
