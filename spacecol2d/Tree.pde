class Tree {
  ArrayList<Leaf> leaves = new ArrayList<Leaf>();
  ArrayList<Branch> branches = new ArrayList<Branch>();
  Branch root;

  float minDist, maxDist;

  Tree() {

    minDist = 30;
    maxDist = 60;

    for (int i = 0; i < 250; i += 1) {
      leaves.add(new Leaf());
    }

    root = new Branch(null, new PVector(0, -1), width / 2, height);
    branches.add(root);
    Branch current = root;
    boolean found = false;
    while (!found) {
      for (Leaf l : leaves) {
        float dist = PVector.dist(l.pos, current.pos);
        if (dist < maxDist) {
          found = true;
          break;
        } else {
          Branch b = current.next();
          branches.add(b);
          current = b;
        }
      }
    }
  }


  void grow() {
    //boolean found = false;
    for (Leaf l : leaves) {
      Branch closest = null;
      float closestDist = 0;
      for (Branch b : branches) {
        float d = PVector.dist(l.pos, b.pos);

        if (d < minDist) {
          l.reached = true;
          break;
        } else if (d > maxDist) {
          continue;
        } else if (closest == null || d < closestDist) {
          closest = b;
          closestDist = d;
        }
      }

      if (closest != null) {
        closest.count += 1;
        PVector dir = PVector.sub(l.pos, closest.pos).normalize();
        closest.dir.add(dir);
        //found = true;
      }
    }
 
  }
  
  void update() {
    for (int i = leaves.size() - 1; i >= 0; i -= 1) {
      Leaf l = leaves.get(i);
      if (l.reached) {
        leaves.remove(i);
      }
    }
    
    for (int i = branches.size() -1; i >= 0; i -= 1) {
      Branch b = branches.get(i);
      if (b.count > 0) {
        b.dir.mult(1.0/b.count);
        Branch child = new Branch(b, b.dir.copy(), b.pos.x + b.dir.x, b.pos.y + b.dir.y);
        branches.add(child);
        b.count = 0;
      }
    }
  }


  void draw() {
    stroke(255);
    strokeWeight(3);
    for (Leaf l : leaves) {

      point(l.pos.x, l.pos.y);
    }
    strokeWeight(1);

    for (Branch b : branches) {
      b.draw();
    }
  }
}
