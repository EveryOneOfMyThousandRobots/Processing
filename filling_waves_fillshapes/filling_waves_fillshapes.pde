import java.util.*;


PFont sysFont;

Node[][] nodes;
PathFinder path;

final int WINDOW_WIDTH = 800;
final int WINDOW_HEIGHT = 600;
final int TILE_SIZE = 25;
final int TA = WINDOW_WIDTH / TILE_SIZE;
final int TD = WINDOW_HEIGHT / TILE_SIZE;

Node start, end;
void settings() {
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
}

void setup() {
  sysFont = createFont("Monospaced.plain", 10);

  textFont(sysFont);
  nodes = new Node[TA][TD];

  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      nodes[x][y] = new Node(x, y);
    }
  }

  for (int x = 0; x < TA; x += 1) {
    nodes[x][0].d = -1;
    nodes[x][TD-1].d = -1;
  }

  for (int y = 0; y < TD; y += 1) {
    nodes[0][y].d = -1;
    nodes[TA-1][y].d = -1;
  }

  start = nodes[1][1];
  end = nodes[TA-2][TD-2];
  //Tuple a = tup(1,2,3);
  //Tuple b = tup(1,2,3);
  //HashSet<Tuple> set = new HashSet<Tuple>();
  //set.add(a);
  //println(a.equals(b) + " " + (a == b));
  //println("set contains A?" + set.contains(a));
  //println("set contains B?" + set.contains(tup(1,2,3)));
}

void findPath() {
  path = new PathFinder(start, end, nodes);
}
void keyPressed() {
  if (key == ' ') {
    findPath();
  }
}
color PINK = color(200,50,50);
color WHITE = color(255);
void draw() {
  background(0);
  stroke(0);
  int max = 0;
  if (path != null) {

    for (int x = 0; x < TA; x += 1) {
      for (int y = 0; y < TD; y += 1) {
        int p = path.flowField[x][y];
        if (p > max) {
          max = p;
        }
      }
    }
  }

  for (int x = 0; x < TA; x += 1) {
    int xp = x * TILE_SIZE;
    for (int y = 0; y < TD; y += 1) {
      int p = 0;
      if (path != null) {
        p = path.flowField[x][y];
      }
      Node n = nodes[x][y];
      color textColor = color(0);    
      int yp = y * TILE_SIZE;
      if (n == start) {
        fill(0, 0, 255);
        textColor = color(255);
      } else if (n == end) {
        fill(255, 0, 0);
        textColor = color(255);
      } else if (n.d >= 0) {
        if (max > 0) {
          float fp = p;
          float fmax = max;
          color c = lerpColor(WHITE,PINK,fp/fmax);
          fill(c);
        } else {
          fill(255);
        }
      } else {
        fill(150);
      }

      rect(xp, yp, TILE_SIZE, TILE_SIZE);
      //fill(textColor);
      //text(x+","+y+"\n"+n.d + "\n" + p, xp+5, yp+10);
    }
  }
}



void mouseReleased() {
  switch(mouseButton) {
  case LEFT:
    Node n = getNodeFromScreen(mouseX, mouseY);
    if (n != null) {
      if (n.d == 0 && n != start && n != end) {
        n.d = -1;
      } else if (n.d == -1) {
        n.d = 0;
      }
    }
    break;
  case RIGHT:
    Node s = getNodeFromScreen(mouseX, mouseY);
    if (s != null && s.d == 0 && s != end) {

      start = s;
    }
    break;
  }
}
