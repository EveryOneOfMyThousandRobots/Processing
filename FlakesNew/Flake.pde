class Flake {
  float sections, sectionAngle;
  float radius;
  PVector pos, acc, vel;
  float mass;
  

  int numPointsA, numPointsB;

  ArrayList<PVector> pointsA = new ArrayList<PVector>();
  ArrayList<PVector> pointsB = new ArrayList<PVector>();
  ArrayList<PVector> pointsC = new ArrayList<PVector>();
  ArrayList<Line> lines = new ArrayList<Line>();


  Flake (int sections, int radius, float x, float y) {
    this.sections = sections;
    this.sectionAngle = TWO_PI / sections;
    this.radius = radius;
    this.pos = new PVector(x,y);
    mass = (PI * radius * radius) * 0.04;
    acc = new PVector();
    vel = new PVector();
    //this.y = y;
    //ys = random(1,2);

    numPointsA = floor(random(5, 12));
    numPointsB = floor(random(5, 12));

    float angleA = 0;
    float angleB = sectionAngle / 2;
    for (int i = 0; i < numPointsA; i += 1) {
      float r = random(radius * 0.1, radius);
      float xx = r * cos(angleA);
      float yy = r * sin(angleA);
      pointsA.add(new PVector(xx, yy));
      xx = r * cos(angleA + sectionAngle);
      yy = r * sin(angleA + sectionAngle);
      pointsC.add(new PVector(xx, yy));
    }

    for (int i = 0; i < numPointsB; i += 1) {
      float r = random(radius * 0.1, radius);
      float xx = r * cos(angleB);
      float yy = r * sin(angleB);
      pointsB.add(new PVector(xx, yy));
    }

    for (int i = 0; i < pointsA.size(); i += 1) {
      PVector from = pointsA.get(i).copy();
      PVector to = pointsB.get(floor(random(pointsB.size()))).copy();
      PVector to2 = pointsC.get(i).copy();
      Line l1 = new Line(from, to);
      Line l2 = new Line(to, to2);


      lines.add(l1);
      lines.add(l2);
    }

    pointsA.clear();
    pointsB.clear();
    pointsC.clear();
  }
  
  void applyForce(PVector force) {
    if (force == null) return;
    acc.add(force.copy().div(mass));
  }

  void draw() {
    noFill();
    stroke(255);
    pushMatrix();
    translate(pos.x, pos.y);
    for (float a = 0; a < sections; a += 1) {
      pushMatrix();
      rotate(sectionAngle * a);
      for (Line line : lines) {
        line.draw();
      }
      popMatrix();
    }
    popMatrix();
  }

  void update() {
    vel.add(acc);
    acc.mult(0);
    //vel.limit(4);
    pos.add(vel);
    //vel.limit(6);
    vel.mult(0.99);
    
    
  }
}