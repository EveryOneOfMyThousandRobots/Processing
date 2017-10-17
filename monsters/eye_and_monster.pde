class Eye {
  PVector pos;
  float angleFrom, angleTo, angleInc;
  float len;
  float facing;
  boolean collide =false;
  boolean foundFood = false;
  Food eatMe = null;
  float oscillate = 0;
  float osc_step = PI;




  Eye() {
    angleFrom = random(0, PI);
    angleTo = random(angleFrom, PI);
    angleInc = radians(random(5, 15));
    len = random(30, 50);
  }

  Eye copy() {
    Eye e = new Eye();
    e.angleFrom = this.angleFrom;
    e.angleTo = this.angleTo;
    e.len = this.len;
    e.facing = this.facing;
    e.eatMe = null;
    e.collide = false;
    e.foundFood = false;

    return e;
  }

  void look(PVector pos1, int id) {
    osc_step += radians(1);
    if (osc_step > TWO_PI) osc_step -= TWO_PI;
    oscillate = sin(osc_step);
    collide = false;
    boolean AlreadylookingForFood = foundFood;
    foundFood =false;


    this.pos = pos1.copy();
    PVector w = null;
    PVector pp = pos.copy();
    //  boolean drawMiddle = false;
    for (float a = facing - (angleFrom / 2); a < facing + (angleTo / 2); a += angleInc) {
      w = PVector.fromAngle(a + oscillate);
      PVector p = w.copy();



      p.normalize();
      pp = pos.copy();
      stroke(255);
      for (float i = 0; i < len; i += p.mag()) {
        pp.add(p.x, p.y);


        for (C o : cs) {
          if (outOfBounds(pp.x, pp.y)) {//(pp.x <= 1 || pp.x >= boundaryBottomRight.x || pp.y <= 1 || pp.y >= boundaryBottomRight.y) {
            collide = true;
            break;
          }
          if (o.id != id) { //i.e. it's not me
            if (PVector.dist(pp, o.pos) <= 12) {
              collide = true;
              break;
            }
          }
          if (!foundFood && !AlreadylookingForFood) {
            for (Food f : food) {
              if (f.coolDown > 0 ) continue;
              if (pp.x >= f.pos.x && pp.x <= f.pos.x + 2 && pp.y >= f.pos.y && pp.y <= f.pos.y + 2) {
                collide = true;
                foundFood = true;
                eatMe = f;
                break;
              }
            }
          }
        }
        // if (collide) break;
        // point(pp.x, pp.y);
      }
      // point(pp.x, pp.y);
    }
    if (AlreadylookingForFood) collide = true;
  }
}