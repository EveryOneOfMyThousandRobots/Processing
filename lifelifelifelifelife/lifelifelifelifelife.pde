final int OP_TIME = 0;
final int OP_XPOS = 1;
final int OP_YPOS = 2;

final int OP_ADD = 3;
final int OP_SUB = 4;
final int OP_MLT = 5;
final int OP_DIV = 6;
final int OP_MOD = 7;
final int OP_SIN = 8;
final int OP_COS = 9;
final int OP_TAN = 10;
final int OP_CST = 11;

final int OP_MAX = 11;

class Node {
  float output;
  int operation;
  int type;
  float x,y;

  Node(int type) {
    this.type = type;
    operation = (int)random(OP_TIME, OP_MAX + 1);

    if (operation == OP_CST) {
      output = random(-1, 1);
    }
    
    x = random(0, width / 3) + ((width / 3) * type);
    y = random(height / 8, height - (height / 8));
  }
}

class Connection {
  Node from, to;
  float weight;
  Connection(Node from, Node to) {
    this.from = from;
    this.to = to;
    weight = random(0.01, 1);
  }
}

void drawList(ArrayList<Node> list) {
  for (int n = 0; n < list.size(); n += 1) {
    Node node = list.get(n);
    stroke(0);
    fill(32 + (64 * node.type));
    ellipse(node.x, node.y, 10,10);
    
  }
  
}

class Brain {

  ArrayList<Node> input = new ArrayList<Node>();
  ArrayList<Node> brain = new ArrayList<Node>();
  ArrayList<Node> output = new ArrayList<Node>();

  ArrayList<Connection> cons = new ArrayList<Connection>();
  
  void draw() {
    drawList(input);
    drawList(brain);
    drawList(output);
    
    for (int c = 0; c < cons.size(); c += 1) {
      Connection con = cons.get(c);
      stroke(255,0,0);
      line(con.from.x, con.from.y, con.to.x, con.to.y);
      
      
    }
    
    
  }

  Brain () {
    int numInput = (int)random(1, 5);
    int numBrain = (int)random(1, 5);
    int numOut = (int)random(1, 5);
    for (int n = 0; n < numInput; n += 1) {
      input.add(new Node(0));
    }

    for (int n = 0; n < numBrain; n += 1) {
      brain.add(new Node(1));
    }

    for (int n = 0; n < numOut; n += 1) {
      output.add(new Node(2));
    }

    for (int n = 0; n < input.size(); n += 1) {
      Node in = input.get(n);
      int numCons = (int) random(1, 3);
      for (int nc = 0; nc < numCons; nc += 1) {
        int idx = (int)random(0, brain.size() - 1);
        cons.add(new Connection(in, brain.get(idx)));
      }
    }

    for (int n = 0; n < brain.size(); n += 1) {
      Node in = brain.get(n);
      int numCons = (int) random(-3, 3);
      if (numCons <= 0) continue;
      for (int nc = 0; nc < numCons; nc += 1) {
        int idx = (int)random(0, brain.size() - 1);
        cons.add(new Connection(in, brain.get(idx)));
      }
    }

    for (int n = 0; n < brain.size(); n += 1) {
      Node in = brain.get(n);
      int numCons = (int) random(1, 3);
      if (numCons <= 0) continue;
      for (int nc = 0; nc < numCons; nc += 1) {
        int idx = (int)random(0, output.size() - 1);
        cons.add(new Connection(in, output.get(idx)));
      }
    }
  }
}

class Lifeform {
  Brain brain;
  Lifeform() {
    brain = new Brain();
  }
}

void setup() {
  size(600,400);
  noLoop();
}

void draw() {
  Lifeform life = new Lifeform();
  life.brain.draw();
}