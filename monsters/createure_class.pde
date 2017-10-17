class C {
  int id;
  Eye e;
  PVector pos;
  PVector dir;
  float facingAngle = 0;
  float speed;
  float radius;
  float health = 0;
  color col;
  float turnDir = 0;
  int maxChildren = 0;
  int countChildren = 0;
  boolean dead = false;
  float healthLossPerTurn;
  float age = 0;
  float willDieAtAge;
  String firstName, lastName;
  float canBreedAtHealth;
  float ageIncFromBreeding;
  float ageFactorFromFood;
  C parent = null;
  int cycles = 0;
  int virusSig = 0;
  int survived = 1;
  C (float x, float y) {
    e = new Eye();
    pos = new PVector(x, y);
    C_ID += 1;
    id = C_ID;
    willDieAtAge = (int)boxmuller(boxmuller(0, 1000), boxmuller(1000, 5000));
    canBreedAtHealth = boxmuller(90, 300);


    speed = boxmuller(0.1, 1);
    newDir();
    radius = boxmuller(3, 10);
    col = color(random(128, 255), random(128, 255), random(128, 255));
    turnDir = random(0, 1) > 0.5 ? 1 : -1;
    maxChildren = (int)boxmuller(1, 5);
    health = boxmuller(25, 50);
    healthLossPerTurn = boxmuller(0.1, 2);
    firstName = getNewName(1);
    lastName = getNewName(2);
    ageIncFromBreeding = boxmuller(0, 5);
    ageFactorFromFood = boxmuller(0, 1);
    virusSig = (int) random(0, 1000);
  }

  int getHealth() {
    return (int) floor(health);
  }

  String getAgeString() {
    return floor(age) + " c(" + cycles + ") le(" + floor(willDieAtAge) + ")";
  }

  String getName() {
    return firstName + " " + lastName;
  }

  C copy() {
    C c = new C(this.pos.x + (this.radius * 2), this.pos.y);
    c.e = this.e.copy();
    c.radius = this.radius * boxmuller(0.99, 1.01);
    c.speed = this.speed * boxmuller(0.99, 1.01);
    c.col = this.col;
    c.health = this.health / 2;
    c.healthLossPerTurn = this.healthLossPerTurn * boxmuller(0.99, 1.01);
    c.maxChildren = this.maxChildren + (int) boxmuller(-1, 1);
    c.age = 0;
    c.willDieAtAge = this.willDieAtAge + (int) boxmuller(-5, 5);
    this.health /= 4;
    c.parent = this;
    c.lastName = this.lastName;
    c.canBreedAtHealth = this.canBreedAtHealth * boxmuller(0.99, 1.01);
    c.ageFactorFromFood = this.ageFactorFromFood * boxmuller(0.9, 1.1);
    c.ageIncFromBreeding = this.ageIncFromBreeding * boxmuller(0.9, 1.1);
    c.virusSig = this.virusSig;// + (int) boxmuller(-1,1);
    if (boxmuller(0, 100) <= 1) {
      c.virusSig += (int) random(-1, 1);
    }
    c.survived = this.survived / 2;

    return c;
  }

  void draw() {
    if (dead) return;
    // int idx
    int idx = floor(pos.x) + floor(pos.y) * width;
    pixels[idx] = col;
    //stroke(255);
    //fill(col);
    //ellipse(pos.x, pos.y, radius, radius);

    // text(floor(health) + " (" + floor(age) + ")", pos.x + (radius), pos.y);
    //if (this.parent != null && !this.parent.dead) {
    //  stroke(32);
    //    line(pos.x, pos.y, parent.pos.x, parent.pos.y);
    //}
    //    facingAngle += radians(1);
  }

  void update() {
    if (dead) return;
    age += 1;
    cycles += 1;
    health -= (healthLossPerTurn * (radius * 0.01)) * speed;
    e.look(pos, id);
    if (e.collide) {
      if (e.foundFood && e.eatMe != null) {
        newDir(e.eatMe.pos);
      } else {
        newDir();
      }
    }



    if (pos.x + dir.x <= radius || pos.x + dir.x >= boundaryBottomRight.x - radius || pos.y + dir.y <= radius || pos.y + dir.y >= boundaryBottomRight.y - radius ) {
      newDir();
    } else {
      pos.add(dir);
      if (e.eatMe != null) {
        if (PVector.dist(pos, e.eatMe.pos) < radius) {
          health += e.eatMe.nutrition;
          age += e.eatMe.nutrition * ageFactorFromFood;
          e.eatMe.setPos(true);

          e.eatMe = null;
        }
      }
    }

    if (health > 100) {
      C c = this.copy();
      cs.add(c);
      log(this.getName() + " gave birth to " + c.getName());
      countChildren += 1;
      age += ageIncFromBreeding;

      //if (countChildren >= maxChildren) {
      //  log(this.getName() + " died (too many children)");
      //  dead = true;
      //}
    } else if (health <= 0 ) {
      dead = true;
      log(this.getName() + " starved to death at age " + getAgeString());
    } else if (age > willDieAtAge) {
      int a = (int)abs(age - willDieAtAge);
      int r = (int) (random(0, 5000));
      if (r < a) {
        log(this.getName() + " died of old age at age " + getAgeString());
        dead = true;
      }
    }
    //PVector pp = PVector.fromAngle(facingAngle);

    //line(pos.x, pos.y, pos.x + pp.x, pos.x + pp.y);
  }

  void newDir() {
    facingAngle += radians( random(1, 5)) * turnDir;
    dir = PVector.fromAngle(facingAngle);
    dir.normalize();
    dir.mult(speed);
    // facingAngle = PVector.sub(PVector.add(pos, dir), pos).heading();
    e.facing = facingAngle;
    if (random(0, 10000) <= 10) {
      turnDir = random(0, 1) > 0.5 ? 1 : -1;
    }
  }

  void newDir(PVector target) {
    dir = PVector.sub(target, pos);
    dir.normalize();
    dir.mult(speed);
    facingAngle = PVector.sub(PVector.add(pos, dir), pos).heading();
    e.facing = facingAngle;
  }
}