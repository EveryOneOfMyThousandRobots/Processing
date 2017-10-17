void createSomePlanets() {
  int needed = (num_bodies+1) - bodies.size();
  //println(needed);
  
  float start = width / 8;
  float end = (width / 2) - (width / 8);
  float range = end - start;
  float step = range / float(needed);
  for (int i = 0; i < needed; i += 1) {
    float r = random(radius_min, radius_max);
    float density = random(density_min, density_max);

    Body b = new Body(start + (step * i), height / 2, 0, r, density, false, bodies);
    //println("created " + b);
    PVector initial = new PVector(0, 100000 * sq((i + 5)), random(-1000,1000));
    b.applyForce(initial);
    bodies.add(b);
  }
}