class Cell {
  PVector pos, vel, acc;
  float radius = 20;
  color col;
  boolean alive = true;
  float growthFactor = 1;
  private ArrayList<Cell> cells;
  
  
  
  Cell(ArrayList<Cell> cells, PVector pos) {
    this.pos = pos.copy();
    vel = PVector.random2D();
    col = color(random(51,200), random(51,200), random(51,200));
    this.cells = cells;
    this.cells.add(this);
  }
  
  void mitosis() {
    Cell a = new Cell(cells, pos);
    Cell b = new Cell(cells, pos);
    a.col = col;
    a.radius = radius / 2;
    b.col = col;
    b.radius = radius / 2;
    this.alive = false;
    
  }
  void update() {
    vel.add(PVector.random2D());
    vel.limit(2);
    pos.add(vel);
    if (pos.x >= width) pos.x = 1;
    if (pos.x < 0) pos.x = width - 1;
    if (pos.y >= height) pos.y = 1;
    if (pos.y < 0) pos.y = height - 1;
    growthFactor -= 0.001;
    
  }
  
  boolean clicked(float x, float y) {
    boolean returnVal = false;
    PVector m = new PVector(x,y);
    if (PVector.dist(pos, m) < radius) {
      returnVal = true;
    }
    
    
    return returnVal;
  }
  
  void draw() {
    noStroke();
    fill(col);
    ellipse(pos.x, pos.y, radius * 2, radius * 2);
  }
}