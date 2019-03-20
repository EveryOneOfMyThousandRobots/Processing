class Incoming extends Tbl {

  Incoming (float x, float y) {
    super(x, y, IN_OUT_BIN_SIZE, IN_OUT_BIN_SIZE, color(255, 0, 0), true);
  }

  void update() {
    if (item == null) {
      item = new Item();
    }
  }
}

class Outgoing extends Tbl {

  Outgoing (float x, float y) {
    super(x, y, IN_OUT_BIN_SIZE, IN_OUT_BIN_SIZE, color(100, 255, 0), true);
  }

  void update() {
    if (item != null) {
      item = null;
    }
  }
}

class WorkSpace extends Tbl {

  WorkSpace (float x, float y) {
    super(x, y, WORKSPACE_SIZE, WORKSPACE_SIZE, color(255, 255, 255), true);
  }
  
  void draw() {
    super.draw();
    if (this.item != null) {
      float x = pos.x - (WORKSPACE_SIZE /2) + 1;
      float y = pos.y - (WORKSPACE_SIZE/2) + map(item.requires.size(), 0, item.numComponents, WORKSPACE_SIZE-2,0) + 1;
      float w = 10;
      float h = map(item.requires.size(), 0, item.numComponents, 0, WORKSPACE_SIZE-2);
      fill(0,255,0);
      noStroke();
      rectMode(CORNER);
      rect(x,y,w,h);
    }
  }
}

class ComponentBin extends Tbl {
  //final Component component;
  ComponentBin(float x, float y, Component component, boolean printLeft) {
    super(x, y, COMPONENT_BIN_SIZE, COMPONENT_BIN_SIZE, color(255), printLeft);
    this.component = component;
  }
}


ComponentBin findBin(Component c) {

  for (Tbl tbl : tables) {
    if (tbl instanceof ComponentBin) {
      ComponentBin cb = (ComponentBin) tbl;

      if (cb.component.equals(c)) {
        return cb;
      }
    }
  }

  return null;
}


class Tbl extends UniqueId {
  PVector pos;
  PVector dims;
  float tlx, tly;
  float blx, bly;
  color c;
  Item item = null;
  Component component = null;
  boolean printLeft;
  boolean assigned = false;

  boolean equals(Tbl o) {

    return o.id == id;
  }

  Tbl(float x, float y, float w, float h, color c, boolean printLeft) {
    pos = new PVector(x, y);
    dims = new PVector(w, h);
    this.c = c;
    this.printLeft = printLeft;

    tlx = pos.x - (dims.x / 2) - 2;
    blx = tlx;
    tly = pos.y - (dims.y / 2);
    bly = pos.y + (dims.y / 2);
    if (!printLeft) {
      tlx = pos.x + (dims.x / 2) + 2;
      blx = tlx;
    }
  }

  void draw() {
    stroke(0);
    fill(c);
    rectMode(CENTER);
    rect(pos.x, pos.y, dims.x, dims.y);
    if (item != null) {
      fill(0);
      text("Item:" + item.name, tlx, tly);
    }

    if (component != null) {
      fill(0);
      if (printLeft) {
        textAlign(RIGHT);
      } else {
        textAlign(LEFT);
      }
      text("cmp:" + component.name, blx, bly);
      textAlign(LEFT);
    }
  }
}
