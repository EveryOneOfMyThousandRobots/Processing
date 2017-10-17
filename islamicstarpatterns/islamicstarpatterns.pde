//Polygon polygon;
final int NUM_SIDES = 6;
boolean debug = false;
float delta = 10;
Slider deltaSlider, angleSlider;

ArrayList<Polygon> polygons = new ArrayList<Polygon>(100);


void setup() {
  size(400, 400);
  deltaSlider = new Slider("delta", height - 20, 0, 60);
  angleSlider = new Slider("angle", height - 40, 0, 90);

  float h = 50 * 2;
  float w = (sqrt(3) / 2) * h;
  int row = 0;
  float inc = floor(3 * (h  / 4));

  for (float y = -inc; y < width + inc; y += inc) {
    //Polygon poly = new Polygon(x + inc / 2, y + inc / 2, NUM_SIDES, inc);
    float sx = ((row % 2) == 0) ? -w : -w / 2;
    for (float x = sx; x < width + inc; x += w) {
      Polygon poly = new Polygon(x, y, NUM_SIDES, inc);
      polygons.add(poly);
    }
    row += 1;
  }
  createPolygons();

  //polygon = new Polygon(width / 2, height / 2, NUM_SIDES);
  //createPolygon();
  println("press \"d\" to show debug info");
}

void createPolygons() {

  for (Polygon polygon : polygons) {
    polygon.makeHankins();
    //polygon.findEnds();
  }
}

void draw() {
  background(0);
  for (Polygon polygon : polygons) {
    polygon.draw();
  }
  angleSlider.draw();
  deltaSlider.draw();
}

void mouseReleased() {

  createPolygons();
}
void mouseClicked() {
  if (angleSlider.clicked() || deltaSlider.clicked()) {
    createPolygons();
  }
}

void mouseDragged() {
  if (angleSlider.clicked() || deltaSlider.clicked()) {
    createPolygons();
  }
}

void keyPressed() {
  if (key == 'd') {
    debug = !debug;
  }
}