//final float NOISE_MAX = 5;
final int NUM_PARTICLES = 100;
final float PARTICLE_RANGE = 0.03;
float counter = 0;
float percent = 0;
final float TOTAL_FRAMES = 120;
boolean record = false;

//final float RADIANS_1 = radians(1);
//final float RADIANS_180 = radians(180);
//final float RADIANS_90 = radians(90);


//float xoff, yoff;

NoiseLoop nlA, nlB;
ArrayList<Particle> particles = new ArrayList<Particle>();
void setup() {
  size(400,400);
  fill(255, 64);
  stroke(255, 64);
  //nlA = new NoiseLoop(0.5, 0, width);
  //nlB = new NoiseLoop(0.5, height / 4, height * 0.75);
  background(0);
  //noiseSeed(1);
  colorMode(HSB);
  while (particles.size() < NUM_PARTICLES) {
    particles.add(new Particle());
  }
  
  
  
}

void draw() {
  background(0);
  //float x = nlA.value(angle);
  //float y = nlB.value(angle);
  //circle(x, y, 2);
  
  if (record) {
    counter += 1;
  } else {
    counter = frameCount % TOTAL_FRAMES;
    
  }
  
  percent = counter / TOTAL_FRAMES;
  
  

  for (Particle p : particles) {
    p.update(percent*TWO_PI);
    p.draw();
    
  }
  
  if (record) {
    saveFrame("output/f###.png");
    if (counter >= TOTAL_FRAMES) {
      exit();
    }
  }
  
  //fill(255);
  //text(nfc(counter,0) + " " + nfc(percent,3), 10, 10);

  
}
