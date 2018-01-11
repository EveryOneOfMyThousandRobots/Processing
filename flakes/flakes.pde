float sections = 8;
float angleStart = 0;
float angleEnd = TWO_PI / sections;
float radius;
int numPoints = 6;
float cx, cy;

class Line {
  ArrayList<PVector> points = new ArrayList<PVector>();

  Line() {
    points.add(new PVector(0, 0));
    float prevRadius = 1;
    for (int i = 0; i < numPoints; i += 1) {
      float r = random(prevRadius, radius - ((radius - prevRadius) /2));
      float a = random(angleStart, angleEnd);
      float x = r * cos(a);
      float y = r * sin(a);
      points.add(new PVector(x, y));
      prevRadius = r;
    }
  }
}
class Flake {

  ArrayList<Line> lines = new ArrayList<Line>();
  Flake() {
    lines.add(new Line());
    lines.add(new Line());
    lines.add(new Line());
  }

  void draw() {
    pushMatrix();
    translate(cx, cy);
    for (float ai = 0; ai < sections; ai += 1) {
      pushMatrix();
      rotate(ai * angleEnd);
      //println(angleEnd);
      for (Line l : lines) {

        beginShape();
        for (PVector p : l.points) {
          vertex(p.x, p.y);
        }
        endShape();
      }
      popMatrix();
    }

    popMatrix();
  }
}


ArrayList<Flake> flakes = new ArrayList<Flake>();

void setup() {
  size(200, 200);
  cx = width / 2;
  cy = height / 2;
  radius = width / 8;

  flakes.add(new Flake());
  noLoop();
}

void draw() {
  background(0);
  stroke(255);
  noFill();
  for (Flake flake : flakes) {
    flake.draw();
  }
}