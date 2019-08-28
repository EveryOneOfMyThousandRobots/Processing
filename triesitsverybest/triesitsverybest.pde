import java.awt.Shape;
import java.awt.geom.Area;
import java.awt.Polygon;
import java.util.Set;
import java.util.HashSet;
ArrayList<Tri> tris = new ArrayList<Tri>();
int TRI_ID = 0;


Tri addNew(PVector A, PVector B, PVector C, Tri... parents) {
  Tri t = new Tri(getPolygon(A, B, C));
  for (Tri p : parents) {
    p.addNeighbour(t);
    t.addNeighbour(p);

  }


  tris.add(t);
  return t;
}

void setup() {
  size(600, 600);
  PVector A = new PVector(width / 2, height / 2);
  PVector B = randVector(A.x, A.y); //new PVector(randX(A.x), randX(A.y));
  PVector C = randVector(A.x, A.y); //new PVector(randX(A.x), randX(A.y));
  tris.add(new Tri(getPolygon(A, B, C)));
  frameRate(1000);
}

void draw() {
  background(0);
  for (Tri t : tris) {
    t.draw();
  }
  for (int i = 0; i < 4; i += 1) {
    findNext();
  }
}
