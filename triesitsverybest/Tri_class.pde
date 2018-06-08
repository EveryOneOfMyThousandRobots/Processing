class Tri {
  Polygon poly;
  Area area;

  final int id;
  {
    TRI_ID += 1;
    id = TRI_ID;
  }


  int hashCode() {
    return id;
  }

  boolean equals(Tri t) {
    if (t.id == this.id) return true;
    return false;
  }

  ArrayList<Tri> neighbours = new ArrayList<Tri>();

  void addNeighbour(Tri t) {
    if (t.id == id) return;
    if (neighbours.contains(t)) return;
    neighbours.add(t);
  }

  Tri(Polygon poly) {
    this.poly = poly;
    this.area = new Area(poly);
  }

  void draw() {
    stroke(255);
    fill(128);
    beginShape();
    for (int n = 0; n < poly.npoints; n += 1) {
      vertex(poly.xpoints[n], poly.ypoints[n]);
    }
    endShape(CLOSE);
  }
}

float rand_range = 30;
//int randX(float x) {

//  return floor(random(x-rand_range, x + rand_range));
//}


PVector randVector(float x, float y) {
  PVector p = new PVector();
  float r = random(1, rand_range);
  float a = random(TWO_PI);

  p.x = x + r * cos(a);
  p.y = y + r * sin(a);


  return p;
}

Tri findNext() {
  PVector A = new PVector();
  PVector B = new PVector();
  PVector C = new PVector();
  int counter = 0;
  boolean done = false;
  Tri t = null;
  for (int i = tris.size()-1; i >= 0; i -= 1) {
    Tri tri = tris.get(i);

    for (int n = 0; n < tri.poly.npoints; n += 1) {

      int nn = (n+1) % tri.poly.npoints;

      A.set(tri.poly.xpoints[n], tri.poly.ypoints[n]);
      B.set(tri.poly.xpoints[nn], tri.poly.ypoints[nn]);
      C.set(0, 0);

      for (int ii = 0; ii < 100; ii += 1) {
        //C.set(randX(A.x), randX(A.y));
        C.set(randVector(A.x, A.y));
        if (valid(A, B, C)) {
          t = addNew(A, B, C, tri);
          //done = true;
          break;
        }
      }

      if (tri.neighbours.size() == 0 ) {

        for (counter = 0; counter < 10; counter += 1) {

          //C.set(randX(A.x), randX(A.y));
          C.set(randVector(A.x, A.y));

          if (valid(A, B, C)) {
            t = addNew(A, B, C, tri);
            done = true;
            break;
          }
        }
      } else {
        for (int j = tri.neighbours.size()-1; j >= 0; j -= 1) {
          Tri neighbour = tri.neighbours.get(j);

          for (int jn = 0; jn < neighbour.poly.npoints; jn += 1) {
            C.set(neighbour.poly.xpoints[jn], neighbour.poly.ypoints[jn]);
            if (valid(A, B, C)) {
              t = addNew(A, B, C, neighbour, tri);
              done = true;
              break;
            }
          }
          if (done) break;

          for (int k = neighbour.neighbours.size()-1; k >= 0; k -= 1) {
            Tri n_neighbour = neighbour.neighbours.get(k);
            for (int jn = 0; jn < n_neighbour.poly.npoints; jn += 1) {
              C.set(n_neighbour.poly.xpoints[jn], n_neighbour.poly.ypoints[jn]);
              if (valid(A, B, C)) {
                t = addNew(A, B, C, n_neighbour, neighbour, tri);
                done = true;
                break;
              }
            }
          }
        }
        if (done) break;


        for (int m = tris.size() - 1; m >= 0; m -= 1) {
          Tri mt = tris.get(m);
          if (mt.id == tri.id) continue;

          for (int jn = 0; jn < mt.poly.npoints; jn += 1) {
            C.set(mt.poly.xpoints[jn], mt.poly.ypoints[jn]);
            if (dist(A.x, A.y, C.x, C.y) < rand_range) {
              if (valid(A, B, C)) {
                t = addNew(A, B, C, tri);
                done = true;
                break;
              }
            }
          }
        }

        //if (!done) {

        //}
      }
    }
  }

  return t;
}
