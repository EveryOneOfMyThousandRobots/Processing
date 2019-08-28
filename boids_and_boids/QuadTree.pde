final int CELL_MAX = 4;

class QuadTree {
  QuadTree[] trees;
  PVector pos, dims;
  Boid[] boids = new Boid[CELL_MAX];

  int count;

  QuadTree(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    dims = new PVector(w, h);
  }

  void draw() {
    stroke(255, 0, 0, 128);
    noFill();
    rect(pos.x, pos.y, dims.x, dims.y);
    if (trees != null) {
      for (QuadTree child : trees) {
        child.draw();
      }
    }
  }

  void GetWithinRange(PVector op, float dist, ArrayList<Boid> res) {
    GetWithinRect(op.x-dist/2,op.y-dist/2,dist,dist,results);
    //stroke(255,0,0,64);
    //fill(255,0,0,64);
    //rect(op.x-dist/2, op.y - dist / 2, dist, dist);
    
    for (int i = results.size()-1;i >= 0; i -= 1) {
      if (PVector.dist(op,results.get(i).pos) > dist/2) {
        res.remove(i);
        
      }
    }
  }

  void GetWithinRect(float x, float y, float w, float h, ArrayList<Boid> res) {
    for (Boid b : this.boids) {
      if (b == null) continue;
      if (inside(b.pos.x, b.pos.y, x, y, w, h)) {
        res.add(b);
      }
    }

    if (trees != null) {
      for (QuadTree tree : trees) {
        tree.GetWithinRect(x, y, w, h, res);
      }
    }
  }

  boolean inside(float x, float y, float xx, float yy, float ww, float hh) {
    return (x >= xx && x <= xx + ww && y >= yy && y <= yy + hh);
  }


  boolean added(Boid b) {
    if (!inside(b.pos)) {
      return false;
    }
    if (count < CELL_MAX) {
      boids[count] = b;
      count += 1;
      return true;
    } else {
      if (trees == null) {
        trees = new QuadTree[4];
        float nw = dims.x / 2;
        float nh = dims.y / 2;
        trees[0] = new QuadTree(pos.x, pos.y, nw, nh);
        trees[1] = new QuadTree(pos.x+nw, pos.y, nw, nh);
        trees[2] = new QuadTree(pos.x+nw, pos.y+nh, nw, nh);
        trees[3] = new QuadTree(pos.x, pos.y+nh, nw, nh);
      }

      for (QuadTree child : trees) {
        if (child.added(b)) return true;
      }
    }

    return false;
  }

  boolean inside(PVector p) {
    return (p.x >= pos.x && p.x <= pos.x + dims.x && p.y >= pos.y && p.y <= pos.y + dims.y);
  }
}
