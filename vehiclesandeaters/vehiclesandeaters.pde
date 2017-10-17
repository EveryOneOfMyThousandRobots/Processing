ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>();

PVector[] foodGrid;
ArrayList<PVector> activeFood = new ArrayList<PVector>();
ArrayList<PVector> food = new ArrayList<PVector>();
ArrayList<PVector> poison = new ArrayList<PVector>();
color GREEN = color(0, 255, 0);
color RED = color(255, 0, 0);
float distFromEdge = 25;

int maxFood = 50;
int maxPoison = 50;

float foodRadius = 10;
int foodAttempts = 30;

int foodCols, foodRows;
//r / sqrt(dimensions)
float cellSize = (foodRadius / sqrt(2)); 

boolean test_mode = true;

void createFood() {
  if (!activeFood.isEmpty()) {
    int index = floor(random(activeFood.size()));
    PVector fd = activeFood.get(index);
    //strokeWeight(1);
    //stroke(255);
    //noFill();
    //ellipse(fd.x, fd.y, foodRadius*2, foodRadius*2);
    //ellipse(fd.x, fd.y, foodRadius*4, foodRadius*4);
    //strokeWeight(3);
    boolean found = false;
    for (int n = 0; n < foodAttempts; n += 1) {
      float angle = random(TAU);
      float xx = cos(angle);
      float yy = sin(angle);
      PVector guess = new PVector(xx,yy);//PVector.random2D();
      float offsetMag = random(foodRadius, foodRadius * 2);
      guess.setMag(offsetMag);
      guess.add(fd);
      //noStroke();
      //fill(0, 255, 0, 50);
      //ellipse(guess.x, guess.y, foodRadius*2, foodRadius*2);

      if (guess.x < 0 || guess.x > width -1 || guess.y < 0 || guess.y > height-1) continue;

      int col = floor(guess.x / cellSize);
      int row = floor(guess.y / cellSize);
      boolean ok = true;
      for (int i = col - 1; i <=  col + 1; i += 1) {
        for (int j = row - 1; j <= row + 1; j += 1) {
          int neighbourIndex = i + j * foodCols;
          if (neighbourIndex >= 0 && neighbourIndex <= foodGrid.length - 1) {
            //noStroke();
            //fill(0, 255, 0, 50);

            //rect(i * cellSize, j * cellSize, cellSize, cellSize);

            PVector neighbour = foodGrid[neighbourIndex];
            if (neighbour != null ) {
              if (PVector.dist(neighbour, guess) < foodRadius) {
                //println("too close");
                ok = false;
                //break;
              }
            }
          }
        }
        //if (!ok) break;
      }
      if (ok) {
        
        if (foodGrid[col + row + foodCols] == null) {
          found = true;
          foodGrid[col + row + foodCols] = guess.copy();
          activeFood.add(guess.copy());

          //break;
        }
      }
    }
    if (!found) {
      activeFood.remove(index);
    }
  }
}


void setupFood() {
  foodCols = floor(width / cellSize);
  foodRows = floor(height / cellSize);

  float x = random(width);
  float y = random(height);
  PVector pos = new PVector(x, y);
  foodGrid = new PVector[foodCols * foodRows];
  int grid_x = floor(x / cellSize);
  int grid_y = floor(y / cellSize);
  foodGrid[grid_x + grid_y * foodCols] = pos;
  activeFood.add(pos);
}

void setup() {
  size(800, 500);

  setupFood();
  if (!test_mode) {
    for (int i = 0; i < maxFood; i += 1) {
      food.add(newVec());
    }
    for (int i = 0; i < maxPoison; i += 1) {
      poison.add(newVec());
    }
  }
 // frameRate(1);
}

void resetVehicles() {
  for (int i = 0; i < 10; i += 1) {
    vehicles.add(new Vehicle(random(width), random(height), null));
  }
}

void draw() {
  background(51);


  if (test_mode) {
    stroke(255);
    strokeWeight(1);
    for (int y = 0; y < height; y += cellSize) {
      line(0, y, width, y);
    }
    for (int x = 0; x < width; x += cellSize) {
      line(x, 0, x, height);
    }
    stroke(255);
    strokeWeight(4);
    createFood();
    for (int i = 0; i < foodGrid.length; i += 1) {
      if (foodGrid[i] != null) {

        point(foodGrid[i].x+3, foodGrid[i].y+3);
      }
    }
    stroke(255, 0, 255);
    for (PVector p : activeFood) {
      point(p.x, p.y);
    }

    return;
  }

  for (PVector f : food) {
    noStroke();
    fill(0, 255, 0);
    ellipse(f.x, f.y, 2, 2);
  }
  for (PVector p : poison) {
    noStroke();
    fill(255, 0, 0);
    ellipse(p.x, p.y, 2, 2);
  }

  //PVector mouse = new PVector(mouseX, mouseY);



  //// Draw an ellipse at the mouse position
  //fill(127);
  //stroke(200);
  //strokeWeight(2);
  //ellipse(mouse.x, mouse.y, 48, 48);

  // Call the appropriate steering behaviors for our agents
  for (int i = vehicles.size()-1; i >= 0; i -=1 ) {
    Vehicle vehicle = vehicles.get(i);
    vehicle.behaviours(food, poison);
    vehicle.update();
    vehicle.draw();

    if (!vehicle.alive) {
      vehicles.remove(i);
    }
  }

  if (food.size() < maxFood) {
    if (random(1) < 0.2) {
      food.add(newVec());
    }
  }

  if (poison.size() < maxPoison) {
    if (random(1) < 0.2) {
      poison.add(newVec());
    }
  }

  if (vehicles.size() == 0) {
    resetVehicles();
  }
}

void keyPressed() {
  if (keyCode == 112) {
    debug_mode = !debug_mode;
  }
}