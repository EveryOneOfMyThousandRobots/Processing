class Flock {
  ArrayList<Agent> agents = new ArrayList<Agent>();
  float MIN_DIST = 10;


  Flock(int num) {
    for (int i = 0; i < num; i += 1) {
      agents.add(new Agent(random(width), random(height)));
    }
  }

  void update() {


    for (int i = 0; i < agents.size(); i += 1) {
      Agent a = agents.get(i);
      for (int j = 0; j < agents.size(); j += 1) {
        if (i == j) continue;
        Agent b = agents.get(j);

        PVector AB = PVector.sub(b.pos, a.pos);
        if (AB.mag() < MIN_DIST) {
          PVector repel = AB.copy();
          repel.mult(-1);
          repel.normalize();
          repel.mult(1 / AB.mag());
          a.applyForce(repel);
        } else {
          PVector attract = AB.copy();
          attract.normalize();
          attract.mult( 1.0 / pow(AB.mag(),2));
          a.applyForce(attract.mult(0.5));
        }
      }
      a.applyForce(PVector.random2D().mult(0.1));
      
      a.update();
    }
  }

  void draw() {
    for (int i = 0; i < agents.size(); i += 1) {
      Agent a = agents.get(i);
      a.draw();
    }
  }
}
