ArrayList<Point> points = new ArrayList<Point>();


class Point {
  float[] inputs = new float[2];
  float x, y;
  int label;


  Point() {
    x = random(width);
    y = random(height);
    if (x > y) {
      label = 1;
    } else {
      label = -1;
    }
    inputs[0] = x;
    inputs[1] = y;
  }
  
  void draw() {
    stroke(0);
    if (label == 1) {
      fill(255);
      
    } else {
      fill(0);
    }
    
    ellipse(x,y,4,4);
  }
}

void initPoints() {
  for (int i = 0; i < 100; i += 1) {
    points.add(new Point());
  }
}

void drawPoints() {
  for (Point p : points) {
    p.draw();
  }
}