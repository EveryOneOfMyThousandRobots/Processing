void drawGrid() {
  for (int x = 0; x < width; x += tileSize) {
    stroke(128, 100);
    line(x, 0, x, height);
  }
  for (int y = 0; y < height; y += tileSize) {
    stroke(128, 100);
    line(0, y, width, y);
  }
}

void addCars(int count, float yGrid, float speed) {
  
  float xoff = -random(tileSize, tileSize*3);
  for (int i =0; i < count; i += 1) {

    float x = (i * (width / count)) + xoff;
    float y = (yGrid * tileSize);
    cars.add( new Car(x, y, tileSize*2, tileSize, speed) );
    
  }
}