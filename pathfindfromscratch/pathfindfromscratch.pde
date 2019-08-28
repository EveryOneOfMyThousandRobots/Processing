
//Finder finder;
ArrayList<Mover> movers = new ArrayList<Mover>();

void setup() {
  size(800, 800);
  map = new Map();
  map.findNeighbours();
  //frameRate(10);

  //int i = 0;
  //int j = map.nodes.size() - 1;
  int i = floor(random(map.nodes.size()));
  for (int k = 0; k < 5; k += 1) {
    Mover mover;

    int j = -1;
    while (j == -1) {
      j = floor(random(map.nodes.size()));
      if (j == i) {
        j = -1;
      }
    }

    Node start = map.nodes.get(i);
    Node end = map.nodes.get(j);
    mover = new Mover(start, end);
    movers.add(mover);
  }
  //finder = new Finder(start, end);
  //finder.findPath();
}

void draw() {
  //finder.pathStep();
  background(0);
  map.draw();
  //mover.finder.draw();
  for (Mover m : movers) {
    m.update();
    m.draw();
  }
}
