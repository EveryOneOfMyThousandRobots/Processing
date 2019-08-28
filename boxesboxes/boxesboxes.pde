import peasy.PeasyCam;

//PeasyCam cam;
float default_w,default_d;
class B {
  PVector pos;
  PVector dims;
  PVector ref;
  
  B(float x, float y, float z, float w, float h, float d) {
    pos = new PVector(x,y,z);
    dims = new PVector(w,h,d);
    ref = new PVector(x/w,0,z/d);
    
    setH();
  }
  
  void setH() {
    dims.y = 255 * noise(ref.x, ref.y, ref.z);
  }
  
  void draw() {
    pushMatrix();
    stroke(255);
    fill(128);
    translate(pos.x, pos.y, pos.z);
    box(dims.x, dims.y, dims.z);
    popMatrix();
  }
  
  void update() {
    ref.z -= 0.01;
    setH();
  }
  String toString() {
    return pos.toString();
  }
}

ArrayList<B> boxes = new ArrayList<B>();

void setup() {
  size(400,400, P3D);
  //cam = new PeasyCam(this,400);
  
  default_w = width / 10;
  default_d = height / 10;
  
  for (float x = 0; x < default_w; x += 1) {
    for (float z = 0; z < default_d; z += 1) {
      B b = new B(-width + (x*default_w), height, -z * default_d, default_w, 0, default_d);
      
      
      boxes.add(b);
    }
  }
  
  printArray(boxes);
  
}

void draw() {
  background(0);
  lights();
  for (B b : boxes) {
    b.update();
    b.draw();
  }
}