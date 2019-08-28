class Line {
  PVector from, to;
  Line(float x1, float y1, float x2, float y2) {
    from = new PVector(x1, y1);
    to = new PVector(x2, y2);
  }

  void draw() {
    stroke(255);
    line(from.x, from.y, to.x, to.y);
  }
}

Line l1, l2;
float a,b;
float a1, b1;
PVector sub1;
void setup() {
  size(500, 500);
  l1 = new Line(random(width), random(height), random(width), random(height));
  l2 = new Line(random(width), random(height), 0, 0);
  sub1 = PVector.sub(l1.to, l1.from);
  a = sub1.y / sub1.x;
  b = l1.from.y - a * l1.from.x;
}

void draw() {
  background(0);
  l2.to.set(mouseX, mouseY);
  l1.draw();
  l2.draw();
  
  PVector sub2 = PVector.sub(l2.to, l2.from);
  a1 = sub2.y / sub2.x;
  b1 = l2.from.y - a1 * l2.from.x;
  
  float x = (b1 - b) / (a - a1);
  float y = a * x + b;
  
  if ((x > min(l1.from.x, l1.to.x)) && (x < max(l1.from.x, l1.to.x)) 
      && (y > min(l1.from.y, l1.to.y)) && (y < max(l1.from.y, l1.to.y))
    && (x > min(l2.from.x, l2.to.x)) && (x < max(l2.from.x, l2.to.x)) 
    && (y > min(l2.from.y, l2.to.y)) && (y < max(l2.from.y, l2.to.y))) {
    fill(255, 0, 0);
    ellipse(x, y, 20, 20);
  }
}
