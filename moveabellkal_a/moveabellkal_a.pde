ArrayList<Veh> vehs = new ArrayList<Veh>();
ArrayList<Food> food = new ArrayList<Food>();

Cells cells;
final int NUM_FOOD = 100;
void setup() {
  size(600, 600, P2D);

  vehs.add(new Veh(width / 2, height / 2));
  cells = new Cells(20);
}

void draw() {
  background(255);
  cells.draw();
  for (Veh veh : vehs) {
    veh.update();
    veh.draw();
  }

  if (food.size() < NUM_FOOD) {
    if (random(1) < 0.1) {
      food.add(new Food());
    }
  }
  
  for (Food f : food) {
    f.draw();
  }
}