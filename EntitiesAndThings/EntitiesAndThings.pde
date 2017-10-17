ArrayList<Entity> entities = new ArrayList<Entity>();
boolean printEntities = false;
void setup () {
  size(400,400);
  for (int i = 0 ; i < 10; i++) {
    PVector p = new PVector(random(0,width), random(0,height));
    Firefly f = new Firefly(p);
    entities.add(f);
  }
}

void draw() {
  background(0);
  for (Entity e : entities) {
    
    e.update();
    e.draw();
    if (printEntities) {
      println(e);
      
    }
    
  }
  printEntities = false;
  
  
}

void mouseClicked() {
  printEntities = !printEntities;
}