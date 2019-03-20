
class Node {
  PVector pos;
  final NODE_TYPE type;
  color col;
  final int id;
  ArrayList<Carton> cartons = new ArrayList<Carton>();
  float rotA = 0;
  float rotAi = radians(3);

  ArrayList<Node> neighbours = new ArrayList<Node>();
  {
    NODE_ID += 1;
    id = NODE_ID;
  }

  String toString() {
    return type + "-" + id + " (" + int(pos.x) + "," + int(pos.y) + ")";
  }

  Node (float x, float y, NODE_TYPE type) {
    this.type = type;
    this.pos = new PVector(x, y);
    switch (type) {
    case CUSTOMER:
      col = color(255, 0, 0);
      break;
    case TRANSPORT:
      col = color(128);
      break;
    case SHOP:
      col = color(0, 255, 0);
      break;
    }
  }

  void draw() {
    stroke(col);
    fill(col);
    float r = CARTON_ORBIT_RADIUS;
    
    rotA += rotAi;
    ellipse(pos.x, pos.y, 5, 5);

    float cs = cartons.size();
    
    if (cs > 0 ) {
      
      float ai = TWO_PI / cs;
      float a = rotA;
      for (int i = 0; i < cs; i += 1) {
        Carton c = cartons.get(i);
        c.draw(pos.x, pos.y, r, a);
        
        a += ai;
      }
    }
  }
  
  
  
  void update() {
    for (int i = cartons.size() - 1; i >= 0; i -= 1) {
      Carton c = cartons.get(i);
      if (c.arrived) {
        cartons.remove(i);
      }
    }
  }

  void addNeighbour(Node n) {
    if (!neighbours.contains(n)) {
      if (okToAdd(this, n) ) { //|| (n.type == NODE_TYPE.TRANSPORT && this.type == NODE_TYPE.TRANSPORT)) {
        neighbours.add(n);
        connections.add(new Conn(this, n));

        if (n.type == NODE_TYPE.TRANSPORT && this.type == NODE_TYPE.TRANSPORT) {
          n.neighbours.add(this);
          connections.add(new Conn(n, this));
        }
      }
    } else {
      //println(this + " " + n + " already my neighbour");
    }
  }

  //

  int hashCode() {
    return id;
  }

  boolean equals(Node n) {
    return (n.id == id);
  }
}



import java.awt.geom.Line2D;
class Conn {
  float cost;
  Node from, to;
  Line2D.Float line;
  float dist;

  Conn (Node from, Node to) {
    this.from = from;
    this.to = to;

    //PVector l = PVector.sub(from.pos, to.pos);
    //float xx = l.x * 0.05;
    //float yy = l.y * 0.05;
    //l.mult(0.9);
    //l.add(xx,yy);
    //l.add(from.pos);


    line = getLineBetween(from.pos, to.pos);//new Line2D.Float(from.pos.x + xx, from.pos.y + yy, from.pos.x+ l.x, from.pos.y + l.y);

    dist = PVector.dist(from.pos, to.pos);
    cost = dist + pow(dist * 0.1, 2) + random(-100, 100);

    if (cost > highestCost) {
      highestCost = cost;
    }
  }

  void draw() {
    float c = map(cost, 0, highestCost, 255, 128);
    stroke(c);
    line(from.pos.x, from.pos.y, to.pos.x, to.pos.y);
  }

  String toString() {
    return "Connection (" + from.toString() + ")>(" + to.toString() + ") " + cost;
  }
}
