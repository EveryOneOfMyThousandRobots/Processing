float xs = 0.3;
float zs = 3;
float ys = 0.0;
class Tower {
  float x,y,z;
  float w,h,d;
  float r;
  
  
  Tower(float x, float y, float z, float w, float h, float d) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.d = d;
    this.z = z;
    
  }
  
  void draw() {
    pushMatrix();
    
    translate(x,y, z);
    strokeWeight(1);
    rotateY(r);
    fill(255);
    box(w,h,d);
    popMatrix();
  }
  
}

float GLO_rotation = PI / 8;

boolean chance(int j, int k) {
  int a = (int) random(1, k);
  return a <= j;
}
ArrayList<Tower> towers = new ArrayList<Tower>();

float flr;

void setup () {
  size(500,500, P3D);
  flr = height - 100;
  
  float w = 20;
  float h = 100;
  float d = 20;
  
  for (int x = -1000; x < 2000; x += w) {
    for (int z = -2000; z < 500; z += d) {
      h = random(30, 250);
      if (chance(1, 100)) {
        h = random(50, 500);
      }
      Tower t = new Tower(x + 2, flr, z + 2, w - 4, h , d - 4);
      t.r = 0; //PI / 8;
      towers.add(t);
    }
  }
 // noLoop();
  background(0);
   
  
  
  
}

void draw() {
  background(0);
  pushMatrix();
  translate(width / 2, 0, 0);
  directionalLight(128,20,20, -0.5,1, -1);
  
  popMatrix();
  spotLight(64,200,64, width / 2, 0, 0, -20, 1, -1, 0, 0.5);
  for (Tower t : towers) {
    t.x += xs;
    t.y += ys;
    t.z += zs;
    t.draw();
  }
 // GLO_rotation += 0.01;
}