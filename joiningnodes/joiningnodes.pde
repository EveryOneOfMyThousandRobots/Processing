

void setup() {
  initNodes();
  findConnections();
  size(400,400);
  noLoop();
}

void draw() {
  background(255);
  checkIntersects();
  drawLines();
  drawNodes();
}