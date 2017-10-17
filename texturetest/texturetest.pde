PImage img;

void setup() {
  size(600,400, P2D);
  img = loadImage("kitty.jpg");
  textureMode(NORMAL);
  noLoop();
}

void draw() {
  background(51);
  stroke(255);
  fill(127);
  float w8 = width /8;
  float w16 = width / 16;
  float w32 = width / 32;
  float h4 = height / 4;
  float h8 = height / 8;
  float h16 = height / 16;
  
  
  //triangle strips
  beginShape(TRIANGLE_STRIP);
  texture(img);
  for (float x = w8; x < width - w8; x += w32) {
    float u = map(x, w8, width - w8, 0, 1);
    vertex(x, h8, u, 0);
    vertex(x, h4, u, 1);
  }
  endShape();
  
  //beginShape();
  ////texture(img);
  ////vertex(width / 4, height / 4, 0, 0);
  ////vertex(width - (width / 8), height / 4, img.width, 0);
  ////vertex(width - (width / 4), height - (height / 4), img.width, img.height);
  ////vertex(width / 4, height - (height / 4), 0, img.height);
  //endShape(CLOSE);
  
  
}