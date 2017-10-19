
void settings() {
  lvlImage = loadImage("small.png");
  northRoad = loadImage("north.png");
  blankRoad = loadImage("texture.png");
  wall = loadImage("wall.png");
  size(lvlImage.width * RES, (lvlImage.height * RES) + 200, P2D);
  imgWidth = lvlImage.width;
  imgHeight = lvlImage.height;
  COLS = imgWidth;
  ROWS = imgHeight;
  map = new Map();
}


void setup() {
  map.clearOccupied();

  createCars();
  textFont(createFont("Consolas", 9));
  frameRate(100);
  //noLoop();
}


void draw() {
  boolean first = true;
  background(51);
  //Path path = new Path(1, 1, lvlImage.width-2, lvlImage.height-2);
  //path.findPath();
  map.clearOccupied();
  map.setOccupied();
  map.draw();
  for (Car car : cars) {
    car.update();
    map.setOccupied(car);
    car.draw(first);
    first = false;
  }

  for (int i = cars.size()-1; i >=0; i -=1 ) {
    if (cars.get(i).dead) {
      cars.remove(i);
    }
  }
  createCars();
  map.checkTraffic();

  for (int i = explosions.size() - 1; i >= 0; i -= 1) {
    Explosion e = explosions.get(i);
    if (e.dead) {
      explosions.remove(i);
    } else {
      e.update();
      e.draw();
    }
  }
  fill(255);
  text(cars.get(0).toString(), 10, (lvlImage.height * RES) + 10);
  //path.draw();
  //path.printPath();
  //image(lvlImage, 0, 0, lvlImage.width * RES, lvlImage.height * RES);
  if (frameCount % 1000 == 0) {
    println(map.toString());
  }
}

void mouseClicked() {
  addExplosion(mouseX, mouseY);
}