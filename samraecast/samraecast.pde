PFont simplifica;// = createFont("Simplifica", 100);

PImage face;


void setup() {
  size(1280, 720, P2D);
  simplifica = createFont("Simplifica", 200, true);
  face = loadImage("face.jpg");


  smooth();
  noLoop();
  background(0);
}

void draw() {
  background(0);
  fill(255);

  face.loadPixels();
  PImage img_r = createImage(face.width, face.height, ARGB);
  PImage img_g = createImage(face.width, face.height, ARGB);
  PImage img_b = createImage(face.width, face.height, ARGB);
  PImage img_back = createImage(width, height, RGB);
  img_back.loadPixels();

  for (int y = 0; y < face.height; y += 1) {
    for (int ix = 0; ix < img_back.width; ix += 1) {
      img_back.set(ix, y, face.get(0, y));
    }
  }
  img_back.updatePixels();

  //img.copy(face, 0, 0, face.width, face.height, 0, 0, img.width, img.height);
  img_r.loadPixels();
  img_g.loadPixels();
  img_b.loadPixels();
  float alpha_max = 32;

  //img.
  for (int x = 0; x < img_r.width; x += 1 ) {
    for (int y = 0; y < img_r.height; y += 1 ) {
      color pixel = face.pixels[x + y * face.width];
      float red = red(pixel);
      float green = green(pixel);//map(x, 0, img.width, 0, 128);
      float blue = blue(pixel);//map(y, 0, img.height, 0, 64);
      float alpha = alpha_max;//map(x, 0, img.width, 255, 0);
      //pixel = color(red, green, blue, alpha);
      if (x < 30) {
        alpha = map(x, 0, 30, 0, alpha_max);
      } else if (x > img_r.width-30) {
        alpha = map(x, img_r.width-30, img_r.width, alpha_max, 0);
      }

      img_r.pixels[x + y * img_r.width] = color(red, 0, 0, alpha);
      img_g.pixels[x + y * img_r.width] = color(0, green, 0, alpha);
      img_b.pixels[x + y * img_r.width] = color(0, 0, blue, alpha);
    }
  }
  img_r.updatePixels();
  img_g.updatePixels();
  img_b.updatePixels();
  //img.blend(face, 0, 0, face.width, face.height, 0, 0, img.width, img.height, DODGE);
  //img.blend(face, 0, 0, face.width, face.height, 0, 0, img.width, img.height, BURN);
  //img.blend(face, 0, 0, face.width, face.height, 0, 0, img.width, img.height, MULTIPLY);
  float xpos = width - 720;
  image(img_back, 0,0);
  image(face, xpos, 0);
  image(img_r, xpos, 0, img_r.width * 1.05, img_r.height * 1.05);
  image(img_r, xpos-20, 0, img_r.width * 1.04, img_r.height * 1.09);
  image(img_b, xpos, 0, img_r.width * 1.06, img_r.height * 1.04);
  image(img_g, xpos, 0, img_r.width * 1.07, img_r.height * 1.03);


  textFont(simplifica);
  textSize(200);
  text("the sam rae-cast", 10, 200);
  textSize(144);
  text("episode 001", 10, 344);
  //filter(DILATE);
  //filter(DILATE);
}