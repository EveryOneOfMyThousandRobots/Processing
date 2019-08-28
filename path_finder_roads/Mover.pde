class Mover {
  Node start, goal;
  PVector pos, acc, vel, currentGoal = null;
  float maxSpeed = 1;
  float maxForce = 0.1;
  Path path;
  int pathIndex = 0;
  Mover() {
    start = getRandomNode();
    goal = getRandomNode();
    while (goal.equals(start)) {
      goal = getRandomNode();
    }
    pos = start.pos.copy();
    acc =  new PVector();
    vel = new PVector();

    path = new Path(start, goal);
  }


  void steer(PVector f) {
    PVector desired = PVector.sub(f, pos);
    desired.normalize();
    desired.mult(maxForce);
    PVector steer = PVector.sub(desired, vel);

    applyForce(steer);
  }

  void applyForce(PVector f) {
    acc.add(f);
  }

  void update() {
    if (currentGoal == null) {
      pathIndex += 1;
      currentGoal = path.path.get(pathIndex).pos.copy();
    }
    
    steer(currentGoal);
    vel.add(acc);
    pos.add(vel);
    
    if (
  }
}
