ArrayList<PImage> images = new ArrayList<PImage>();
int NUM_COLOURS = 16;
int image_index = 0;
void setup() {
  size(800, 600);
  colorMode(HSB);
  frameRate(5);
  PImage img = resizeMe(loadImage("002.jpg"), width,height);
  //images.add(resizeMe(loadImage("001.jpg"),width,height));
  
  for (NUM_COLOURS = 2; NUM_COLOURS < 32; NUM_COLOURS += 1) {
    PImage img2 = proc(img);
    images.add(img2);
  }
  //images.add(resizeMe(loadImage("002.jpg"),width/2,height));
  
}



void draw() {
  background(0);

  //loadPixels();
  //for (float x = 0; x < width; x += 1) {
  //  for (float y = 0; y < height; y += 1) {
  //    float h = getClosest(map(x, 0, width, 0, 255));
  //    float s = getClosest(map(y, 0, height, 0, 255));
  //    float b = getClosest(map(x+y, 0, width+height, 0, 255));
  //    color c = color(h, s, b);

  //    pixels[floor(y) * width + floor(x)] = c;
  //  }
  //}
  //updatePixels();
  PImage img = images.get(image_index);
  int xpos = (width / 2) - (img.width/2);
  int ypos = (height / 2) - (img.height/2);
  image(img,xpos,ypos);
  
  fill(255);
  text(image_index+2,10,10);
  
  image_index = (image_index + 1) % images.size();
}
