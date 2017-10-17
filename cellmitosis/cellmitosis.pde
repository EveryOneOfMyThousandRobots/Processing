ArrayList<Cell> cells = new ArrayList<Cell>();
int NUM_CELLS = 2;


void setup() {
  size(400,400);
  for (int i = 0; i < NUM_CELLS; i += 1) {
    PVector pos = new PVector(random(height), random(width));
    new Cell(cells, pos);
  }
}

void draw() {
  background(51);
  for(int i = cells.size()-1; i >= 0; i -=1 ) {
    Cell cell = cells.get(i);
    cell.update();
    cell.draw();
    cell.radius += random(0.02) * cell.growthFactor;
    if (cell.radius > 30) {
      cell.mitosis();
    } else if (cell.radius < 1) {
      cell.alive = false;
    }
  }
  
  for (int i = cells.size()-1; i >= 0; i -=1 ) {
    if (!cells.get(i).alive) {
      cells.remove(i);
    }
  }
}

void mousePressed() {
  float x = mouseX;
  float y = mouseY;
  
  for(int i = 0; i < cells.size(); i += 1) {
    if(cells.get(i).clicked(x,y)) {
      cells.get(i).mitosis();
      break;
    }
  }
}