PImage img;
void setup() {

  size(400, 400);
  byte[] bytes = loadBytes("horse.jpg");
  println(bytes.length);
  int iterations = 10;
  for (int j = 0; j < iterations; j += 1) {
    int start = floor(random(bytes.length / 6, bytes.length));
    int step = floor(random(1, bytes.length / 100));
    for (int i = start; i < bytes.length; i += step) {
      if (random(1) < 0.01) {
        byte b = bytes[i];
        b = (byte) ((b + 1) % 255);
        bytes[i] = b;
        break;
      }
    }
  }

  saveBytes("horse1.jpg", bytes);
  img = loadImage("horse1.jpg");
}


void draw() {
  image(img, 0, 0, width, height);
  noLoop();
}
