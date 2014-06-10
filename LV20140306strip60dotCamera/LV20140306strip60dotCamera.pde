OPC opc;
PImage dot;
import processing.video.*;

Capture cam;

void setup()
{
  size(640, 480);

  // Load a sample image
  dot = loadImage("color-dot.png");

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  // Map one 64-LED strip to the center of the window
  // 60 in this case
  opc.ledStrip(0, 60, width/2, height/2, width / 70.0, 0, false);
  
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }
}

void draw()
{
  background(0);

//  // Draw the image, centered at the mouse location
//  float dotSize = width * 0.2;
//  image(dot, mouseX - dotSize/2, mouseY - dotSize/2, dotSize, dotSize);

if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}

