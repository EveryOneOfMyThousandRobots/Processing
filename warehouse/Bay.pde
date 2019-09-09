class Bay {
  Node node;
  final String name;
  HashMap<Item, Integer> onhand = new HashMap<Item, Integer>();
  HashMap<Item, Integer> allocation = new HashMap<Item, Integer>();
  int currentQty = 0;
  int getQty(Item item) {
    int qty = 0;

    if (onhand.containsKey(item)) {
      qty += onhand.get(item);
      qty -= allocation.get(item);
    }

    return qty;
  }

  String toString() {
    String output = name;

    for (Item item : onhand.keySet()) {
      output += "\n\t" + item.id + "\t" + allocation.get(item) + "\\" + onhand.get(item);
    }

    return output;
  }

  void addItem(Item item, int qty) {
    currentQty += qty;
    if (onhand.containsKey(item)) {
      int cqty = onhand.get(item);
      cqty += qty;
      onhand.put(item, cqty);
    } else {
      onhand.put(item, qty);
      allocation.put(item, 0);
    }
  }

  int deAllocated(Item item, int qty) {
    int qtyDeAllocated = 0;
    if (onhand.containsKey(item)) {


      int cqty = allocation.get(item);

      if (cqty >= qty) {
        qtyDeAllocated = qty;
      } else {
        qtyDeAllocated = cqty;
      }
      cqty -= qtyDeAllocated;
      allocation.put(item, cqty);
    }

    return qtyDeAllocated;
  }

  int removeQty(Item item, int qty) {
    int qtyRemoved = 0;
    if (onhand.containsKey(item)) {
      int currentQty = onhand.get(item);
      if (currentQty >= qty) {
        qtyRemoved = qty;
        currentQty -= qty;
      } else {
        qtyRemoved = currentQty;
        currentQty -= qty;
      }

      onhand.put(item, currentQty - qtyRemoved);
    }


    return qtyRemoved;
  }

  int allocateItem(Item item, int qty) {
    int qtyAllocated = 0;
    if (onhand.containsKey(item)) {
      int freeQty = getQty(item);
      if (freeQty >= qty) {
        qtyAllocated = qty;
      } else {
        qtyAllocated = freeQty;
      }

      int cqty = allocation.get(item);
      cqty += qtyAllocated;
      allocation.put(item, cqty);
    }

    return qtyAllocated;
  }

  int x, y;
  Bay(int xp, int yp, int aisle, int bay) {
    name = getAlpha(aisle) + getAlpha(bay);
    this.x = xp;
    this.y = yp;
    node = getNode(x, y);
  }

  void draw() {

    fill(255);
    noStroke();
    text(name, 1 + (x * NODE_SIZE), (y * NODE_SIZE)-1);
    float w = (float) NODE_SIZE / (float) onhand.size();
    int i = 0;
    fill(0, 255, 128);
    for (Item item : onhand.keySet()) {
      float xx = (x * NODE_SIZE) + (w * (float)i);
      float hh = ((float)NODE_SIZE) * ((float)onhand.get(item) / 100.0);
      float yy = (y * NODE_SIZE) + (NODE_SIZE - hh);


      rect(xx, yy, w, hh);
      i += 1;
    }


    //rect(x*NODE_SIZE,y*NODE_SIZE,NODE_SIZE,map(currentQty, 0, 300, 1, NODE_SIZE));
  }
}


String alpha = "123456789ABCDEFGHJKLPQRSTVXYZ";
String getAlpha(int i) {
  return str(alpha.charAt(i));
}
ArrayList<Bay> bays = new ArrayList<Bay>();
void initBays() {

  ArrayList<Integer> aisles = new ArrayList<Integer>();
  ArrayList<Integer> rows = new ArrayList<Integer>();

  for (int x = 0; x < NODES_ACROSS; x += 1) {
    for (int y =0; y < NODES_DOWN; y += 1) {
      Node n = getNode(x, y);
      if (n.type == NodeType.BAY) {
        aisles.add(x);
        break;
      }
    }
  }

  for (int y =0; y < NODES_DOWN; y += 1) {
    for (int x = 0; x < NODES_ACROSS; x += 1) {
      Node n = getNode(x, y);
      if (n.type == NodeType.BAY) {
        rows.add(y);
        break;
      }
    }
  }

  for (int a = 0; a < aisles.size(); a += 1) {
    int aisle = aisles.get(a);
    for (int r = 0; r < rows.size(); r += 1) {
      int row = rows.get(r);
      Node n = getNode(aisle, row);
      if (n != null) {
        if (n.type == NodeType.BAY) {
          bays.add(new Bay(aisle, row, a, r));
        }
      }
    }
  }


  for (Bay b : bays) {
    int r = floor(random(1, 3));
    for (int i = 0; i < r; i += 1) {
      Item item = getRandomItem();
      if (b.onhand.containsKey(item)) {
        continue;
      }
      b.addItem(item, floor(random(1, 100)));
    }
  }
}
