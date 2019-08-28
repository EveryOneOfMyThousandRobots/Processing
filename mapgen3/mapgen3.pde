ArrayList<Pt> points = new ArrayList<Pt>();
ArrayList<PVector[]> lines = new ArrayList<PVector[]>();
ArrayList<PVector[]> borders = new ArrayList<PVector[]>();
HashSet<PVector> vertices = new HashSet<PVector>();
import java.util.*;

Pt[][] values;
int[][] Ids;
int PT_ID = 0;
class Pt {

  final int id;
  {
    PT_ID += 1;
    id = PT_ID;
  }
  PVector pos;
  color c;

  Pt() {
    pos = new PVector(random(width), random(height));
    c = color(random(128, 255), random(128, 255), random(128, 255));
  }

  boolean equals(Pt p) {
    return id == p.id;
  }


  void draw() {
    stroke(0);
    fill(c);
    ellipse(pos.x, pos.y, 4, 4);
  }
}


void setup() {
  size(600, 600);

  values = new Pt[width][height];
  Ids = new int[width][height];
  for (int i = 0; i < 4; i += 1) {
    points.add(new Pt());
  }

  for (Pt p1 : points) {
    for (Pt p2 : points) {
      if (!p1.equals(p2)) {
        PVector[] line = {p1.pos, p2.pos};
        lines.add(line);
      }
    }
  }

  ArrayList<PVector[]> removeUs = new ArrayList<PVector[]>();

  for (int i = 0; i < points.size(); i += 1) {
    Pt p1 = points.get(i);
    for (int j = i+1; j < points.size(); j += 1) {
      if (i == j) continue;
      Pt p2 = points.get(j);


      PVector AB = PVector.sub(p2.pos, p1.pos);
      PVector ABr = new PVector(-AB.y, AB.x);
      PVector ABrr = PVector.mult(ABr, -1f);
      ABr.mult(width);
      ABrr.mult(width);
      ABr.add(p1.pos);
      ABr.add(PVector.mult(AB, 0.5));
      ABrr.add(p1.pos);
      ABrr.add(PVector.mult(AB, 0.5));
      PVector[] nl = {ABr, ABrr};
      borders.add(nl);
    }
  }



  for (int i = lines.size() - 1; i >= 0; i -= 1) {
    PVector[] A = lines.get(i);
    if (removeUs.contains(A)) continue;
    PVector AA = A[0];
    PVector AB = A[1];
    for (int j = lines.size() - 1; j >= 0; j -= 1) {
      if (i == j) continue;


      PVector[] B = lines.get(j);
      if (removeUs.contains(B)) continue;

      PVector BA = B[0];
      PVector BB = B[1];

      if (linesIntersect(AA.x, AA.y, AB.x, AB.y, BA.x, BA.y, BB.x, BB.y)) {

        float distA = PVector.dist(AA, AB);
        float distB = PVector.dist(BA, BB);

        if (distA <= distB) {
          removeUs.add(B);
        } else {
          removeUs.add(A);
          break;
        }
      }
    }
  }
  println("num to remove: "+ removeUs.size());

  for (int i = 0; i < removeUs.size(); i += 1) {
    if (!lines.remove(removeUs.get(i))) {
      println("failed to remove");
    }
  }



  calcValues();
}

void calcValues() {
  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      Pt closest = null;
      float dist = 0;
      float shortest = 0;
      for (Pt p : points) {
        dist = dist(p.pos.x, p.pos.y, x, y);
        if (closest == null || dist < shortest) {
          closest = p;
          shortest = dist;
        }

        if (closest != null) {
          values[x][y] = closest;
          Ids[x][y] = closest.id;
        }
      }
    }
  }

  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {

      int id = Ids[x][y];

      HashSet<Integer> encountered = new HashSet<Integer>();
      HashSet<String> edges = new HashSet<String>();
      for (int xx = x-1; xx < x + 2; xx += 1) {
        for (int yy = y-1; yy < y + 2; yy += 1) {
          if (xx == x && yy == y) continue;
          //if (abs(abs(xx) - abs(yy)) > 1) continue;
          if (xx >= 0 && xx <= width-1 && yy >= 0 && yy < height-1) {


            int oid = Ids[xx][yy];
            if (oid != id) {
              if (!encountered.contains(oid)) {
                encountered.add(oid);
              }
            }
          } else {
            if (xx < 0) {
              edges.add("left");
            } else  if (xx > width-1) {
              edges.add("right");
            } else if (yy < 0) {
              edges.add("up");
            } else if (yy > height-1) {
              edges.add("down");
            }
          }
        }
      }

      if (edges.size() + encountered.size() >= 2) {
        println(edges.size() + " " + encountered.size());
        vertices.add(new PVector(x, y));
      }
    }
  }
}



void draw() {
  background(255);
  loadPixels();
  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      pixels[y * width + x] = values[x][y].c;
    }
  }
  updatePixels();
  stroke(0);
  for (PVector[] ln : lines) {

    line(ln[0].x, ln[0].y, ln[1].x, ln[1].y);
  }

  stroke(255, 0, 0, 128);
  noFill();
  for (PVector v : vertices) {
    ellipse(v.x, v.y, 10, 10);
  }

  //stroke(255, 0, 0, 128);
  //for (PVector[] ln : borders) {

  //  line(ln[0].x, ln[0].y, ln[1].x, ln[1].y);
  //}


  for (Pt p : points) {
    p.draw();
  }
}
