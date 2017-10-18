class Explosion {
  PVector[] particles;
  PVector[] vels;
  float[] lifeTime;
  float[] lifeLeft;
  PVector pos;
  boolean dead = false;

  Explosion (float x, float y) {
    int count = floor(random(50, 300));
    particles = new PVector[count];
    vels = new PVector[count];
    lifeTime = new float[count];
    lifeLeft = new float[count];
    pos = new PVector(x, y);

    for (int i = 0; i < particles.length; i += 1) {
      particles[i] = pos.copy();
      vels[i] = PVector.random2D();
      vels[i].mult(random(1, 10));
      lifeTime[i] = random(50, 100);
      lifeLeft[i] = lifeTime[i];
    }
  }

  void update() {
    dead =true;
    for (int i = particles.length-1; i >= 0; i -= 1) {
      if (lifeTime[i] <= 0) continue;
      dead = false;
      PVector newPos = PVector.add(particles[i], vels[i]);
      NodeType t = map.getNodeTypeAtPos(newPos);
      if (t == NodeType.WALL) {
        vels[i].mult(-1);
        vels[i].mult(0.7);
      }
      particles[i].add(vels[i]);
        vels[i].mult(0.9);
      lifeLeft[i] -= 1;
    }
  }

  void draw() {
    strokeWeight(2);
    for (int i = 0; i < particles.length; i += 1) {
      float r = 255;
      float g = map(lifeLeft[i], 0, lifeTime[i], 0, 255);
      float b = 0;
      float alpha = map(lifeLeft[i], 0, lifeTime[i], 0, 255);
      stroke(r, g, b, alpha); 
      point(particles[i].x, particles[i].y);
    }
    strokeWeight(1);
  }
}