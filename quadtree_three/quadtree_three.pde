QuadTree quadtree;


void setup() {
  size(600, 600);
  quadtree = new QuadTree(0, 0, width, height);
  for (int i = 0; i < 200; i += 1 ) {
    quadtree.add( new QuadPoint(random(width), random(height)));
  }
  frameRate(5);
}


void draw() {
  background(0);

  quadtree.draw();
}
