class River {
  boolean stopAdding = false;
  PVector start, end;
  ArrayList<PVector> points = new ArrayList<PVector>();
  PVector lastAdded = null;
  int lastAddedIndex = -1;
  River(ArrayList<PVector> addMe) {
    start = addMe.get(0);
    end = addMe.get(addMe.size()-1);
    points.addAll(addMe);
  }

  River(float sx, float sy, float ex, float ey) {
    start = new PVector(sx, sy);
    end = new PVector(ex, ey);
    points.add(start);
    points.add(end);
  }

  void update() {
    if (points.size() < 50) {
      addPoint();
    } else {
      stopAdding = true;
    }

    if (random(100) < 1 && rivers.size() < 3) {
      if (lastAdded != null) {
        if (lastAddedIndex >= 5) {
          float sx = lastAdded.x;
          float sy = lastAdded.y;

          ArrayList<PVector> childStarterNodes = new ArrayList<PVector>();
          childStarterNodes.add(points.get(lastAddedIndex-2).copy());
          childStarterNodes.add(points.get(lastAddedIndex-1).copy());
          childStarterNodes.add(points.get(lastAddedIndex).copy());

          float ex = random(width / 4, width - (width / 4));
          float ey = height + 50;
          childStarterNodes.add(new PVector(ex,ey));
          
          rivers.add(new River(childStarterNodes));
        }
      }
    }
  }

  void draw() {
    if (points.size() < 10) {
      stroke(255);
      for (int i = 0; i < points.size()-1; i += 1) {
        PVector A = points.get(i);
        PVector B = points.get(i+1);

        line(A.x, A.y, B.x, B.y);
      }
    } else {
      stroke(255, 0, 0, 128);
      PVector pos, posPrev = null;
      for (float t = 0; t < (float)points.size()-3; t += 0.005) {
        pos = GetSplinePoint(points, t, false);
        float w = noise(pos.x, pos.y);



        point(pos.x, pos.y);

        if (posPrev != null) {
          PVector dir = PVector.sub(posPrev, pos);
          dir.set(dir.y, -dir.x);
          PVector odir = dir.copy().mult(-1).mult(w * 100).mult(2);
          dir.mult(w * 100);
          dir.add(pos);
          line(dir.x, dir.y, dir.x + odir.x, dir.y + odir.y);
          if (stopAdding) {
            for (float t2 = 0; t2 < 1; t2 += 0.01) {
              map.setByScreenPos(dir.x + (odir.x*t2), dir.y + (odir.y*t2));
            }
          }
        }

        if (stopAdding) {
          //map.setByScreenPos(pos.x,pos.y);
        }
        posPrev = pos;
      }
      strokeWeight(1);
    }
  }
  float pr = 0.5;
  void addPoint() {
    if (stopAdding) return;
    lastAdded = null;
    lastAddedIndex = -1;
    int index = -1;
    float furthest = 0;

    for (int i = 0; i < points.size()-1; i += 1) {
      PVector AA = points.get(i);
      PVector BB = points.get(i+1);

      float dist = PVector.dist(AA, BB);
      if (dist < width / 16) continue;
      if (index == -1 || dist > furthest) {
        index = i;
        furthest = dist;
      }
    }



    if (index >= 0) {
      PVector A = points.get(index);
      PVector B = points.get(index+1);

      PVector C = PVector.sub(B, A);
      float dist = C.mag();
      float r = pr * random(0.5, 1.5);
      r = constrain(r, 0, 1);
      float a = map(r, 0, 1, -QUARTER_PI, QUARTER_PI);
      C = PVector.fromAngle(C.heading() + a);
      C.mult(random(dist/4, dist*0.75));
      C.add(A);
      points.add(index + 1, C);
      lastAdded = C;
      lastAddedIndex = index + 1;
      pr = r;
    } else {
      stopAdding = true;
    }
  }
}
