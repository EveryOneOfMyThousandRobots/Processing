PVector GRAV = new PVector(0, 0.03);

int ID = 0;
class Particle {
  final int id;
  {
    ID += 1;
    id = ID;
  }
  PVector pos, vel, acc;
  boolean alive = true;
  int lifeTime;
  Particle(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();

    vel.x += random(-0.2, 0.2);
    vel.y += random(0, 0.1);
    lifeTime = 500;
  }




  void applyForce(PVector f) {
    acc.add(f);
  }
  void draw() {
    int i = ((int) pos.y) * width + ((int)pos.x);
    if (i >= 0 && i < pixels.length-1) {
      pixels[i] = color(0);
    }
  }


  void update() {
    lifeTime -= 1;
    if (lifeTime <= 0) {
      alive = false;
      return;
    }
    vel.add(acc);

    acc.mult(0);
    PVector p = vel.copy();
    float mag = p.mag();
    int steps = ceil(p.mag());

    for (float t = 0; t < mag; t += 0.01) {
      p = vel.copy();
      p.normalize();
      p.mult(t);
      p.limit(mag);

      PVector pn = p.add(pos);
      boolean collision = false;
      //check collisions

      for (Particle o : particles) {
        if (o.id == id) continue;

        if (PVector.dist(p, o.pos) < 1) {
          PVector f = PVector.sub(p,o.pos);
          f.normalize();
          f.mult(mag/10);
          pos.add(f);
          applyForce(f);
          collision = true;
          break;
        }
      }

      if (!collision) {
        for (Obstacle o : blocks) {
          if (pos.x >= o.pos.x && pos.x <= o.pos.x + o.dims.x && pos.y >= o.pos.y && pos.y <= o.pos.y + o.dims.y) {
            collision = true;
            break;
          }
        }
      }

      if (!collision) {
        pos.set(pn.x, pn.y);
      } else {
        break;
      }
    }

    if (pos.x < 0 || pos.x > width || pos.y > height) {
      alive = false;
    }
  }
}

class Obstacle {

  PVector pos, dims;

  Obstacle(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    dims = new PVector(w, h);
  }


  void draw() {
    stroke(0);
    noFill();
    rect(pos.x, pos.y, dims.x, dims.y);
  }
}

ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Obstacle> blocks = new ArrayList<Obstacle>();
void setup() {
  size(300, 300);


  int w4 = width / 8;
  int w_w4 = width - w4;
  int h2 = height / 2;

  for (int i = 0; i < 10; i += 1) {
    blocks.add(new Obstacle(random(w4, w_w4), random(h2, height), random(10, 30), 5));
  }
  background(255);
}


void draw() {
  fill(255,20);
  rect(0,0,width,height);

  for (Obstacle o : blocks) {
    o.draw();
  }

  loadPixels();
  for (int i = particles.size() -1; i >= 0; i -= 1) {
    Particle p = particles.get(i);
    if (p.alive) {
      p.applyForce(GRAV);
      p.update();
      p.draw();
    } else {
      particles.remove(i);
    }
  }
  updatePixels();
  int attempts = 0;
  if (particles.size() < 200) {
    float w1 = (width / 2) - (width/32);
    float w2 = (width/2) + (width / 32);
    particles.add(new Particle(random(w1, w2), random(-50,0)));
  }
}
