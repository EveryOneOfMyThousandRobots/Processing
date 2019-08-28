class Ray {
  final float MAX_DIST = AREA_WIDTH * 2;
  final float CAP_DIST = AREA_WIDTH;
  PVector pos, dir, posEnd, collidesAt;
  boolean collided = false;
  float t, u;
  PVector temp = new PVector();
  float angle = 0;
  float colourDist = 0;
  color col = color(255);
  final int index;
  Ray(PVector pos, float angle, int index) {
    this.pos = pos;
    dir = PVector.fromAngle(angle);
    posEnd = PVector.add(pos, PVector.mult(dir, MAX_DIST));
    collidesAt = new PVector();
    this.angle = angle;
    this.index = index;
  }

  void updateDir(PVector pointAt) {
    dir = PVector.sub(pointAt, pos);
    dir.normalize();
    posEnd = PVector.add(pos, PVector.mult(dir, MAX_DIST));
    colourDist = PVector.dist(pos, posEnd);
    updateDist();
  }

  void updateAngle(float angle) {
    //this.angle += angle;
    //this.angle = this.angle % TWO_PI;
    dir = PVector.fromAngle(this.angle + angle);
    dir.normalize();
    posEnd = PVector.add(pos, PVector.mult(dir, MAX_DIST));
    colourDist = PVector.dist(pos, posEnd);
    updateDist();
  }

  void update() {
    posEnd = PVector.add(pos, PVector.mult(dir, MAX_DIST));
    updateDist();
  }

  void updateDist() {
    colourDist = constrain(PVector.dist(pos, collidesAt), 0, CAP_DIST);
  }


  void draw() {
    //println(colourDist + " " + width);
    col = color(map(colourDist, 0, CAP_DIST, 255, 0));
    float h = map(colourDist, 0, CAP_DIST, 0, render.height);
    //stroke(255);
    //pushMatrix();
    //translate(pos.x, pos.y);
    //line(0, 0, dir.x * 20, dir.y *  20);
    //popMatrix();

    if (collided) {
      //edges.noStroke();
      //edges.fill(255);
      //edges.ellipse(collidesAt.x, collidesAt.y, 4, 4);
      //noStroke();
      //fill(col);
      //ellipse(collidesAt.x, collidesAt.y, 4, 4);
      topDown.stroke(col);
      topDown.line(pos.x, pos.y, collidesAt.x, collidesAt.y);
      render.stroke(col);
      float x = index;//map(index, 0, p.rays.size(), 0, render.width);
      render.line(x,0+(h/2),x,render.height - (h/2));
    } else {
      topDown.stroke(col);
      topDown.line(pos.x, pos.y, posEnd.x, posEnd.y);
    }
  }

  boolean cast(ArrayList<Wall> walls) {
    //ArrayList<Wall> walls = new ArrayList<Wall>();
    //for (Polygon pp : polys) {

    //  walls.addAll(pp.walls);
    //}
    collided = false;

    float dist = 0;
    float minDist = -1;
    PVector closest = null;

    boolean foundOne = false;
    for (Wall wall : walls) {
      //PVector p = null;
      t = t(pos, posEnd, wall.ps, wall.pe);
      u = u(pos, posEnd, wall.ps, wall.pe);


      if (t > 0 && t < 1 && u > 0 && u < 1) {
        //p = new PVector();

        temp.x = pos.x + t * (posEnd.x - pos.x);
        temp.y = pos.y + t * (posEnd.y - pos.y);
        dist = PVector.dist(pos, temp);

        if (!foundOne || dist < minDist) {
          minDist = dist;
          closest = temp.copy();
          foundOne = true;
        }
      }
    }

    if (closest != null) {
      collidesAt.set(closest);
      collided = true;
      return true;
    }
    //println(t + " " + u);
    return false;
  }
}

float t(PVector s1, PVector e1, PVector s2, PVector e2) {
  return t(s1.x, s1.y, e1.x, e1.y, s2.x, s2.y, e2.x, e2.y);
}

float t(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float te = (x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4);
  float td = ud(x1, y1, x2, y2, x3, y3, x4, y4);
  return te / td;
}

float u(PVector s1, PVector e1, PVector s2, PVector e2) {

  return u(s1.x, s1.y, e1.x, e1.y, s2.x, s2.y, e2.x, e2.y);
}

float u(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float ue = (x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3);
  float ud = ud(x1, y1, x2, y2, x3, y3, x4, y4);
  return -(ue / ud);
}

float ud(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  return (x1 - x2) * (y3 - y4) - (y1 - y2)*(x3-x4);
}
