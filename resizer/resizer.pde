PImage img;

void setup() {
  size(800, 800);
  img = loadImage("lady002b.jpg");
  noLoop();
}

void draw() {
  background(0);
  float ow = img.width;
  float oh = img.height;

  float dw = width;
  float dh = height;

  float resizeFactor = ow / dw;
  println(resizeFactor);

  float newWidth = ow / resizeFactor;
  float newHeight = oh / resizeFactor;
  image(img,0,0);
  img.resize(floor(newWidth), floor(newHeight));
  
  image(img, 0, (height / 2) - (img.height / 2));
}
