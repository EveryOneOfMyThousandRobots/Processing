float step = 10;
int nodeCount = 0;

class Node {
  float x, y;
  ArrayList <Node> nodes = new ArrayList<Node>();


  Node(float x, float y) {
    this.x = x;
    this.y = y;

    int num = (int) random(0, 1000) % 4;
    float[] as = new float[num];

    float angle = TWO_PI / 8;
    if (nodeCount < 100) {
      for (float a = 0; a < num; a++) {
        float ar = (int) random(0, 1000) % 8;

        for (float aa : as) {
          if (aa == ar) {
            continue;
          }
        }

        as[ (int) a] = ar;

        float xx = x + step * cos(ar * angle);
        float yy = y + step * sin(ar * angle);

        nodes.add(new Node(xx, yy));
        nodeCount++;
      }
    }
  }

  void draw() {
    stroke(255);
    for (Node n : nodes) {
      line(x, y, n.x, n.y);
      n.draw();
    }
  }
}

Node n;
void setup() {
  size(800,800);
  n= new Node(width / 2, height / 2);

}

void draw() {
  background(0);
  n.draw();
  println(nodeCount);
}

void mouseClicked() {
  n = new Node(width / 2, height / 2);
}