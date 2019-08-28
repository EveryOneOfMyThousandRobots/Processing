final float C = 300;
final float Csq = C * C;
final float G = 6.67E-2;
final float M0 = 1.989; 
BlackHole m87;
StarMap stars;
void setup() {
  size(800, 600);
  println("C = " + C);
  println("G = " + G);
  println("M0 (mass of sun) = " + M0);
  m87 = new BlackHole(width / 4, height / 2, 6500);
  stars = new StarMap();
}

void draw() {
  background(0);
  stars.draw();
  m87.draw();
  stars.generate();
}

final float STARTHRESH = 0.5;
final float STARCHANCE = 0.1;

class BlackHole {
  PVector pos;
  float mass, rs;
  BlackHole(float x, float y, float mass) {
    pos= new PVector(x, y);
    this.mass = mass;
    rs = (2.0 * G * mass) / Csq;
  }

  void draw() {
    fill(0);
    stroke(255);
    ellipse(pos.x, pos.y, rs*2, rs*2);
  }
}

class StarMap {
  PGraphics img;
  float z = 0;
  StarMap() {
    img = createGraphics(width, height);
    //img.loadPixels();
    generate();

    //img.updatePixels();
  }

  void generate() {
    z += 0.001;
    img.beginDraw();
    img.background(0);
    for (int x = 0; x < img.width; x += 1) {
      for (int y = 0; y < img.height; y += 1) {
        float xx = float(x) * 0.1;
        float yy = float(y) * 0.1;
        
        if (noise(xx,yy,z+1) <= STARCHANCE ) {

          float n = noise(xx, yy, z);
          if (n > STARTHRESH) {
            img.stroke(map(n, STARTHRESH, 1, 128, 255));
            img.point(x, y);
          }
        }
      }
    }
    img.endDraw();
  }

  void draw() {
    image(img, 0, 0);
  }
}
