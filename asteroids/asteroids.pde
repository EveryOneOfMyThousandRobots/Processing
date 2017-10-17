ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<Explosion> expl = new ArrayList<Explosion>();
Ship ship;
void setup() {
  size(1000, 600);
  ship = new Ship();

  for (int i = 0; i < 10; i += 1) {
    asteroids.add(new Asteroid(null));
  }
}

void draw() {
  background(0);

  //for (Asteroid asteroid : asteroids) {
  //  asteroid.update();
  //  asteroid.draw();
  //}

  for (int i = lasers.size() - 1; i >= 0; i -= 1) {
    Laser laser = lasers.get(i);
    laser.update();
    if (laser.alive) {
      laser.draw();
    } else {
      lasers.remove(i);
    }
  }
  
  for (int i = asteroids.size() - 1; i >= 0; i -= 1) {
    Asteroid asteroid = asteroids.get(i);
    if (asteroid.alive) {
      asteroid.update();
      asteroid.draw();
      
    } else {
      asteroids.remove(i);
    }
  }
  
  for (int i = expl.size()-1; i >= 0; i -= 1) {
    Explosion e = expl.get(i);
    if (e.particles.size() == 0 ){
      expl.remove(i);
    } else {
      e.update();
      e.draw();
    }
      
  }
  ship.update();
  ship.draw();
}

void keyPressed() {
  if (keyCode == UP) {
    ship.boostDir(1);
  } else if (keyCode == DOWN) {
    ship.boostDir(0);
  } else if (keyCode == RIGHT) {
    ship.setRotation(0.1);
  } else if (keyCode == LEFT) {
    ship.setRotation(-0.1);
  }

  if (key == ' ') {
    lasers.add(new Laser(ship));
  }
}

void keyReleased() {
  if (keyCode == RIGHT || keyCode == LEFT) {
    ship.setRotation(0);
  }
  if (keyCode == UP || keyCode == DOWN) {
    ship.boostDir(0);
  }
}