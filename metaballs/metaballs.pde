ArrayList<Blob> blobs = new ArrayList<Blob>();
final int NUM_BLOBS = 6;
void setup() {
  size(300, 200, P2D);
  colorMode(HSB);
  for (int i = 0; i < NUM_BLOBS; i += 1) {
    blobs.add(new Blob());
  }
}


void draw() {
  background(51);
  loadPixels();
  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      int idx = x + y * width;
      float sum = 0;
      for (Blob blob : blobs) {
        sum += 50 * (blob.r / dist(x, y, blob.pos.x, blob.pos.y));
      }
      
      pixels[idx] = color(constrain(sum, 0,255), 255,255);
    }
  }
  updatePixels();

  for (Blob blob : blobs) {
    blob.update();
    //blob.draw();
  }
}