ArrayList<Creature> creatures = new ArrayList<Creature>();
float[][] food;

int perGeneration = 50;

void setup () {
  size(200, 200);

  for (int i = 0; i < perGeneration; i += 1) {
    int x = width / 2;
    int y = height / 2;
    creatures.add(new Creature(x, y));
  }

  frameRate(1000);
  food = new float[width][height];
  resetFood();
}

void resetFood() {
  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      food[x][y] = random(0, 10);
      if (random(0,10) > 2) {
        food[x][y] = 0.01;
      }
    }
  }
}

boolean outOfBounds(int x, int y) {
  if (x < 0 || x >= width || y < 0 || y >= height) {
    return true;
  } else {
    return false;
  }
}
float foodAt(int x, int y) {
  if (outOfBounds(x, y)) {
    return -1;
  } else {
    return food[x][y];
  }
}

int cycles = 0;
int generation = 0;
float averageHealth = 0;

void draw() {
  cycles += 1;
  background(0);
  loadPixels();
  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      float c = map(food[x][y], 0, 5, 0, 64);
      pixels[x + y * width] = color(c);
    }
  }  
  for (Creature c : creatures) {
    c.update();
    c.draw();
  }


  updatePixels();
  text(generation, 10, 10);
  text(averageHealth, 10, 30);

  if (cycles > 100) {
    generation += 1;
    cycles = 0;
    averageHealth = 0;
    Creature n = null;
    Creature n2 = null;
    float highest = -1;
    creatures.sort(creatureCompare);
    n = creatures.get(creatures.size() - 1);
    n2 = creatures.get(creatures.size() - 2);
        
    for (Creature c : creatures) {
      if (c.health > highest) {
        highest = c.health;
//        n = c;
      averageHealth += c.health;
      }
    }
    averageHealth /= creatures.size();

    creatures.clear();
    for (int i = 0; i < perGeneration; i += 1) {
      int x = width / 2;
      int y = height / 2;
      Creature c = new Creature(x, y);
      if (i > perGeneration / 2) {      
        c.brain = n2.brain.copy();
      } else {
        c.brain = n.brain.copy();
      }

      creatures.add(c);
      resetFood();
    }
  }
}