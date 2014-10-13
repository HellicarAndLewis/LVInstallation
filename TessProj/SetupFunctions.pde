void defineVertices()
{
  outerSize = 600/2;
  innerSize = 300/2;
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
  }
  else
  {
    beat = new BeatDetect(player.bufferSize(), player.sampleRate());
    fft = new FFT( player.bufferSize(), player.sampleRate() );
  }
  beat.setSensitivity( 200 );
  fft.linAverages( 2 );
  player.play();
  player.loop();
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
