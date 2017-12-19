import ddf.minim.analysis.*;
import ddf.minim.*;

  
ArrayList<Float> freqs = new ArrayList<Float>();


Minim minim;
AudioInput in;
FFT fftLin;
//(M) Change the spectrumScale to change the height of the spectrogram) 
float spectrumScale = 100;
float z;

void setup()
{
  size(1800, 480, P3D);
  background(0);
  minim = new Minim(this);
  in = minim.getLineIn();

  fftLin = new FFT( in.bufferSize(), in.sampleRate() );
}

void draw()
{
  pushMatrix();
  //background(0);
  float centerFrequency = 0;
  fftLin.forward( in.mix );
  translate(0, 0, z);
  {
    for (int i = 0; i < fftLin.specSize(); i++)
    //fftLin.specSize() = 513;
    {
      
      stroke(random(0, 255), random(0, 255), random(0, 255));
      line(i, height, i, height - fftLin.getBand(i)*spectrumScale);
    }

    //fill(255, 128);
    //text("Spectrum Center Frequency: " + centerFrequency, 5, height - 25);
  }
  z+=-10; 
  popMatrix();

}