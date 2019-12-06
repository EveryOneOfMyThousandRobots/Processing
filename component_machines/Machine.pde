final int TILE_SIZE = 50;

//class Machine {

//  PVector pos;
//  ArrayList<Comp> components = new ArrayList<Comp>();
//  ArrayList<Conn> connections = new ArrayList<Conn>();
//  Comp[][] grid;
//  ArrayList<Comp> inputs = new ArrayList<Comp>();
//  ArrayList<Comp> outputs = new ArrayList<Comp>();
//  float[] outputValues;
//  final int TA, TD, NUM_INPUTS;



//  Machine (int TA, int TD, int numInputs) {
//    this.TA = TA;
//    this.TD = TD;
//    this.NUM_INPUTS = numInputs;




//    grid = new Comp[TA][TD];
//    for (int x = 0; x < TA; x += 1) {
//      for (int y = 0; y < TD; y += 1) {
//        addComponent(x, y);
//      }
//    }
//    randomConnections();

//    while (inputs.size() < numInputs) {
//      Comp cmp = components.get(floor(random(components.size())));
//      if (!inputs.contains(cmp)) {
//        inputs.add(cmp);
//        cmp.isInput = true;
//      }
//    }

//    for (Comp cmp : components) {
//      if (cmp.type == COMP_TYPE.C_MOVE) {
//        outputs.add(cmp);
//      }
//    }

//    outputValues = new float[outputs.size()];
//  }

//  boolean addConnection(Comp from, Comp to) {
//    if (from == null || to == null) return false;
//    if (from.equals(to)) return false;
//    if (to.isInput) return false;
//    if (to.inputs.size() > 0) return false;

//    Conn connection = new Conn(from, to);
//    from.outputs.add(connection);
//    to.inputs.add(connection);
//    connections.add(connection);
//    return true;
//  }

//  void randomConnections() {

//    for (Comp input : inputs) {
//      Comp other = null;


//      for (int i = 0; i < TA * TD; i += 1) {

//        other = grid[floor(random(TA))][floor(random(TD))];
//        if (addConnection(input, other)) {
//          break;
//        }
//      }
//    }
//    for (int x = 0; x < TA; x += 1) {
//      for (int y = 0; y < TD; y += 1) {
//        Comp cmp = grid[x][y];
//        if (cmp.isInput) continue;
//        Comp other = null;

//        for (int i = 0; i < TA * TD; i += 1) {

//          other = grid[floor(random(TA))][floor(random(TD))];
//          if (addConnection(cmp, other)) {
//            break;
//          }
//        }
//      }
//    }
//  }

//  void addComponent(int xi, int yi) {

//    grid[xi][yi] = new Comp(this, xi, yi);
//    components.add(grid[xi][yi]);
//    //println("added Component @ (" + xi + "," + yi + ")");
//  }

//  void update(float[] inputValues) {

//    for (Comp cmp : inputs) {
//      cmp.update(inputValues);
//    }

//    for (Comp cmp : inputs) {
//      cmp.updateChildren();
//    }


//    //for (int x = 0; x < TA; x += 1) {

//    //  for (int y = 0; y < TD; y += 1) {
//    //    Comp cmp = grid[x][y];
//    //    cmp.update();
//    //  }
//    //}
//  }

//  float[] getOutput() {

//    int i = 0;
//    for (Comp cmp : outputs) {
//      outputValues[i] = cmp.value;

//      i += 1;
//    }

//    return outputValues;
//  }

//  void draw() {
//    int TS = (width / TA);
//    for (int x = 0; x < TA; x += 1) {
//      float xp = x * TS;
//      for (int y = 0; y < TD; y += 1) {
//        float yp = y * TS;
//        Comp cmp = grid[x][y];
//        stroke(0);
//        fill(200); 
//        rect(xp, yp, TS, TS);




//        fill(0);
//        text(cmp.type + "\n" + cmp.value + "\nI:" + cmp.isInput, xp+1, yp+15);
//      }
//    }

//    for (Conn conn : connections) {
//      Comp cmp = conn.from;
//      Comp other = conn.to;


//      stroke(255, 0, 0, 64);
//      float xp = cmp.XI * TS + (TS / 2);
//      float yp = cmp.YI * TS + (TS / 2);
//      float oxp = other.XI * TS + (TS / 2);
//      float oyp = other.YI * TS + (TS / 2);
//      float ppx = xp + ((oxp - xp) * 0.75);
//      float ppy = yp + ((oyp - yp) * 0.75);
//      line(xp, yp, oxp, oyp);

//      ellipse(ppx, ppy, 5, 5);
//    }
//  }
//}
