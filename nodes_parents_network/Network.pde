class Network {
  ArrayList<Node> nodes = new ArrayList<Node>();
  Node origin;
  Network() {
    origin = new Node(null, this);
    origin.pos.x = width / 2;
    origin.pos.y = height / 2;
    origin.origin = true;

    for (int i = 0; i < 30; i += 1) {
      Node n = nodes.get(floor(random(nodes.size())));
      n.addChild();
    }
  }

  void draw() {
    for (Node node : nodes) {
      node.draw();
    }
  }

  void adjust() {
    for (Node node : nodes) {
      node.adjust();
    }
  }

  void update() {
    for (Node node : nodes) {
      node.update();
    }
  }

  void print() {
    for (Node node : nodes) {
      println(node.toString());
    }
  }
}
