import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Hashtable;
import java.util.TreeMap;
import java.util.Map;

int POINT_ID = 0;
class Point {
  PVector pos;
  PVector acc;
  PVector vel;
  ArrayList<Point> linked = new ArrayList<Point>();
  int pointId;
  Point(float x, float y) {
    pos = new PVector(x, y);
    POINT_ID += 1;
    pointId = POINT_ID;
    acc = new PVector(0, 0);
    vel = new PVector(random(-1, 1), random(-1, 1));
  }

  void update () {


    vel.add(acc);
    acc.mult(0);

    if (pos.x + vel.x >= width || pos.x + vel.x <= 0) {
      vel.x *= -1;
    }
    if (pos.y + vel.y >= height || pos.y + vel.y <= 0) {
      vel.y *= -1;
    }
    pos.add(vel);
  }

  void draw() {
    stroke(255);
    fill(255);
    ellipse(pos.x, pos.y, 2, 2);

   for (Point p : linked) {
     float dist = PVector.dist(pos, p.pos);
     float r = map(dist, 0, diag, 0, 255);
     float g = map(dist, 0, diag, 128, 0);
     
     color c = color(r,g,0);
     stroke(c);
     line(pos.x, pos.y, p.pos.x, p.pos.y);
   }
  }
}



void checkLines() {
  TreeMap<Float, Point> closest = new TreeMap<Float, Point>();
  

  for (int i = 0; i < points.size(); i += 1) {
    closest.clear();
    
    Point p = points.get(i);
    p.linked.clear();
    for (int j = 0; j < points.size(); j += 1) {
      Point o = points.get(j);
      if (p.pointId != o.pointId) {
        closest.put(PVector.dist(o.pos, p.pos), o);
      }
    }
    int k = 0;
    for (Map.Entry<Float, Point> entry : closest.entrySet()) {
      k += 1;
      if (k > 2) break;

      p.linked.add(entry.getValue());
    }
  }
}


float diag;
ArrayList<Point> points = new ArrayList<Point>();
void setup() {
  size(300, 300);
  diag = PVector.dist(new PVector(0,0), new PVector(width,height));

  for (int  i = 0; i < 10; i += 1) {
    Point p = new Point(random(width), random(height));
    points.add(p);
  }


  checkLines();


  background(0);
}

void draw() {
 // noStroke();
  //fill(0, 50);
  //rect(0,0,width,height);
  background(0);
  for (Point p : points) {
    p.update();
    p.draw();
  }
  
 // if (frameCount % 100 == 0) {
    checkLines();
 // }
}