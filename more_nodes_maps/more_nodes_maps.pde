class Node {
  boolean origin = false;
  PVector pos = new PVector();
  float angle, dist;
  float lastChildAngle = 0;
  ArrayList<Node> children = new ArrayList<Node>();
  Node parent = null;

  Node (Node parent) {
    this.parent = parent;
    if (this.parent == null) {
      origin = true;
    }
  }

  boolean addChild() {

    if (children.size() > 3) {
      for (Node c : children) {
        if (c.addChild()) {
          return true;
        }
      }
    } else {
      Node n = new Node(this);
      n.dist = 50;
      n.angle = lastChildAngle + HALF_PI + random(-HALF_PI, HALF_PI);
      lastChildAngle = n.angle;
      children.add(n);
      return true;
    }

    return false;
  }


  void draw() {

    stroke(255);
    for (Node n : children) {
      line(pos.x, pos.y, n.pos.x, n.pos.y);
    }

    if (origin) {
      stroke(255, 0, 0);
    } else {
      stroke(255);
    }

    fill(255);
    ellipse(pos.x, pos.y, 5, 5);

    for (Node n : children) {
      n.draw();
    }
  }

  void update() {
    if (parent == null) {
    } else {
      pos.x = parent.pos.x + dist * cos(angle);
      pos.y = parent.pos.y + dist * sin(angle);
    }

    for (Node c : children) {
      c.update();
    }
  }
}

Node origin;
void setup() {
  size(800, 800);
  origin = new Node(null);
  origin.pos.x = width / 2;
  origin.pos.y = height / 2;

  for (int i = 0; i < 20; i += 1) {
    origin.addChild();
  }
}


void draw() {
  background(0);
  origin.update();
  origin.draw();
}
