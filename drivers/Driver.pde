import java.awt.Rectangle;

class Driver {
  PVector pos, vel, acc, view;
  float facing;
  color col;
  PathFinder path = null;
  Node next = null;
  float breakingForce = 0.05;
  float maxSpeed = 0.8;
  float maxForce = 0.01;
  int pathStep = 0;
  float dist = 0;
  Rectangle rect;
  float w = 5, h = 10;
  float viewDist = 100;


  Driver(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();
    view = new PVector();
    col = color(random(128, 255), random(128, 255), random(128, 255));
    rect = new Rectangle(int(x - (w/2)), int(y - (h/2)), floor(w), floor(h));
  }

  void setPath(Node start, Node end) {
    path = new PathFinder(start, end);
    pathStep = 0;
  }

  void update() {


    vel.add(acc);
    vel.limit(maxSpeed);
    acc.mult(0);
    pos.add(vel);
    view.set(vel);
    view.setMag(viewDist);
    view.add(pos);
    vel.mult(0.99);



    if (path != null) {
      if (next == null) {
        pathStep += 1;
      }
      next = path.path.get(pathStep);

      dist = PVector.dist(pos, next.pos);

      if (dist < 4) {
        pathStep += 1;
        if (pathStep >= path.path.size()-1) {
          newPath();
        }
      }
    }
  }

  void steer() {
    if (next != null) {
      steer(next.pos);
    } else if (mousePressed) {
      steer(new PVector(mouseX, mouseY));
    } else {
      slow();
    }
  }

  void newPath() {
    Node newStart = path.end;
    Node newEnd = getRandomNode();
    next = null;
    pathStep = 0;
    setPath(newStart, newEnd);
  }

  void steer(PVector tgt) {

    PVector desired = PVector.sub(tgt, pos);
    desired.setMag(maxSpeed);
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxForce);
    applyForce(steer);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void slow() {
    if (vel.mag() > 0) {
      PVector b = vel.copy();
      b.mult(-1);
      b.normalize();
      b.mult(breakingForce);
      applyForce(b);
    }
  }

  void draw() {
    facing = vel.heading() + HALF_PI;
    pushMatrix();
    stroke(255);
    fill(col);
    translate(pos.x, pos.y);
    rotate(facing);
    rectMode(CENTER);
    rect(0, 0, 5, 10);

    popMatrix();
    line(pos.x, pos.y, view.x, view.y);

    if (path != null) {
      //path.draw();
    }
    //text(pathStep + " " + int(dist), 10, 10);
  }
}
