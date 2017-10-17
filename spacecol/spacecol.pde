final float MAX_DIST = 50;
final float MIN_DIST = 12;

class Tree {
  ArrayList<Leaf> leaves = new ArrayList<Leaf>();
  ArrayList<Branch> branches = new ArrayList<Branch>();
  Branch root;
  

  Tree() {
    for (int i = 0; i < 2000; i += 1) {
      leaves.add(new Leaf(random(width), random(height)));
    }


    root = new Branch(null, width / 2, height/2, new PVector(0, -1));
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
      float sw = map(i, 0, branches.size(), 4,0.1);
      b.draw(sw);
    }
    for (Leaf l : leaves) {
      l.draw();
    }
  }
}

class Leaf {
  boolean reached = false;
  PVector pos;
  Leaf() {
    this(random(width), random(height));
  }

  Leaf(float x, float y) {
    this.pos = new PVector(x, y);
  }

  void draw() {
    noStroke();
    fill(255, 100);
    ellipse(pos.x, pos.y, 4, 4);
  }
}

class Branch {
  PVector pos;
  Branch parent;
  PVector dir;
  PVector origDir;
  int count = 0;
  float len = 5;
  Branch(Branch parent, PVector pos, PVector dir) {
    this.pos = pos.copy();
    this.parent = parent;
    this.dir = dir.copy();
    this.origDir = dir.copy();
  }

  void reset() {
    dir = origDir.copy();
    count = 0;
  }


  Branch(Branch parent, float x, float y, PVector dir) {
    this(parent, new PVector(x, y), dir);
  }

  Branch next() {
    PVector newDir = PVector.mult(this.dir, len);
    PVector newPos = PVector.add(this.pos, newDir);
    return new Branch(this, newPos.copy(), this.dir.copy());
  }

  void draw(float sw) {
    if (parent != null) {
      stroke(255);
      strokeWeight(sw);
      line(pos.x, pos.y, parent.pos.x, parent.pos.y);
    }
  }
}
Tree tree;
void setup() {
  size(600, 600);
  tree = new Tree();
 // frameRate(5);
}

void draw() {
  background(0);
  int countBranches = tree.branches.size(); 
  tree.grow();
  tree.draw();
  
  if (tree.branches.size() == countBranches) {
    println("finished");
    stop();
  }
  
}