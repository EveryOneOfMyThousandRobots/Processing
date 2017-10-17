class C {
  float health = 0;
  float age = 0;
  float diesAt = 0;
  int x, y;
  boolean hunter = false;
  float sick = 0;
  float lookRange = 0;

  C (boolean hunter, int x, int y) {
    this.hunter = hunter;
    this.x = x;
    this.y = y;
    if (this.hunter) {
      health = 100;
      diesAt = random(1000, 10000);
      lookRange = (int) random(1, 3);
    } else {
      health = 10;
      diesAt = random(10000, 20000);
    }
  }

  int preyX = 0;
  int preyY = 0;
  void look() {
    preyX = 0;
    preyY = 0;
    for (int xx = x - (int)lookRange; xx < x + (int) lookRange; xx += 1) {
      for (int yy = y - (int) lookRange; yy < y + (int) lookRange; yy += 1) {
        if (isPrey(xx,yy)) {
          if (xx < x) {
            preyX = -1;
          } else if (xx > x) {
            preyX = 1;
          }
          
          if (yy < y) {
            preyY = -1;
          } else if (yy > y){
            preyY = 1;
            
          }
          return;
        }
      }
    }
    //for (int xx = x; xx > x - lookRange; xx -= 1) {
    //  if (isPrey(xx, y)) {
    //    preyX = -1;
    //    return;
    //  }
    //}
    //for (int xx = x; xx < x + lookRange; xx += 1) {
    //  if (isPrey(xx, y)) {
    //    preyX = 1;
    //    return;
    //  }
    //}
    //for (int yy = y; yy > y - lookRange; yy -= 1) {
    //  if (isPrey(x, yy)) {
    //    preyY = -1;
    //    return;
    //  }
    //}
    //for (int yy = y; yy < y + lookRange; yy += 1) {
    //  if (isPrey(x, yy)) {
    //    preyY = 1;
    //    return;
    //  }
    //}
  }


  void move() {
    age += 1;
    if (health <= 0 || age > diesAt) {
      cs[x][y] = null;
      dead[x][y] = 100;
      return;
    } else if (health > 200) {
      PVector p = getNextAvailable(x, y);
      if (p != null) {
        C o = new C(this.hunter, (int)p.x, (int)p.y);
        cs[o.x][o.y] = o;
        if (hunter) {
          o.lookRange = lookRange * random(0.9, 1.1);
          if (o.lookRange > 4) {
            o.lookRange = 4;
          } else if (o.lookRange < 1){
            o.lookRange = 1;
            
          }
        }
        this.health /= 2;
        this.age += 10;
      }
    }

    int m = (int) random(0, 10);
    int xx = 0;
    int yy = 0;


    switch (m) {
    case 0:
      xx = 1;
      break;
    case 1:
      xx = -1;
      break;
    case 2:
      yy = 1;
      break;
    case 3:
      yy = -1;
      break;
    default:
    }
    if (hunter) {
      look();
    }
    if (preyY != 0 || preyX != 0) {
      xx = preyX;
      yy = preyY;
    }
    if (hunter) {
      if (xx != 0 || yy != 0) {
        if (available(x + xx, y + yy)) {
          cs[x][y] = null;
          x = x + xx;
          y = y + yy;
          cs[x][y] = this;
        } else {
          C o = getAt(x + xx, y + yy);


          if (o != null) {
            if (o.hunter == false) {
              cs[o.x][o.y] = null;
              if (o.sick > 10) {
                this.health = 0;
              } else {
                this.health += (o.health * 0.2);
              }
            }
          }
        }
      }
      health -= random(0.005, 0.1);
    } else {
      if (sick == 0) {
        if (((int) random(0, 1000)) == 1) {
          sick = 100;
        }
      } 




      if (xx != 0 || yy != 0) {
        if (available(x + xx, y + yy)) {
          cs[x][y] = null;
          x = x + xx;
          y = y + yy;
          cs[x][y] = this;

          int sickies = sickNeighbours(x, y); 
          if (sickies > 0) {
            if (((int) random(0, 100)) < 10 + (sickies * 2)) {
              sick = 100;
            }
          }
        }
      }
      float f = food[x][y];
      if (f > 1) {
        float eaten = f * random(0.1, 0.5);
        health += (eaten * 0.5);
        food[x][y] -= eaten;
      } else {
        health -= 0.1;
      }
      health -= (sick * 0.001);
      if (surrounded(x, y)) {
        health = 0;
      }
      if (sick > 0) {
        sick -= map(health, 0, 200, 0, 5);
        if (sick < 0) {
          sick = 0;
        }
      }
    }
  }

  void draw() {
    color c = color(0);
    if (hunter) {

      c = color(255, 255, 128);
    } else {
      if (sick > 0) {
        c = color(0, 128, 0);
      } else { 
        c = color(map(health, 0, 200, 128, 255));
      }
    }
    setPixel(x,y,c);
    //pixels[x + y * w] = c;
    //;point(x, y);
  }
}