import java.awt.Polygon;
import java.awt.geom.Area;
int tri_range = 50;


ArrayList<Triangle> tris = new ArrayList<Triangle>();



void addPolygon() {
  //int counter = 0;
  //while (polys.size() < 500 && counter < 1000) {
  Polygon r = tris.get(floor(random(tris.size()))).p;

  Polygon p1 = new Polygon();
  int i = floor(random(r.npoints));
  int j = (i+1)%r.npoints;
  int xx = r.xpoints[i];
  int yy = r.ypoints[i];
  p1.addPoint(xx, yy);
  p1.addPoint(r.xpoints[j], r.ypoints[j]);

  if (random(1) < 0.5) {
    int counter = 0;
    while (true) {
      counter += 1;
      if (counter > 100) return;
      Polygon s = tris.get(floor(random(tris.size()))).p;
      int k1 = floor(random(s.npoints));
      int kx = s.xpoints[k1];
      int ky = s.ypoints[k1];
      if (dist(xx, yy, kx, ky) > tri_range) {
      } else {

        p1.addPoint(s.xpoints[k1], s.ypoints[k1]);
        break;
      }
    }
  } else {
    p1.addPoint(rand(xx), rand(yy));
  }

  Area a = new Area(p1);
  if (a.isEmpty()) {
    return;
  }





  boolean ok = true;
  for (Triangle t : tris) {
    a = new Area(p1);
    Area b = new Area(t.p);
    a.intersect(b);
    if (!a.isEmpty()) {
      ok = false;
      break;
    }
  }
  if (ok) {
    tris.add(new Triangle(p1));
    //counter = 0;
  }
  //counter += 1;
  //}
}

void setup() {
  size(500, 500);
  colorMode(HSB);

  Polygon p = new Polygon();
  int x = width / 2;//randX();
  int y = height / 2;
  randY();
  p.addPoint(x, y);
  p.addPoint(rand(x), rand(y));
  p.addPoint(rand(x), rand(y));

  tris.add(new Triangle(p));



  //noLoop();
}

int rand(int x) {
  int xx = 0;
  while (true) {
    xx = floor(random(x - tri_range, x + tri_range));
    if (xx <= 0 || xx >= width) {
      continue;
    } else {
      break;
    }
  }
  return xx;
}

int randX() {
  return floor(random(width));
}

int randY() {
  return floor(random(height));
}


void draw() {
  background(0);
  drawPolys();
  for (int i = 0; i < 30; i += 1) {
    addPolygon();
  }
}

void drawPolys() {
  noStroke();
  //stroke(255);

  for (Triangle t : tris) {
    t.draw();
  }
}
