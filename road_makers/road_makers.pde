import java.util.Set;

final float COST_MIN = 1;
final float COST_MAX = 1000;
final float COST_STEP_MIN = 1;
final float COST_STEP_MAX = 10;

final int TS = 40;
int TA, TD;

Node[][] nodes;
Node start, end;
PathFinder path;
void setup() {
  size(800, 800);
  TA = width / TS;
  TD = height / TS;

  nodes = new Node[TA][TD];

  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      nodes[x][y] = new Node(x, y);
    }
  }


  for (int y = 0; y < TD; y += 1) {
    Node n0 = nodes[0][y];
    n0.makeConnection(1, y);

    Node n1 = nodes[TA-1][y];
    n1.makeConnection(TA-2, y);
  }

  for (int x = 1; x < TA-1; x += 1) {
    for (int y = 1; y < TD-1; y += 1) {
      Node n = nodes[x][y];

      n.makeConnection(x-1, y);
      n.makeConnection(x, y-1);
      n.makeConnection(x+1, y);
      n.makeConnection(x, y+1);
    }
  }
}



void draw() {
  background(0);
  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      Node n = nodes[x][y];
      n.draw();
    }
  }

  if (path != null) {
    Node prev = null;

    for (Node n : path.path) {
      if (prev != null) {
        n.draw(color(255, 0, 255));
        stroke(255, 0, 255);
        line(n.pos.x, n.pos.y, prev.pos.x, prev.pos.y);
      }

      prev = n;
    }

    start.draw(color(255, 0, 0));
    end.draw(color(0, 0, 255));
  }
  if (random(1) < 0.5) {
    getNewPath();
  }
  fill(255);
  text(frameCount, 10, 10);

  if (random(1) < 0.1) {
    removeLowest();
  }
}

void removeLowest() {
  float f = -1;
  Node fn = null;
  Node fnn = null;
  for (int x = 1; x < TA-1; x += 1) {

    if (random(1) > 0.1) continue;
    for (int y = 1; y < TD-1; y += 1) {
      if (random(1) > 0.1) continue;
      Node n = nodes[x][y];

      for (Node nn : n.getNeighbourList()) {
        float ff = n.connections.get(nn);
        if (fn == null || ff > f) {
          f = ff;
          fn = n;
          fnn = nn;
        }
      }
    }
  }

  if (fn != null && fnn != null && f >= (COST_MIN + (COST_MAX - (COST_MAX / 2)))) {
    
   // println("break connection between " + fn + " and " + fnn);
    fn.breakConnection(fnn);
  }
}



void getNewPath() {
  start = null;
  end = null;
  path = null;
 // println(frameCount + " new path");

  int r0 = floor(random(10));
  int r1 =r0;
  while (r1 == r0) {
    r1 = floor(random(10));
  }

  switch (r0) {
  case 0:
    start = getRandomNodeFromColumn(0);
    break;
  case 1:
    start = getRandomNodeFromColumn(TA-1);
    break;
  case 2:
    start = getRandomNodeFromRow(0);
    break;
  case 3:
    start = getRandomNodeFromRow(TD-1);
    break;
  default:
    start = getRandom();
    break;
  }

  switch (r1) {
  case 0:
    end = getRandomNodeFromColumn(0);
    break;
  case 1:
    end = getRandomNodeFromColumn(TA-1);
    break;
  case 2:
    end = getRandomNodeFromRow(0);
    break;
  case 3:
    end = getRandomNodeFromRow(TD-1);
    break;
  default:
    end = getRandom();
    break;
  }

  if (start != null && end != null && !start.equals(end)) {

    path = new PathFinder(start, end);
    if (!path.findPath()) {
      path = null;
      start = null;
      end = null;
    } else {
      for (int i = 0; i < path.path.size()-1; i += 1) {
        Node n = path.path.get(i);
        Node nn = path.path.get(i + 1);
        float n_current = n.connections.get(nn);
        float nn_current = nn.connections.get(n);
        float c = random(COST_STEP_MIN, COST_STEP_MAX);
        n_current -= c;
        nn_current -= c;

        if (n_current < COST_MIN) {
          n_current = COST_MIN;
        }

        if (nn_current < COST_MIN) {
          nn_current = COST_MIN;
        }

        n.connections.put(nn, n_current);
        nn.connections.put(n, nn_current);
      }
    }
  }
}
