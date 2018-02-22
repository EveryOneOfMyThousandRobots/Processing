PImage kitten;
float numColours = 3;
float brightnessThreshold = 0;
int numParticles = 250;

float tileWidth = 5;
float tileHeight = 5;

float errR = 0;
float errG = 0;
float errB = 0;

void settings() {
  kitten = loadImage("facesmall.jpg");
  kitten.filter(GRAY);
  size(kitten.width, kitten.height);
}

void setup() {
  //frameRate(1);
  //noLoop();
  calcImage();
  
  for (int x = 0; x < width; x += tileWidth) {
    for (int y = 0; y < height; y += tileHeight) {
      Tile t = new Tile(x,y,tileWidth, tileHeight);
      tiles.add(t);
    }
    
  }
  for (int i = 0; i < numParticles; i += 1) {
    Particle p = new Particle(random(width), random(height));
    particles.add(p);
  }
}



int idx(int x, int y) {
  return x + y * kitten.width;
}

void draw() {
  background(0);
  // image(kitten, 0, 0);



  //image(kitten, 0, 0);
  tilesDraw();
  particlesProcess();
  particlesDraw();
}





int getClosest(float col) {
  return floor(round((numColours * col) / 255.0) * (255.0/numColours));
}