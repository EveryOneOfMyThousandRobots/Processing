class Obstacle {
  PVector pos, dims;


  Obstacle (float x, float y, float w, float h) {
    pos = new PVector(x, y);
    dims = new PVector(w, h);
  }

  COLLISION collisionType (PVector mpos, PVector mdims) {
    if (mpos.x + mdims.x >= pos.x || mpos.x > pos.x + dims.x) {
      return COLLISION.LEFT_RIGHT;
    }

    if (mpos.y + mdims.y < pos.y || mpos.y > pos.y + dims.y) {
      return COLLISION.UP_DOWN;
    }

    return COLLISION.NONE;
  }
  
  boolean pointCollides(PVector ppos) {
    if (ppos.x >= pos.x && ppos.x <= pos.x + dims.x && ppos.y >= pos.y && ppos.y <= pos.y + dims.y) {
      return true;
    } else {
      return false;
    }
  
  }

  boolean collides(PVector mpos, PVector mdims) {
    if (mpos.x + mdims.x < pos.x || mpos.x > pos.x + dims.x) {
      return false;
    }

    if (mpos.y + mdims.y < pos.y || mpos.y > pos.y + dims.y) {
      return false;
    }

    return true;
  }

  void draw() {
    stroke(0);
    fill(128);
    rect(pos.x, pos.y, dims.x, dims.y);
  }
}