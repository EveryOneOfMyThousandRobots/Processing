float v = 1.0 / 9.0;
float l = 0.5, h = 0.9;
float 
float [][] kernel = {{random(0.5,0.9), random(1), random(1)}, 
  {random(1), random(1), random(1)}, 
  {random(1), random(1), random(1)}};

PImage img;

void setup() {
  size(600, 450);

  img = loadImage("haters.jpg");
  noLoop();
}

void draw() {
  image(img, 0, 0);
  img.loadPixels();

  PImage edgeImg = createImage(img.width, img.height, RGB);

  for (int y = 1; y < img.height - 1; y++) {
    for (int x = 1; x < img.width - 1; x++) {
      float sum = 0;
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          int pos = (x + kx) + (y + ky) * img.width;
          float val = red(img.pixels[pos]);
          sum += kernel[ky + 1][kx + 1] * val;
        }
      }

      edgeImg.pixels[x + y * img.width] = color(sum);
    }
  }
  edgeImg.updatePixels();
  image(edgeImg, width / 2, 0);
}