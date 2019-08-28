class Mover {

  PVector pos, acc, vel;
  Node start, end, next;
  Finder finder;
  float speed = random(1,3);
  int pathIndex = 1;

  Mover(Node start, Node end) {

    pos = new PVector(start.pos.x, start.pos.y);
    this.start = start;
    this.end = end;
    next = null;
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
    findPath();
  }

  void findPath() {
    finder = new Finder(start, end);
    finder.findPath();
    if (finder.isValid() && finder.finalPath.size() > 5) {
      pathIndex = 1;
      next = finder.finalPath.get(pathIndex);
    } else {
      findNewPath();
    }
  }
  void findNewPath() {
    start = end;
    pos.set(end.pos);
    end = map.nodes.get(floor(random(map.nodes.size())));
    findPath();
  }

  void update() {
    if (next != null) {
      vel = PVector.sub(next.pos, pos).normalize().mult(speed);
      pos.add(vel);


      if (PVector.dist(pos, next.pos) < 2) {
        next.traffic += 20;
        pos.set(next.pos);
        pathIndex += 1;
        if (pathIndex > finder.finalPath.size() - 1) {
          findNewPath();
        } else {
          next = finder.finalPath.get(pathIndex);
        }
      }
    }
  }

  void draw() {
    stroke(255);
    fill(255);
    ellipse(pos.x, pos.y, 6, 6);
    
    //noFill();
    //stroke(255, 0, 0);
    //line(pos.x, pos.y, end.pos.x, end.pos.y);
    //stroke(0,255,0);
    //line(pos.x, pos.y, start.pos.x, start.pos.y);
    //ellipse(start.pos.x, start.pos.y, 4,  4);
    //stroke(255,255,0);
    //ellipse(next.pos.x, next.pos.y, 4,  4);
    //stroke(255,0,255);
    //ellipse(end.pos.x, end.pos.y, 4,  4);
  }
}
