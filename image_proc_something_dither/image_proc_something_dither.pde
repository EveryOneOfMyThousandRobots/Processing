HashMap<Integer, PImage> imageMap = new HashMap<Integer, PImage>();
final int BLOCK_WIDTH = 5;
final int BLOCK_HEIGHT = 8;
final int BLOCK_TOTAL = BLOCK_WIDTH * BLOCK_HEIGHT;
final int BIT_RATE = 2;
void setup() {
  size(400,400);
  noSmooth();
  float bm = pow(2, BIT_RATE);
  for (int b = 0; b < floor(pow(2, BIT_RATE)); b += 1) {
    float bf = b;

    float ratio = (bf / bm);    

    int i = (int) (ratio * 100);




    PGraphics img = createGraphics(BLOCK_WIDTH, BLOCK_HEIGHT);


    img.beginDraw();
    img.background(0);
    if (ratio > 0) {
      img.loadPixels();
      int numPixels = img.width * img.height;

      int xe = floor((float)numPixels / ((float)numPixels * ratio));

      println("b = " + b + " ratio: " + nfc(ratio, 2) + " i: " + i + " step=" + xe);

      if (xe > 0) {
        for (int p = 0; p < numPixels; p += xe) {
          img.pixels[p] = lerpColor(color(0), color(255), ratio);
        }
      }
    }
    img.updatePixels();
    img.endDraw();

    imageMap.put(i, img);
  }
}

void draw() {
  
  background(255, 0, 0);
  int x = 0;
  int y = BLOCK_HEIGHT*4;
  for (int i : imageMap.keySet()) {
    image(imageMap.get(i), x, y, BLOCK_WIDTH*4, BLOCK_HEIGHT*4);
    
    stroke(255,128);
    noFill();
    rect(x,y,BLOCK_WIDTH*4,BLOCK_HEIGHT*4);
    x += BLOCK_WIDTH * 4;
  }
}
