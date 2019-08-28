final float LEFT_MIN = radians(-160);
final float LEFT_MAX = radians(-100);

final float RIGHT_MIN = radians(-80);
final float RIGHT_MAX = radians(-20);

final float LEN_FACTOR = 0.6;

void ln(float x, float y, float len) {


  if (len > 1 && x >= 0 && x <= width && y >= 0 && y <= height) {
    float angleLeft = random(LEFT_MIN, LEFT_MAX);
    float angleRight = random(RIGHT_MIN, RIGHT_MAX);

    float lx = x + len * cos(angleLeft);
    float ly = y + len * sin(angleLeft);

    line(x, y, lx, ly);
    
      //ln(lx, ly, len*LEN_FACTOR);
    
    lx = x + len * cos(angleRight);
    ly = y + len * sin(angleRight);
    line(x, y, lx, ly);
    
      ln(lx, ly, len*LEN_FACTOR);
    
  } else if (x > 0 && x < width && y > 0 && y < height) {
    ln(x, y, len * 4);
  }
}


void setup() {
  size(800, 800);
  background(255);
  ln(width/2, height, height/8);
}



void draw() {
  println("hello");
  stop();
}
