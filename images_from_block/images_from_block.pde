ArrayList<P> points = new ArrayList<P>();
ArrayList<CMover> cubes = new ArrayList<CMover>();
int enlargeBy = 20;
float blockSize = 20;

PImage img; 
static int  IMAGE_WIDTH;
static int IMAGE_HEIGHT;

void settings() {
  img = loadImage("samrae.png");
  size(img.width * enlargeBy, img.height * enlargeBy, P3D);
  setupImage();
}
void setup() {
  
  IMAGE_WIDTH = img.width;
  IMAGE_HEIGHT = img.height;

  
  
}
void setupImage() {
  img.loadPixels();
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int c  = img.pixels[x + y * img.width];
      c = c & 0xffffff; //remove alpha channel
      println(Integer.toString(c, 16)); //print as hex
      if (c != 0xff00ff) {
        points.add(new P(x * enlargeBy, y * enlargeBy));
      }
    }
  }
  
  for (P p : points) {
    PVector pos = new PVector(width / 2, height / 2, -1000); 
    //PVector pos = new PVector(random(width), random(height), random(-5,5));
    PVector size = new PVector(blockSize,blockSize,blockSize);
    PVector angle = new PVector(0,0,0);
    PVector target = p.pos.copy();
    CMover c = new CMover(pos, size, angle, target);
    c.move();
    cubes.add(c);
    
  }
  
}

void draw() {

  
  background(0);
  directionalLight(255,0,0,0,height / 2,0);
  stroke(255);
  fill(255);
  //for (P p : points) {
  //  ellipse(p.pos.x, p.pos.y, 2, 2);
  //}
  
  float range = 0.1;
  for (CMover c : cubes ) {
    
    float x = random(-range,range);
    float y = random(-range,range);
    float z = random(-range,range);
    PVector random = new PVector(x,y,z);
    c.applyForce(random);
   // if (frameCount % 50 == 0) {
      c.move();
   // }
    c.update();
    c.draw();
  }
}