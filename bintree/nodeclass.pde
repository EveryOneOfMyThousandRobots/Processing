class Node {
  int level;
  int val;
  float x,y;
  Tree tree;
  Node left = null, right = null;


  Node(int val, int parentLevel, Tree tree) {
    this.val = val;
    this.level = parentLevel + 1;
    this.tree = tree;
    tree.levels[this.level] += 1;
  }

  void visit() {
    if (left != null) {
      left.visit();
    }
    println("\n" + val);
    if (right != null) {
      right.visit();
    }
  }

  Node search(int searchVal) {
    if (val == searchVal) {
      return this; //println(" found " + val);
    } else if (val < searchVal && left != null) {
      return left.search(searchVal);
    } else if (val > searchVal && right != null) {
      return right.search(searchVal);
    }
    return null;
  }

  void adjust() {
    int count = tree.levels[level];
    
    if (left != null) {
      left.x = x - (width / 4) / count;
      left.adjust();
    }
    
   // x = (width / 2) / count;
    
    if (right != null) {
      right.x = x + ((width / 4) / count);
      right.adjust();
    }
    
    
    
    
  }

  void add(int val, Tree tree) {
    if (val < this.val) {
      if (this.left == null) {
        this.left = new Node(val, level, tree);
        this.left.x = x - ((width / 4) / level);
        this.left.y = y + 50;
      } else {
        this.left.add(val, tree);
      }
    } else if (val > this.val){
      if (this.right == null) {
        this.right = new Node(val, level, tree);
        this.right.x = x + ((width / 4) / level);
        this.right.y = y + 50;
      } else {
        this.right.add(val, tree);
      }
    }
  }
  
  void draw() {
    if (left != null) {
      stroke(255);
      line(x,y,left.x, left.y);
      left.draw();
    }
    //float x = width / 2;
    //float y = level * (height / 8);
    fill(0);
    stroke(255);
    ellipse(x,y, 30,30);
    fill(255);
    textAlign(CENTER);
    text(val, x,y);
    if (right != null) {
      line(x,y,right.x, right.y);
      right.draw();
    }
  }


  String toString() {
    String output  = "";
    if (left != null) {
      output += left.toString();
    }
    output += "\n[" + level + "][" + val + "]";
    if (right != null) {
      output += right.toString();
    }

    return output;
  }
}