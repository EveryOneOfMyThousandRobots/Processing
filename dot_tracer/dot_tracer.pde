float x, y;
float cx, cy;
//float r;
//float a;
//float ai = PI / 180;
ArrayList<Tracer> tracers = new ArrayList<Tracer>();

void setup() {
  size(400, 400);
  //cx = width / 2;
  //cy = height / 2;
  //r = width / 3;
  //x = y = a = 0;
  float ai = PI / 180;
  for (int i = 0; i < 10; i += 1) {
    Tracer t = new Tracer(0, ai + random(-ai, ai));
    tracers.add(t);
  }
}

void draw() {
  background(255);
  stroke(0);
  fill(0);
  //a += ai;

  //x = 0;
  //for (float aa = a; x <= width; aa += ai) {
  //  x+= 1;
  //  y = cy + r * sin(aa);    
  //  point(x, y);
  //}
  ////ellipse(x,y, 2, 2);
  for (Tracer t : tracers) {
    t.draw();
  }
}

class Tracer {
  float x, y;
  float cx, cy;
  float r;
  float a, ai;

  Tracer(float a, float ai) {
    cx = width / 2;
    cy = height / 2;
    r = width / 4 + random(-width / 4, width / 4);
    x = y = 0;
    this.a = a;
    this.ai = ai;
  }
  
  void draw() {
  a += ai;

  x = 0;
  for (float aa = a; x <= cx; aa += ai) {
    x+= 1;
    y = cy + r * sin(aa);    
    point(x, y);
  }
  }
}