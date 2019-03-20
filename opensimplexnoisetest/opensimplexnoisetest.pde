OpenSimplexNoise sNoiseA, sNoiseB;
final fl
final float range = 0.5 * (sqrt(2));
float xoff, yoff, zoff;

float zx, zy, za;
void setup() {
  size(640,480);
  sNoiseA = new OpenSimplexNoise();
  sNoiseB = new OpenSimplexNoise();
  background(0);
}

void draw() {
   float percent = frameCount % TOTAL_FRAMES;
   za = (za + radians(1)) % TWO_PI;
   zx = map(cos(za), -1, 1, 0, 1);
   zy = map(sin(za), -1, 1, 0, 1);
   
   zoff = map((float)sNoiseB.eval(zx, zy), -range, range, 0, 1);
   background(0);
   zoff += 0.01;
   noStroke();
   //loadPixels();
   for(float x = 0; x < width/2; x += 1) {
     xoff = x * 0.1;
     for (float y = 0; y < height/2; y += 1) {
       yoff = y * 0.1;
       
       float v = map((float)sNoiseA.eval(xoff, yoff,zoff), -range, range, 0, 255);
       
       fill(v);
       square(x*2, y*2,2);
       
       
     }
   }
   
   //updatePixels();
  
}
