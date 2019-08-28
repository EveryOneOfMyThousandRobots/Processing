ArrayList<Tri> triangles = new ArrayList<Tri>();
ArrayList<PVector> points = new ArrayList<PVector>();
final float MIN_AREA = 100;

void setup () {
  size(600, 600);
  while (triangles.size() == 0) {
    PVector a = new PVector(floor(width/2), floor(height/2));
    PVector b = randomWithinRange(a, 50, 100);
    PVector c = randomWithinRange(b, 50, 100);
    Tri tri = new Tri(a, b, c);
    if (tri.area < MIN_AREA) continue;
    triangles.add(tri);
  }
}

boolean pointInAnyTriangle(float x, float y) {
  for (Tri tri : triangles) {
    if (pointInTriangle(tri.A.x, tri.A.y, tri.B.x, tri.B.y, tri.C.x, tri.C.y, x, y)) {
      return true;
    }
  }

  return false;
}




void addTri(Tri t) {
  PVector A = t.points[floor(random(t.points.length))];
  PVector B = A;
  while (B == A) {
    B = t.points[floor(random(t.points.length))];
  }
  if (A == null || B == null) return;
  boolean ff = false;
  PVector C = null;
  if (triangles.size() > 3) {
    for (Tri to : triangles) {
      for (PVector p : to.points) {


        if (!anyLinesIntersect(A, B, p)) {
          C = p;
          ff = true;
          println("found an existing triangle point");
          break;
        }
      }

      if (C != null) {
        break;
      }
    }
  }



  if (!ff) {
    int attempts = 0; 
    while (C == null && attempts < 50) {
      attempts += 1; 
      C = randomWithinRange(A, 50, 100); 
      if (pointInAnyTriangle(C.x, C.y)) {
        C = null;
      } else if (anyLinesIntersect(A, B, C)) {
        C = null;
      }
    }
  }

  if (C != null) {
    Tri tri = new Tri(A, B, C); 
    if (tri.area >= MIN_AREA) {
      triangles.add(tri);
    } else {
      println("too small");
    }
  }
}

boolean anyLinesIntersect(PVector a, PVector b, PVector c) {

  for (Tri tri : triangles) {
    if (tri.lineIntersects(a, b) || tri.lineIntersects(a, c) || tri.lineIntersects(b, c)) {
      println("intersections");
      return true;
    }
  }


  return false;
}

PVector randomWithinRange(PVector p, float min, float max) {
  float r = random(min, max); 
  float a = random(TWO_PI); 
  float x = p.x + r * cos(a); 
  float y = p.y + r * sin(a); 

  return new PVector(floor(x), floor(y));
}

int pIndex = 0; 
color BLACK = color(0); 
color RED = color(255, 0, 0); 
color BLUE = color(0, 0, 255); 
color GREEN = color(0, 255, 0); 
color WHITE = color(255); 

void draw() {
  background(255); 


  for (Tri p : triangles) {
    p.draw();
  }

  for (PVector p : points) {
    circ(p, 4, BLACK);
  }

  Tri t = triangles.get(floor(random(triangles.size()))); 
  if (t != null) {
    addTri(t);
  }
}











void PVLine(PVector a, PVector b) {
  stroke(0); 
  line(a.x, a.y, b.x, b.y);
}

void circ(PVector p, float d, color c) {
  stroke(c); 
  noFill(); 
  ellipse(p.x, p.y, d, d);
}

void circ(String name, PVector p, float d, color c) {
  stroke(c); 
  noFill(); 
  ellipse(p.x, p.y, d, d); 
  fill(0); 
  text(name, p.x+10, p.y);
}
