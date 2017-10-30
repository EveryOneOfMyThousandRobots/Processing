ArrayList<Wire> wires = new ArrayList<Wire>();
class Wire {
  Item item = null;
  float itemProgress;
  Output from;
  float dist;
  Input to;

  PVector itemPos = new PVector();

  Wire(Output from, Input to) {
    this.from = from;
    this.to = to;
    this.from.outgoing = this;
  }

  boolean addItem(Item item) {
    if (this.item == null) {
      this.item = item;
      itemProgress = 0;
      return true;
    } else {
      return false;
    }
  }

  void update() {
    if (item != null) {
      itemProgress += 0.01;
      dist = PVector.dist(from.pos, to.pos);

      itemPos = PVector.sub(to.pos, from.pos);
      itemPos.normalize();
      itemPos.mult(dist * itemProgress);
      itemPos.add(from.pos);

      if (itemProgress >= 1) {
        to.parent.items.add(item);
        item = null;
        itemProgress = 0;
      }
    }
  }

  void draw() {
    float x1 = from.pos.x + HALF_IOSIZE;
    float y1 = from.pos.y + HALF_IOSIZE;

    float x2 = to.pos.x + HALF_IOSIZE;
    float y2 = to.pos.y + HALF_IOSIZE;

    stroke(255, 0, 0);
    fill(255, 0, 0);
    line(x1, y1, x2, y2);
    if (item != null) {
      ellipse(itemPos.x, itemPos.y, IOSIZE, IOSIZE);
      text(itemPos.toString() + " d:" + nf(dist,3,3), itemPos.x + 10, itemPos.y + 10);
    }
  }
}