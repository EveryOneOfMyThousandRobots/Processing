ArrayList<Planet> bodies = new ArrayList<Planet>();
ArrayList<Planet> tempBodies = new ArrayList<Planet>();
int numPlanets = 15;
Planet sun;
void setup() {
  size(1000, 1000);
  sun = new Planet(width / 2, height / 2, 20, 100000);
  sun.fixed = true;
  bodies.add(sun);

  for (int i = 0; i < numPlanets; i += 1) {
    bodies.add(new Planet(random(width / 2, width), height / 2, random(1, 3), random(20, 50)));
  }
  background(0);
}



void draw() {
  noStroke();
  fill(0, 10);
  rect(0, 0, width, height);
  stroke(255);
  fill(255);
  for (int i = bodies.size() - 1; i >= 0; i -= 1) {
    Planet p = bodies.get(i);
    p.update();
    p.draw();

    if (!p.alive) {
      bodies.remove(i);
    } else {

      for (int j = bodies.size() - 1; j >= 0; j -= 1) {

        Planet p2 = bodies.get(j);

        if (p2.id == p.id) continue;
        p.attract(p2);
        if (!p.fixed) {
          if (p.collides(p2)) {
            if (p2.fixed) {
              p.alive = false;
            } else {
              p.explode();
            }
          }
        }
      }
    }
  }
  int plnts = 0;
  for (Planet p : bodies) {
    if (!p.chunk) plnts += 1;
    
  }
  while (plnts < numPlanets) {
    bodies.add(new Planet(random(width / 2, width), height / 2, random(1, 3), random(50, 100)));
    plnts += 1;
  }

  bodies.addAll(tempBodies);
  tempBodies.clear();
}
