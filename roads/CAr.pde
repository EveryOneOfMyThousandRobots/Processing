class Car {
  PVector pos, vel, acc;
  float maxSpeed=random(1,2);
  Node start, end;
  Path path;
  float facing;
  int pathStep = 0;
  PVector target = null;
  float targetDist;
  PVector newPos;
  int id = getId("CAR");
  color col;
  int staticCount = 0;
  boolean dead = false;

  String toString() {
    return "start:" + start + "\nend:" + end + "\np:" + pos + "\nv:" + vel + "\na:" + acc + "\nt:" + target +
      "\ntd:" + targetDist + "\nstep:" + pathStep;
  }

  void newPath() {
    path = new Path(start.ix, start.iy, end.ix, end.iy);

    path.findPath();
    pathStep = path.path.size()-1;
    target = path.path.get(pathStep).targetPos;
  }

  void newEnd() {
    end = map.getRandomEmpty();
    while (start.id == end.id) {
      end = map.getRandomEmpty();
    }
  }

  Car() {

    start = map.getRandomEmpty();
    newEnd();

    pos = start.targetPos.copy();
    newPos = pos.copy();
    acc = new PVector();
    vel = new PVector();
    col = color(random(64, 255), random(64, 255), random(64, 255));
    newPath();
  }

  void update() {
    targetDist = PVector.dist(pos, target);
    if (pathStep >= 1) {
      if (targetDist < 5) {
        pathStep -= 1;
        target = path.path.get(pathStep).targetPos;
        //println("next step " +pathStep );
      }
    } else if (pathStep == 0 && targetDist < 5) {

      start = end;
      newEnd();
      newPath();
    }
    applyForce(PVector.sub(target, pos).normalize());

    vel.add(acc);
    vel.limit(maxSpeed);
    acc.mult(0);
    newPos.set(pos);
    newPos.add(vel.copy().mult(8));
    int currentNodeId = map.getIdAtPos(pos);
    int newNodeId = map.getIdAtPos(newPos);
    if (newNodeId == currentNodeId) {
      pos.add(vel);
      staticCount = 0;
    } else  if (map.isOccupiedBy(newPos) == -1 || map.isOccupiedBy(newPos) == id) {
      pos.add(vel);
      staticCount = 0;
    } else {
      staticCount += 1;
      start = map.getNodeAtPos(pos);
      newPath();
    }
    facing = vel.heading() + HALF_PI;
    if (staticCount > STOP_LIMIT) {
      addExplosion(pos.x,pos.y);
      dead = true;
    }
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void draw(boolean first) {


    stroke(0);
    fill(col);
    pushMatrix();
    rectMode(CENTER);
    translate(pos.x, pos.y);
    rotate(facing);
    rect(0, 0, 5, 10);

    popMatrix();
    if (first) {
      path.draw(color(0));
    }
  }
}