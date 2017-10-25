class Mover {
  PVector pos, prevPos, newPos, newPosX, newPosY,vel, acc, dims;
  boolean collided = false;
  Mover(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    prevPos = pos.copy();
    newPos = pos.copy();
    newPosX = pos.copy();
    newPosY = pos.copy();
    dims = new PVector(w, h);
    vel = new PVector();
    acc = new PVector();
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void update() {
    collided = false;
    boolean upDown = false, leftRight = false;
    prevPos.set(pos);

    vel.add(acc);
    acc.mult(0);
    newPos.set(pos);
    newPosX.set(pos);
    newPosY.set(pos);
    
    newPos.add(vel);
    newPosX.x += vel.x;
    newPosY.y += vel.y;
    for (Obstacle o : blocks) {
      if (o.collides(newPos, dims)) {
        collided = true;
        if (o.collides(newPosX, dims)) {
          leftRight = true;
        }
        
        if (o.collides(newPosY , dims)) {
          upDown = true;
        }
      }
    }
    if (upDown) {
      vel.y = 0;
    }

    if (leftRight) {
      vel.x = 0;
    }
    pos.add(vel);
  }

   boolean pointCollides(PVector ppos) {
    if (ppos.x >= pos.x && ppos.x <= pos.x + dims.x && ppos.y >= pos.y && ppos.y <= pos.y + dims.y) {
      return true;
    } else {
      return false;
    }
  
  }
}