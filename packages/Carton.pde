

class Carton {
  Node start, end;
  Node current = null;
  Node next = null;
  PathFinder path;
  int pathIndex = -1;
  boolean arrived = false;
  Truck truck = null;
  int lifeTime = 0;

  PVector pos;

  Carton(Node start, Node end) {
    this.start = start;
    this.end = end;
    //start = getRandomNode(NODE_TYPE.SHOP);
    //end = getRandomNode(NODE_TYPE.CUSTOMER);
    current = start;
    current.cartons.add(this);
    pathIndex = 1;

    path = new PathFinder(start, end);
    pos = start.pos.copy();
  }
  
  void pickup(Truck truck) {
    this.truck = truck;
  }



  void update() {
    if (arrived) return;
    lifeTime += 1;
    
    if (current == null) {
      current = start;
      pathIndex = 1;
    }
    if (pathIndex == path.path.size()) {
      arrived = true;
      return;
      
    }
    next = path.path.get(pathIndex);
    if (next != null) {
      //PVector move = PVector.sub(next.pos, pos);
      
      //move.normalize();
      //move.mult(2);
      //pos.add(move);
      
      //if (PVector.dist(pos, next.pos) < 3) {
      //  pos = next.pos.copy();
      //  pathIndex += 1;
      //  if (pathIndex == path.path.size()) {
      //    arrived = true;
      //  }
      //}
    }
  }
  
  
  void draw(float cx, float cy, float r, float a) {
    float x = cx + r * cos(a);
    float y = cy + r * sin(a);
    stroke(0,255,0);
    point(x,y);
  }

  void draw() {
    stroke(0, 255, 0);
    fill(0, 255, 0);
    ellipse(pos.x, pos.y, 4, 4);
  }
  
  
}
