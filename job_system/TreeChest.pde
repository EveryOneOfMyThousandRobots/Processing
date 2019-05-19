
//class Tree extends DrawMe {
//  Clickable clickable;
//  Tree(float x, float y) {
//    super(x, y, RESOURCE_SIZE, color(0, 128, 0));
//    clickable = new Clickable(x, y, s, s);
//  }
//  Tree() {
//    this(random(width), random(height));
//  }
//}


//class Chest extends DrawMe {
//  HashMap<String, Integer> contents = new HashMap<String, Integer>();
//  Clickable clickable;


//  Chest(float x, float y) {
//    super(x, y, RESOURCE_SIZE, color(#9b7861));
//    clickable = new Clickable(x, y, s, s);
//  }

//  Chest() {
//    this(floor(width / 2 / RESOURCE_SIZE) * RESOURCE_SIZE, floor(height / 2 / RESOURCE_SIZE) * RESOURCE_SIZE);
//  }

//  void draw() {
//    super.draw();
//    float x = pos.x + s + 4;
//    float y = pos.y;
//    String output = "";
//    for (String s : contents.keySet()) {
//      output += s + " : " + contents.get(s) + "\n";
//    }
//    GAME_WINDOW.fill(255);
//    GAME_WINDOW.text(output, x, y);
//  }

//  void addItem(String s, int i) {
//    if (contents.containsKey(s)) {
//      int n = contents.get(s);
//      n += i;
//      contents.put(s, n);
//    } else {
//      contents.put(s, i);
//    }
//  }
//}
