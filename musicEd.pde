import ddf.minim.analysis.*;
import ddf.minim.*;

ArrayList<BandList> bandlists = new ArrayList<BandList>();


Minim minim;
AudioInput in;
FFT fftLin;
//(M) Change the spectrumScale to change the height of the spectrogram) 
float spectrumScale = 100;
float z;
int listCap = 500;


class BandList {

 FloatList bands;
 color col;

 BandList(FloatList _bands, color _col) {
   col = _col;
   bands = _bands;
 }
}

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
 //pushMatrix();
 translate(400, 0, -450);
 rotateY(radians(-30));
 background(0);
 float centerFrequency = 0;
 fftLin.forward( in.mix );
 //translate(0, 0, z);

 //save all bands (513 total) info into a list
 FloatList temp = new FloatList();
 for (int i = 0; i < fftLin.specSize(); i++) {
   temp.append(fftLin.getBand(i)*spectrumScale);
 }
 //get a random color for all the 513 bands.
 color randomColor = color(random(0, 255), random(0, 255), random(0, 255), 100);

 //save bands and color info into the mega list.
 bandlists.add(new BandList(temp, randomColor));

 //if the mega list exceed its cap, remove the first from the list
 if (bandlists.size() > listCap) {
   bandlists.remove(0);
 }


 //draw
 for (int i=0; i<bandlists.size(); i++) {
   pushMatrix();
   translate(0, 0, i);
   stroke(bandlists.get(i).col);
   for (int i2 = 0; i2 < bandlists.get(i).bands.size(); i2++) {
     line(i2, height, i2, height - bandlists.get(i).bands.get(i2));
   }

   popMatrix();
 }
}