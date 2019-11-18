Node makeNode(Node parent, float n, boolean doubleSplit) {
  Node node = new Node();
  node.parent = parent;
  node.river = parent.river;
  node.facing = parent.facing + (radians(random(1, 45)*n));
  node.facing = constrain(node.facing, -PI-(radians(10)), radians(10));
  PVector p = new PVector(parent.x, parent.y);
  PVector pa = PVector.fromAngle(node.facing);
  pa.mult(5);
  p.add(pa);
  node.death = parent.death;
  node.split = parent.split;
  if (doubleSplit) {
    node.death = parent.death + 0.01;
    node.split = parent.split - 0.01;
  }
  node.narrow = parent.narrow * random(0.99, 1.01);
  node.widen = parent.widen* random(0.99, 1.01);
  node.w = parent.w;
  if (chance(node.narrow)) {
    node.w -= 1;
  } else if (chance(node.widen)) {
    node.w += 0.5;
  }

  if (doubleSplit) {
    node.w -= 2;
  }


  //this.len = parent.len * random(0.9,1.1);
  //this.len = constrain(this.len, 1, 10);
  node.x = floor(p.x);
  node.y = floor(p.y);
  if (!collides(node.x, node.y)) {
    addToTile(node.x, node.y);
    nodeCount += 1;
    return node;
  } else {
    return null;
  }
}


boolean collides(float x, float y) {
  for (Block b : blocks) {
    if (x >= b.pos.x && x <= b.pos.x + b.dims.x && y >= b.pos.y && y <= b.pos.y + b.dims.y) {
      return true;
    }
  }

  return false;
}

int ID = 0;
class Node {
  final int id;
  {
    ID += 1;
    id = ID;
  }
  int attempts = 30;
  int widenAmount = floor(random(10, 30));
  River river;
  Node childLeft;
  Node childRight;
  boolean alive = true;
  float split = 0.01;
  float death = 0.001;

  boolean canHaveLeft = true;
  boolean canHaveRight = true;
  boolean mustHaveLeft = false;
  boolean mustHaveRight = false;
  Node parent;
  int x, y;
  float w = 8;
  float narrow = 0.01;
  float widen = 0.004;
  float facing;
  float len;


  void widen(float n) {
    w += 1;
    if (n <= 1) {
      return;
    }
    if (parent != null) {
      parent.widen(n-1);
    }
  }

  void canSplit() {
    if (chance(0.05)) {
      river.splits -= 1;
      if (childLeft == null) {
        canHaveLeft = true;
        mustHaveLeft = true;
      } else if (childRight == null) {
        canHaveRight = true;
        mustHaveRight = true;
      }
    } else {
      if (parent != null) {
        parent.canSplit();
      }
    }
  }

  Node(int x, int y, float facing, float len, River river) {
    this.x = x;
    this.y = y;
    this.facing = facing;
    this.len = len;
    this.river = river;

    addToTile(x, y);
    nodeCount += 1;
  }

  private Node() {
  }







  void draw() {
    stroke(255);

    if (childLeft != null) {

      line(x, y, childLeft.x, childLeft.y);
      MakeWide(x, y, childLeft.x, childLeft.y, childLeft.w);


      childLeft.draw();
    } 
    if (childRight != null) {
      line(x, y, childRight.x, childRight.y);
      MakeWide(x, y, childRight.x, childRight.y, childRight.w);
      childRight.draw();
    }
  }

  void update() {

    if (!alive) return;
    if (this.w <= 0) alive = false;
    if (x < 0 || x > width || y < 0 || y > height) {
      alive = false;
      
    }



    if (childLeft == null && childRight == null) {
      if (chance(death) || attempts < 0) {
        if (parent != null) {
          parent.canSplit();
        }
        alive = false;
      } else {


        if (chance(0.5)) {
          childLeft = makeNode(this, -1, false);
          if (childLeft != null) {
            canHaveLeft = false;
          } else {
            attempts -= 1;
            parent.widen(widenAmount);
            widenAmount -= 1;
          }
        } else {
          childRight = makeNode(this, 1, false);
          if (childRight != null) {
            canHaveRight = false;
          } else {
            attempts -= 1;
            parent.widen(widenAmount);
            widenAmount -= 1;
          }
        }
      }
      return;
    }

    if (river.splits >= river.maxSplits) {
      canHaveLeft = canHaveRight = false;
    }

    if (childLeft != null) {
      childLeft.update();
      if (canHaveRight && attempts > 0) {
        canHaveRight = false;
        if (mustHaveRight || chance(split)) {
          childRight = makeNode(this, 1, true);
          if (childRight != null) {
            river.splits += 1;
            canHaveRight = false;
            mustHaveRight = false;
          } else {
            attempts -= 1;
            parent.widen(widenAmount);
            widenAmount -= 1;
          }
          return;
        } else {
        }
        canHaveRight = false;
      }
    } 

    if (childRight != null) {
      childRight.update();


      if (canHaveLeft && attempts > 0) {

        if (mustHaveLeft || chance(split)) {

          childLeft = makeNode(this, -1, true);
          if (childLeft != null) {
            river.splits += 1;
            canHaveLeft = false;
            mustHaveLeft = false;
          } else {
            attempts -= 1;
            parent.widen(widenAmount);
            widenAmount -= 1;
          }

          return;
        }
        canHaveLeft = false;
      }
    }
  }
}


void MakeWide(float x1, float y1, float x2, float y2, float w) {
  PVector a = new PVector(x1, y1);
  PVector b = new PVector(x2, y2);
  PVector c = PVector.sub(b, a);
  c.normalize();
  c.set(-c.y, c.x);
  PVector d = c.copy();
  d.mult(-1);
  c.mult(w);
  d.mult(w);

  for (float t = 0; t < 1; t += 0.1) {
    PVector aa = b.copy();
    PVector ab = b.copy();
    aa.add(PVector.mult(c, t));
    ab.add(PVector.mult(d, t));

    addToTile(aa.x, aa.y);
    addToTile(ab.x, ab.y);
  }
}
