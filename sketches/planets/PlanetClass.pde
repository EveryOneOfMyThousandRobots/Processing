class Particle {
  Vect position;
  float radius;
  float density;
  float mass;
  float volume;
  final float FOUR_THIRDS = 4.0 / 3.0;
  Vect vector;
  int particleId;
  boolean alive = true;
  color col;

  Particle(float x, float y, float radius, float density, Vect v) {
    position = new Vect(x,y);
    this.vector = v;
    this.radius = radius;
    this.density = density;
    this.particleId = PARTICLE_ID++;
    calcMass();
    col = color(random(32, 255), random(32, 255), random(32, 255));
  }

  void calcMass() {
    volume = (FOUR_THIRDS) * (PI * pow(radius, 3));
    mass = density * volume;
  }

  void update(Particle o) {
    if (o.particleId != this.particleId) {

      Vect v = new Vect(this.position, o.position);
      // line(this.x, this.y, v.x, v.y);
      float dist = v.len;
      if (dist < this.radius + o.radius) { //Collision
        if (this.mass > (o.mass * 1.2)) {
          o.alive = false;
          float newMass = o.mass + this.mass;
          float newVolume = o.volume + this.volume;
          this.mass = newMass;
          this.volume = newVolume;
          this.density = this.mass / this.volume;
          this.radius = (float)Math.cbrt(this.volume / (FOUR_THIRDS * PI));
          this.vector.multiply(1 - (1 / mass));
        } else {
          bounce(o);
        }
      } else {
        dist *= dist;

        float f = (BIG_G * this.mass * o.mass) / dist;
        v.multiply(f);
        vector.add(v);
      }
    }
  }

  void bounce(Particle o) {
    println("bounce");
    Vect delta = new Vect(position.x, position.y);
    Vect oPos = new Vect(o.position.x, o.position.y);
    delta.subtract(oPos);
    float d = delta.len;
    float f = (((this.radius + o.radius) - d) / d);
    delta.multiply(f);
    Vect mtd = new Vect(delta.x, delta.y);

    float im1 = 1 / this.mass;
    float im2 = 2 / o.mass;

    Vect velocity = new Vect(this.vector.x, this.vector.y);
    velocity.subtract(o.vector);

    Vect v2 = new Vect(mtd.ux, mtd.uy);
    float vn = velocity.dotProduct(v2);

    float i = (-(1) *vn) / (im1 + im2);
    Vect impulse = new Vect(mtd.x, mtd.y);
    impulse.multiply(i);

    Vect thisV = new Vect(impulse.x, impulse.y);
    Vect oV = new Vect(impulse.x, impulse.y);

    thisV.multiply(im1);
    oV.multiply(im2);

    this.vector.add(thisV);
    o.vector.subtract(oV);
  }

  void update() {
    if (position.x + vector.x >= width) {
      position.x = 1;
    }

    if (position.x + vector.x <= 0) {
      position.x = width -1;
    }
    if (position.y + vector.y >= height) {
      position.y = 1;
    } 
    if (position.y + vector.y < 0) {
      position.y = height - 1;
    }    
    position.add(vector);
  }

  void draw() {
    noStroke();
    fill(this.col);

    pushMatrix();

    translate(position.x, position.y);
    ellipse(0, 0, radius * 2, radius * 2);
    popMatrix();
  }
}

