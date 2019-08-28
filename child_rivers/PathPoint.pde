boolean drawWidth = false;
class PathPoint {
  final int id;
  {
    P_ID += 1;
    id = P_ID;
  }
  PVector pos;
  float angle;
  PathPoint[] children;
  PathPoint parent;
  float w;
  boolean canHaveChildren = true;
  PathPoint(float x, float y, float angle, PathPoint parent, boolean canHaveChildren, float w) {
    this.canHaveChildren = canHaveChildren;
    this.parent = parent;
    this.w = w;

    pos = new PVector(x, y);
    this.angle = angle;
    toCheck.add(this);
    allPoints.add(this);
  }

  void draw() {

    if (children != null) {
      for (int i = 0; i < children.length; i += 1) {
        PathPoint child = children[i];

        if (child != null) {
          float cw = child.w;
          stroke(51);
          strokeWeight(2+w);
          line(pos.x, pos.y, child.pos.x, child.pos.y);
          strokeWeight(1);


          if (drawWidth) {
            PVector A = PVector.sub(child.pos, pos);
            PVector Astep = A.copy();

            for (float t = 0; t < 1; t += 0.01) {
              PVector B = PVector.mult(Astep, t);


              float ww = lerp(w, cw, t);
              PVector Bb = new PVector(B.y, -B.x);
              Bb.normalize();

              Bb.mult(ww);

              PVector Bc = Bb.copy();
              Bc.mult(-1);
              Bb.add(B);
              Bb.add(pos);
              Bc.add(B);
              Bc.add(pos);
              line(Bb.x, Bb.y, Bc.x, Bc.y);

              B.add(pos);
              point(B.x, B.y);
            }
          }
        }
      }
    }
  }



  void update() {

    if (children == null && canHaveChildren) {
      if (pos.x >= 0 && pos.x <= width && pos.y >= 0 && pos.y <= height) { 
        int cc = 1;
        if (random(100) < 5) {
          cc += 1;
        }

        if (random(100) < 3) {
          cc += 1;
        }

        if (random(100) < 1) {
          cc += 1;
        }


        children = new PathPoint[cc];//floor(random(2, 5))];


        //float step = (ea - sa) / (float) children.length;


        for (int i = 0; i < children.length; i += 1) {
          boolean found = false;
          int attempts = 0;
          while (!found) {
            float sa = angle - radians(random(1, 45));
            sa = constrain(sa, -PI, 0);

            float ea = angle + radians(random(1, 45));
            ea = constrain(ea, -PI, 0);


            attempts += 1;
            if (attempts > 100) break;
            float ca = random(sa, ea);
            float len = random(MIN_LENGTH, MAX_LENGTH);
            float xx = pos.x + len * cos(ca);
            float yy = pos.y + len * sin(ca);

            found = true;
            for (Block b : blocks) {
              if (b.pointInside(xx, yy)) {
                found = false;
                break;
              }
              //float dist = PVector.dist(np, b.pos);

              //if (dist < width/2 && dist > 0) {
              //  PVector s = PVector.sub(np, b.pos);
              //  s.normalize();
              //  s.mult(1.0 / (dist*dist));
              //  s.mult(1000);
              //  np.add(s);
              //}
            }
            if (!found) continue;

            //xx = np.x;
            //yy = np.y;


            boolean breakNeeded = false;
            boolean chc = true;
            for (PathPoint p : allPoints) {
              if (!found) break;
              if (p.id == id) continue; 
              if (p.parent != null && p.parent.id == id) continue;

              if (p.children != null) {
                for (PathPoint pc : p.children) {
                  if (pc == null) continue;
                  if (pc.parent != null && pc.parent.id == id) continue;    
                  //if (!same(pc.pos, xx, yy) && !same(p.pos,xx,yy) && !same(pos,xx,yy)) { 
                  if (linesIntersect(pos.x, pos.y, xx, yy, p.pos.x, p.pos.y, pc.pos.x, pc.pos.y)) {
                    PVector ipoint = intersectionPoint(pos.x, pos.y, xx, yy, p.pos.x, p.pos.y, pc.pos.x, pc.pos.y);

                    xx = ipoint.x;
                    yy = ipoint.y;
                    breakNeeded = true;
                    chc = false;
                    break;
                  }
                  //}
                }
              } else {
                continue;
              }
              if (breakNeeded) break;
            }
            if (found) {
              children[i] = new PathPoint(xx, yy, ca, this, chc, w/(float)cc );
            }
          }
        }
      }
    }
  }
}
