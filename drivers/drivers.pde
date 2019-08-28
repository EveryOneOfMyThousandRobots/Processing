ArrayList<Driver> drivers = new ArrayList<Driver>();
//ArrayList<Node> nodes = new ArrayList<Node>();
ArrayList<Node> nodes;
//ArrayList<Node> alNodes;
final int WIN_WIDTH = 600;
final int WIN_HEIGHT = 600;
final int NODE_DISTANCE = 20;
final int NODES_ACROSS = (WIN_WIDTH-(NODE_DISTANCE*2))/NODE_DISTANCE;
final int NODES_DOWN  = (WIN_HEIGHT-(NODE_DISTANCE*2))/NODE_DISTANCE;

void settings() {
  size(WIN_WIDTH, WIN_HEIGHT);
}

Node getRandomNode() {

  return nodes.get(floor(random(nodes.size())));//nodes[floor(random(nodes.length))][floor(random(nodes[0].length))];
}


void setup() {
  //size(600, 600);


  nodes = new ArrayList<Node>();//Node[NODES_ACROSS][NODES_DOWN];
  //alNodes = new ArrayList<Node>();

  for (int xi = 0; xi < NODES_ACROSS; xi += 1) {
    for (int yi = 0; yi < NODES_DOWN; yi += 1) {
      float x = NODE_DISTANCE + (xi * NODE_DISTANCE);
      float y = NODE_DISTANCE + (yi * NODE_DISTANCE);

      int index = xi + yi * NODES_ACROSS;
      //if (x > 0 && x < width && y > 0 && y < height) {
      //nodes[xi][yi] = new Node(x, y);
      nodes.add(new Node(x,y));
      //}
      //alNodes.add(nodes[xi][yi]);
    }
  }

  for (int xi = 0; xi < NODES_ACROSS; xi += 1) {
    for (int yi = 0; yi < NODES_DOWN; yi += 1) {
      Node n = nodes.get(xi + yi * NODES_ACROSS);
      n.findNeighbours(xi,yi,nodes);
      //nodes[xi][yi].findNeighbours(xi, yi, nodes);
    }
  }

  for (int i = 0; i < 10; i += 1) {
    Node from = null, to = null;
    from = getRandomNode();
    while (to == null) {
      to = getRandomNode();
      if (from.equals(to)) {
        to = null;
      }
    }
    Driver d = new Driver(from.pos.x, from.pos.y);
    d.setPath(from, to);

    drivers.add(d);
  }
}

void draw() {

  background(0);

  for (int xi = 0; xi < NODES_ACROSS; xi += 1) {
    for (int yi = 0; yi < NODES_DOWN; yi += 1) {

      nodes.get(xi + yi * NODES_ACROSS).draw();
    }
  }
  for (int i = drivers.size()-1; i >= 0; i -= 1) {
    Driver d = drivers.get(i);
    d.steer();
    d.update();
    d.draw();
  }
}
