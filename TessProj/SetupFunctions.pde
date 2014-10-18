void defineVertices()
{
  outerSize = 350;
  innerSize = outerSize/2;
  //Define Vertices
  vertices = new PVector[16];
  vertices[0] = new PVector(outerSize/2, outerSize/2, outerSize/2);
  vertices[1] = new PVector(-outerSize/2, outerSize/2, outerSize/2);
  vertices[2] = new PVector(-outerSize/2, outerSize/2, -outerSize/2);
  vertices[3] = new PVector(outerSize/2, outerSize/2, -outerSize/2);
  vertices[4] = new PVector(outerSize/2, -outerSize/2, outerSize/2);
  vertices[5] = new PVector(-outerSize/2, -outerSize/2, outerSize/2);
  vertices[6] = new PVector(-outerSize/2, -outerSize/2, -outerSize/2);
  vertices[7] = new PVector(outerSize/2, -outerSize/2, -outerSize/2);
  vertices[8] = new PVector(innerSize/2, innerSize/2, innerSize/2);
  vertices[9] = new PVector(-innerSize/2, innerSize/2, innerSize/2);
  vertices[10] = new PVector(-innerSize/2, innerSize/2, -innerSize/2);
  vertices[11] = new PVector(innerSize/2, innerSize/2, -innerSize/2);
  vertices[12] = new PVector(innerSize/2, -innerSize/2, innerSize/2);
  vertices[13] = new PVector(-innerSize/2, -innerSize/2, innerSize/2);
  vertices[14] = new PVector(-innerSize/2, -innerSize/2, -innerSize/2);
  vertices[15] = new PVector(innerSize/2, -innerSize/2, -innerSize/2);
}

void setupMinim(boolean lineInOn)
{
  //Setup audio
  minim = new Minim(this);
  lineIn = minim.getLineIn();
  player = minim.loadFile("LVTrack01.mp3", 512);
  if(lineInOn)
  {
    beat = new BeatDetect(lineIn.bufferSize(), lineIn.sampleRate());
    fft = new FFT(lineIn.bufferSize(), lineIn.sampleRate());
    beat.setSensitivity(200);
    fft.linAverages(2);
  }
  else
  {
    beat = new BeatDetect(player.bufferSize(), player.sampleRate());
    fft = new FFT(player.bufferSize(), player.sampleRate());
    beat.setSensitivity(200);
    fft.linAverages(2);
  }
}

void activateMinim(boolean lineInOn)
{
  if(lineInOn)
  {
    beat.detect( lineIn.mix );
    fft.forward( lineIn.mix );
  }
  else
  {
    beat.detect( player.mix );
    fft.forward( player.mix );
  }  
}

float dist3D(PVector vec1, PVector vec2)
{
  float xd = vec2.x - vec1.x;
  float yd = vec2.y - vec1.y;
  float zd = vec2.z - vec1.z;
  float dist = sqrt(xd*xd+yd*yd+zd*zd);
  return dist;
}
