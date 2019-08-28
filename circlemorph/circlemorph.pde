ArrayList<PVector> points = new ArrayList<PVector>();
ArrayList<PVector> starting = new ArrayList<PVector>();
ArrayList<PVector> ending = new ArrayList<PVector>();
ArrayList<PVector> temp;

void setup() {

  size(500, 500);
  float r = width / 2;
  float cx = width / 2;
  float cy = height / 2;
  for (float a = -HALF_PI; a < TWO_PI - HALF_PI; a += radians(2)) {
    float x = cx + r * cos(a);
    float y = cy + r * sin(a);

    starting.add(new PVector(x, y));
  }

  int j = starting.size() - 3;
  float x1 = cx + r * cos(-HALF_PI);
  float y1 = cy + r * sin(-HALF_PI);
  PVector A = new PVector(x1, y1);
  float x2 = cx + r * cos(-HALF_PI + (TWO_PI * 0.333));
  float y2 = cy + r * sin(-HALF_PI + (TWO_PI * 0.333));
  PVector B = new PVector(x2, y2);

  float x3 = cx + r * cos(-HALF_PI + (TWO_PI * 0.666));
  float y3 = cy + r * sin(-HALF_PI + (TWO_PI * 0.666));
  PVector C = new PVector(x3, y3);
  ending.add(A);

  float AB_dist = PVector.dist(A,B);
  float AB_step = AB_dist / (j/3);
  
  float BC_dist = PVector.dist(B, C);
  float BC_step = BC_dist / (j/3);
  
  float CA_dist = PVector.dist(C,A);
  float CA_step = CA_dist / (j/3);
  for (int i = 1; i <= (j/3); i += 1) {
    PVector AB = PVector.sub(B, A).normalize().mult(i * AB_step).add(A);
    ending.add(AB);
  }
  ending.add(B);
  for (int i = 1; i <= (j/3); i += 1) {
    PVector BC = PVector.sub(C, B).normalize().mult(i * BC_step).add(B);
    ending.add(BC);
  }
  ending.add(C);
  for (int i = 1; i <= (j/3); i += 1) { 
    PVector CA = PVector.sub(A, C).normalize().mult(i * CA_step).add(C);
    ending.add(CA);
  }

  //for (float a = 0; a < TWO_PI; a += radians(5)) {
  //  float x = cx + r * cos(a);
  //  float y = cy + r * sin(a);

  //  ending.add(new PVector(x,y));

  //}

  for (PVector p : starting) {
    points.add(p.copy());
  }
}

void draw() {
  background(0);
  stroke(255);
  noFill();
  float dist = 0;
  beginShape();
  for (int i = 0; i < points.size(); i += 1) {
    PVector p = points.get(i);
    PVector e = ending.get(i % ending.size());
    p.x = lerp(p.x, e.x, 0.05);
    p.y = lerp(p.y, e.y, 0.05);

    vertex(p.x, p.y);
    //point(p.x, p.y);
    dist += PVector.dist(p, e);
  }
  endShape(CLOSE);

  dist /= points.size();
  if (dist < 1) {
    temp = ending;
    ending = starting;
    starting = temp;
  }
}