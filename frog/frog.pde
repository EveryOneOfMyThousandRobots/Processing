PImage frog;
class Particle {
  PVector pos, newPos, vel, acc;

  Particle(float x, float y, float xv, float yv) {
    pos = new PVector(x, y);
    newPos = new PVector(x,y);
    vel = new PVector(xv, yv);
    acc = new PVector(0, 0);
  }

  void update() {
    vel.add(acc);
    newPos.set(pos);
    newPos.add(vel);
    acc.mult(0);
    
    pos.add(vel);
    vel.limit(2);
    

    if (newPos.x <= 1 || newPos.x >= width-1) {
      vel.x *= -1;
      
    }

    if (newPos.y <= 1 || newPos.y >= height-1) {
      vel.y *= -1;
      
    }
    
    pos.add(vel);
  }

  void draw() {
    noStroke();
    color c = frog.pixels[floor(pos.x) + floor(pos.y) * frog.width];
    fill(c);
    ellipse(pos.x, pos.y, 2, 2);
  }
}

ArrayList<Particle> particles = new ArrayList<Particle>();

void setup () {
  background(0);
  noStroke();
  frog.loadPixels();
  for (int i = 0 ; i < 100; i += 1) {
    particles.add(new Particle(1, (height /100) * i, 1, 0));
  }
}

void settings() {
  frog = loadImage("frog2.jpg");
  size(frog.width, frog.height);
}

void draw() {
  noStroke();
  fill(0,5);
  rect(0,0, width, height);
  for (Particle p : particles) {
    p.update();
    p.draw();
    if (random(1) < 0.01) {
      p.acc.add(PVector.random2D().mult(0.01));
    }
  }
  //for (int i = 0; i < 200; i += 1) {
  //  int x = floor(random(width));
  //  int y = floor(random(height));
  //  color c = frog.pixels[x + y * width];
  //  fill(c, 30);
  //  ellipse(x, y, 8, 8);
  //}
}