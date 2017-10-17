class Tree {
  Node root = null;
  int[] levels = new int[100];

  void add(float val) {
    add(floor(val));
  }
  void add(int val) {
    //Node n = new Node(val);

    if (root == null ) {
      root = new Node(val, 0, this);
      root.x = width / 2;
      root.y = 50;
    } else {
      root.add(val, this);
    }
    root.adjust();
    
    
  }

  void traverse() {
    root.visit();
  }

  void draw() {
    if (root != null) {
      root.draw();
    }
  }

  Node search(int searchVal) {
    if (root != null) {
      return root.search(searchVal);
    } else {
      return null;
    }
  }
  String toString() {
    if (root != null) {
      return root.toString();
    } else {
      return "empty";
    }
  }
}