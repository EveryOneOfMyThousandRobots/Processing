PVector start, end;
boolean draw = false;
void setup () {
  size(400, 400);
  start = new PVector();
  end = new PVector();
}

float lowest (float... nums) {
  float low = 1000000000;
  for (float f : nums) {
    if (f < low) {
      low = f;
    }
  }

  return low;
}

void draw() {
  background(0);
  noFill();
  stroke(255);
  if (draw) {
    beginShape();
    //vertex(start.x, start.y);
    float x1 = start.x;
    float y1 = start.y;
    float x2 = start.x + ((end.x -  start.x) / 2);
    float y2 = lowest(start.y, end.y) + (PVector.dist(start, end)*0.8) + 100;
    float x3 = end.x;
    float y3 = end.y;
    vertex(x1, y1);
    quadraticVertex(x2, y2, x3, y3);

    //bezierVertex(end.x - start.x, start.y + end.y + 50, end.x - start.x, start.y + end.y + 100, end.x, end.y);
    //line(start.x, start.y, end.x, end.y);
    endShape();
  }
}

void mousePressed() {
  start.set(mouseX, mouseY);
  end.set(mouseX, mouseY);
  draw  = true;
  println("start:" + start + " end: " + end);
}

void mouseDragged() {
  
  end.set(mouseX, mouseY);
  draw = true;
}

void mouseReleased() {
  draw = false;
}