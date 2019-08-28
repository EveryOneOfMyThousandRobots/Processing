float RANGE = 2;
float X_LOW = -RANGE;
float X_HIGH = RANGE;

float Y_LOW = -RANGE;
float Y_HIGH = RANGE;

final int MAX_ITERATIONS = 100;
final float EXPLOSION_THRESHOLD = 2;

void setRange() {
  RANGE -= 0.01;

  X_LOW = -RANGE;
  X_HIGH = RANGE;

  Y_LOW = -RANGE;
  Y_HIGH = RANGE;
}

void setPixels() {
  loadPixels();

  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      
      

      float a = map(x, 0, width, X_LOW, X_HIGH);
      float b = map(y, 0, height, Y_LOW, Y_HIGH);

      float ca = a;
      float cb = b;


      int n = 0;
      float z = 0;

      while (n < MAX_ITERATIONS) {
        float aa = (a*a) - (b*b);
        float bb = (2 * a * b);

        a = aa + ca;
        b = bb + cb;

        if (abs(aa) + abs(bb) > EXPLOSION_THRESHOLD) {
          break;
        }
        n += 1;
      }
      float bright = map(n, 0, MAX_ITERATIONS, 0, 255);
      if (n == MAX_ITERATIONS) {
        bright = 0;
      }


      pixels[x + y * width] = color(bright);
    }
  }

  updatePixels();
  
  stroke(255);
  line(0,height/2, width, height/2);
  line(width/2,0,width/2,height);
  fill(255);
  for (int x = 0; x < width; x += 1) {
    float a = map(x, 0, width, X_LOW, X_HIGH);
    int aa = round((a % 1.0) * 10);
    
    
    if (aa == 0 || aa == 5) {
      text(nfc(a,1), x, height/2);
    }
    
  }
}

void setup() {
  size(600, 600);
}

void draw() {
  background(0);
  setRange();
  setPixels();
}
