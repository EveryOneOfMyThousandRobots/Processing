final int a_width = 12;
final int a_height = 19;




final int blockWidth = 20;
final int blockHeight = 20;

void settings() {
  size(blockWidth * a_width, blockHeight * a_height);
}
void setup() {
}


void draw() {
  background(0);

  for (int x = 0; x < a_width; x += 1) {
    for (int y = 0; y < a_height; y += 1) {
      int i = y * a_width + x;
      String b = str(arena.charAt(i));
      color f = color(255);
      switch(b) {
        case "#":
        
        break;
        case ".":
        f = color(0);
        break;
      }
      fill(f);
      noStroke();
      rect(x * blockWidth, y * blockHeight, blockWidth, blockHeight);
    }
  }
}
