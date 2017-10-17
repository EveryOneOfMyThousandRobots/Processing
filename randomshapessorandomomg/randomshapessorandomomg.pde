float rmin = -radians(5);
float rmax = radians(5);
float radius_min = 10;
float radius_max = 40;



ArrayList<CS> shapes = new ArrayList<CS>();
void setup() {
  size(400, 400);
  colorMode(HSB);
  for (int i = 0; i < 100; i += 1) {
    CS c = getNewShape();
    if (c != null) {
      shapes.add(c);
    }
  }
  
  noLoop();
}

void draw() {
  background(0);
  for (CS cs : shapes) {
    cs.draw();
    //println("point " + cs.centre);

    //printArray(cs.points);
    //printArray(cs.used);
  }
}