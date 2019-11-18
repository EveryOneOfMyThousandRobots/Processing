void setup() {
  size(64, 30);
}



void draw() {
  background(255);
  int x = 0;
  int y = 0;

  loadPixels();
  for (int i =0; i < 10; i += 1) {
    x = 0;
    
    ArrayList<Integer> nums = new ArrayList<Integer>();
    while (nums.size() < 32) {//(int i = 1; i <= 26; i += 1) {
      int r = floor(random(1, 63));

      if (nums.contains(r)) continue;
      nums.add(r);
      for (int xx = 0; xx < 2; xx += 1) {
        for (int yy = 0; yy < 3; yy += 1) {
          int j = yy * 2 + xx;
          int k = 1 << j;
          int px = xx + x;
          int py = yy + y;

          if (!((r & k) == 0)) {
            pixels[py * width + px] = color(0);
          }
        }
      }

      x += 2;
      
    }
    y += 3;
  }
  updatePixels();
  saveFrame("out.png");
  stop();
}
