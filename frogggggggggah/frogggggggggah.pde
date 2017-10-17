Frog frog;
ArrayList<Car> cars = new ArrayList<Car>();
float tileSize = 20;
int tilesAcross, tilesDown;





void setup() {
  size(640, 480);
  tilesAcross = floor(width / tileSize);
  tilesDown = floor(height / tileSize);
  
  

  frog = new Frog(width / 2, height -tileSize, tileSize);
  
  addCars(3, tilesDown - 2, 2);
  addCars(2, tilesDown - 3, -3);
  addCars(3, tilesDown - 4, 2.5);
  addCars(2, tilesDown - 5, -5);
  addCars(5, tilesDown - 6, 1);


  
}

void draw() {
  background(0);
  drawGrid();

  for (Car car : cars) {
    car.update();
    car.draw();
  }

  //update frog last
  frog.update();
  frog.draw();
}

void keyPressed() {
  if (keyCode == UP) {
    frog.move(0, -1);
  } else if (keyCode == DOWN) {
    frog.move(0, 1);
  } else if (keyCode == RIGHT) {
    frog.move(1, 0);
  } else if (keyCode == LEFT) {
    frog.move(-1, 0);
  }
}