

boolean OOB(int x, int y) {
  return (x < 0 || x > NA-1 || y < 0 || y > ND - 1);
}

Node[][] nodes;
int NA = 64;
int ND = 64;
float NH, NW;
void setup() {
  size(800, 800);
  NW = (float)width / (float)NA;
  NH = (float)height / (float)ND;

  nodes = new Node[NA][ND];
  for (int x = 0; x < NA; x += 1) {
    for (int y = 0; y < ND; y += 1) {
      nodes[x][y] = new Node(NA, x, y, nodes);
    }
  }

  for (int x = 0; x < NA; x += 1) {
    for (int y = 0; y < ND; y += 1) {
      nodes[x][y].setNeighbours(false);
    }
  }
  // noLoop();
}


void randomPaths() {

  for (int i = 0; i < 10; i += 1) {
    int xx = floor(random(NA));
    int yy = floor(random(ND));

    nodes[xx][yy].setNeighbours(true);
  }
  for (int x = 0; x < NA; x += 1) {
    for (int y = 0; y < ND; y += 1) {
      if (random(1) < 0.1) {
        nodes[x][y].setNeighbours(false);
      }
    }
  }
}
ArrayList<Node> okList = new ArrayList<Node>();
void draw() {
  background(0);
  for (int x = 0; x < NA; x += 1) {
    for (int y = 0; y < ND; y += 1) {
      Node n = nodes[x][y];

      float xx = n.getPX(NW);
      float yy = n.getPY(NH);

      stroke(255);
      fill(100);
      ellipse(xx, yy, NW/10, NH/10);

      for (Node nn : n.neighbours) {
        stroke(255, 0, 0, 128);
        line(xx, yy, nn.getPX(NW), nn.getPY(NH));
      }
    }
  }

  Node s = null;
  boolean allPaths = true;
  int count = 0;
  for (int x = 0; x < NA; x += 1) {
    for (int y = 0; y < ND; y += 1) {
      if (s == null) {
        s = nodes[x][y];
        continue;
      }

      Node n = nodes[x][y];
      if (!okList.contains(n)) {
        count += 1;
        PathFinder pf = new PathFinder(s, nodes[x][y]);
        if (!pf.findPath()) {
          allPaths = false;


          n.setNeighbours(true);
          for (Node nn : n.neighbours) {
            nn.setNeighbours(true);
          }
          break;
        } else {
          okList.add(n);
        }
      }
    }
    if (!allPaths) {
      break;
    }
  }

  if (!allPaths) {
    println("#NotAllPaths " + count);
    randomPaths();
  } else {
    println("all paths baby" + count);
    stop();
  }
}
