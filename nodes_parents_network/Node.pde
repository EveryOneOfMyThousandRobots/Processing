int NODE_ID = 0;
final float ATTRACT = 10;
final float REPULSE = 10;

final float MIN_DIST = 50;
final float MAX_DIST = 100;
class Node {
  final int id;
  boolean origin = false;
  {
    NODE_ID += 1;
    id = NODE_ID;
  }
  Network network;
  ArrayList<Node> children = new ArrayList<Node>();
  Node parent;
  PVector pos;
  PVector vel;
  PVector acc;
  Node(Node parent, Network network) {
    this.parent = parent;
    this.network = network;
    pos = new PVector(random(width), random(height));
    vel = new PVector();
    acc = new PVector();

    this.network.nodes.add(this);
  }

  String toString() {
    return id + ":" + pos.toString();
  }

  void draw() {
    stroke(255);
    for (Node cn : children) {
      line(pos.x, pos.y, cn.pos.x, cn.pos.y);
    }

    fill(255);
    ellipse(pos.x, pos.y, 5, 5);
  }

  void addChild() {
    children.add(new Node(this, network));
  }
  
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void update() {
    vel.add(acc);
    acc.mult(0);
    vel.limit(5);
    pos.add(vel);
  }

  void adjust() {
    if (origin) return;
    PVector attract = new PVector();
    if (parent != null) {
      attract.add(attraction(parent, ATTRACT));
    }

    for (Node cn : children) {
      attract.add(attraction(cn, ATTRACT));
    }



    PVector repel = new PVector();
    for (Node n : network.nodes) {
      if (n.id == id) continue;
      repel.add(repulsion(n, REPULSE));
    }
    repel.add(repulsion(network.origin, REPULSE*2));
    //acc.mult(0);
    applyForce(attract);
    applyForce(repel);


    for (Node cn : children) {

      for (Node n : network.nodes) {

        for (Node ncn : n.children) {
          if (n.id == id || n.id == cn.id || id == ncn.id || cn.id == ncn.id) {
            continue;
          }
          if (linesIntersect(pos, cn.pos, n.pos, ncn.pos)) {
            PVector sect = getIntersectionPoint(pos, cn.pos, n.pos, ncn.pos);
            
            PVector sect90 = new PVector(-sect.y, sect.x);
            sect90.normalize();
            sect90.add(sect);
            
            cn.applyForce(PVector.sub(sect90, sect).normalize().mult(random(10)));
          }
        }
      }
    }
    
    PVector desired = PVector.sub(acc, vel);

    //desired.mult(0.1);

    applyForce(desired);
  }

  PVector repulsion(Node n, float f) {
    PVector av = PVector.sub(pos, n.pos);
    if (av.mag() < MIN_DIST) {
      //av.mult(av.mag());
      av.mult(f + random(-0.1, 0.1));
    } else {
      av.mult(0);
    }
    return av;
  }

  PVector attraction(Node n, float f) {
    PVector av = PVector.sub(n.pos, pos);

    if (av.mag() > MAX_DIST) {
      //av.mult(av.mag(), 2));  
      av.mult(f + random(-0.1, 0.1));
    } else {
      av.mult(0);
    }
    return av;
  }
}
