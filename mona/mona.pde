PImage lisa;
final float BLOB_MIN = 1;
final float BLOB_MAX = 25;
final int POPULATION = 50;
final int SHAPES_PER_LISA = 100;
final float MUTATION_RATE = 0.01;
final float LEARNING_RATE = 0.0001;
final boolean BRIGHTNESS_MODE = false;

PImage newImage;
float imgx, imgy, imgw, imgh;

Population pop;
void setup () {
  imgx = lisa.width + 1;
  imgy = 0;
  imgw = lisa.width;
  imgh = lisa.height;
  colorMode(HSB);
  pop = new Population(POPULATION);
  frameRate(5);
}



void settings() {
  //lisa = loadImage("mona100x100poster.png");
  lisa = loadImage("mona100x100.png");
  //lisa = loadImage("redsquare.png");
  size(lisa.width * 2, lisa.height*2, P2D);
}

void draw() {
  background(0);
  image(lisa, 0, 0);
  //DNA dna1 = new DNA();
  //dna1.get("hello", 0,1);
  //dna1.get("oh", 0,1);
  //dna1.get("cheese", 0, 1);
  //DNA dna2 = new DNA();
  //dna2.get("hello", 0,1);
  //dna2.get("oh", 0,1);
  //dna2.get("help", 0, 1);
  //DNA dna3 = dna1.cross(dna2);
  //println(dna1);
  //println(dna2);
  //println(dna3);
  //  stop();

  pop.draw();
  if (frameCount % 25 == 0) {
    // println(pop);
    println(pop.newlisas.get(0).dna);
  }
  pop.breed();
  fill(0);
  text(pop.highestFitness, 10, 10);
  text(pop.highestError, 10, 20);
  text(frameCount, 10, 30);
  if (pop.bestLastGen != null) {
    image(pop.bestLastGen, imgx, imgh);
  }

  //  stop();
}