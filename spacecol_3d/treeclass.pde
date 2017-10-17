class Tree {
  ArrayList<Leaf> leaves = new ArrayList<Leaf>();
  ArrayList<Branch> branches = new ArrayList<Branch>();
  Branch root;



  void addLeaf(int idy, int idx) {
    float py = map(idy, 1, 10, 0, height / 2);
    float px = map(idx, 1, 25, -width/2, width/2);

    PVector p = new PVector(px, py, 0);
    leaves.add(new Leaf(p));
  }

  Tree() {
    for (int i = 0; i < 2000; i += 1) {
      PVector pos = PVector.random3D();
      pos.mult(random(width / 2));

      if (pos.y > 0 && pos.y < height / 2) {
      } else {
        leaves.add(new Leaf(pos));
      }
    }






    root = new Branch(null, 0, height * 0.9, new PVector(0, -1));
    branches.add(root);
    Branch current = root;
    boolean found = false;
    while (!found) {

      for (int i = 0; i < leaves.size(); i += 1) {
        float dist = PVector.dist(current.pos, leaves.get(i).pos);
        if (dist < MAX_DIST) {
          found = true;
          break;
        }
      }
      if (!found) {
        Branch newBranch = current.next();
        current = newBranch;
        branches.add(current);
      }
    }
  }

  void grow() {
    for (int i = 0; i < leaves.size(); i += 1) {
      Leaf leaf = leaves.get(i);
      Branch closest = null;
      float record = 1000000;

      for (int j = 0; j < branches.size(); j += 1) {
        Branch branch = branches.get(j);
        float dist = PVector.dist(leaf.pos, branch.pos);
        if (dist < MIN_DIST) {
          leaf.reached = true;
          closest = null;
          break;
        } else if (dist > MAX_DIST) {
          //do nothing
        } else if (closest == null || dist < record) {

          closest = branch;
          record = dist;
        }
      }

      if (closest != null) {
        PVector newDir = PVector.sub(leaf.pos, closest.pos);
        newDir.normalize();
        closest.dir.add(newDir);
        closest.count += 1;
        //Branch b = new Branch(
      }
    }
    for (int i = leaves.size()-1; i >= 0; i -= 1) {
      if (leaves.get(i).reached) {
        leaves.remove(i);
      }
    }


    for (int i = branches.size()-1; i >=0; i -= 1) {
      Branch branch = branches.get(i);
      if (branch.count > 0 ) {
        branch.dir.div(branch.count+1);
        PVector rand = PVector.random2D();
        rand.mult(0.1);
        branch.dir.add(rand);
        Branch newBranch = branch.next();//new Branch(branch, PVector.add(branch.pos, branch.dir), branch.dir.copy());
        branches.add(newBranch);
      }
      branch.reset();
    }
  }

  void draw() {

    for (int i = 0; i < branches.size(); i += 1) {
      Branch b = branches.get(i);
      float sw = map(i, 0, branches.size(), 3, 0.1);
      b.draw(sw);
    }
    for (Leaf l : leaves) {
      l.draw();
    }
  }
}