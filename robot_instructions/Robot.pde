final float MIN_DIST = 10;
class RB {
  InstructionList list = null;
  Instruction current = null;
  PVector pos, acc, vel;
  float facing = 0;
  float maxSpeed = 3;
  float maxForce = 0.1;

  RB () {
    pos = new PVector(width / 2, height  / 2);
    acc = new PVector();
    vel = new PVector();
  }

  void steer(PVector target) {
    PVector desired = PVector.sub(target, pos);
    desired.normalize();
    desired.mult(maxSpeed);

    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxForce);
    float dist = PVector.dist(pos, target);
    if (dist < 100) {
      steer.mult(dist / 100.0);
    }
    applyForce(steer);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void update() {
    vel.add(acc);
    vel.limit(2);
    pos.add(vel);
    acc.mult(0);
    vel.mult(0.99);
    facing = vel.heading() + HALF_PI;
    if (list == null) {
      newInstructionList();
    }
    if (current != null) {
      switch (current.type) {
      case MOVE:
        if (PVector.dist(pos, current.target) < MIN_DIST) {
          
          current = null;
        } else {
          steer(current.target);
        }      
        break;
      case FETCH:
        if (PVector.dist(current.bin.pos, pos) < MIN_DIST) {
          current = null;
        } else {
          steer(current.bin.pos);
        }
        break;
      case DELIVER:
        if (PVector.dist(current.bin.pos, pos) < MIN_DIST) {
          current = null;
        } else {
          steer(current.bin.pos);
        }
        break;
      }
    } else {

      current = list.pop();
      if (current == null) {
        newInstructionList();
      }
    }
  }

  void newInstructionList() {
    list = new InstructionList(true);
  }

  void draw() {
    stroke(0);
    fill(255, 0, 0);
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(facing);
    rect(0, 0, 20, 20);
    popMatrix();
    if (current != null) {
      ellipse(current.target.x, current.target.y, 4, 4);
    }
    
    if (list != null) {
      text(list.toString(), 10, 10);
    }
  }
}
