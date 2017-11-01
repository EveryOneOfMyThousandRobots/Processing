int IO_ID = 0;

abstract class InputOutput {
  int id;
  {
    IO_ID += 1;
    id = IO_ID;
  }

  PVector pos;
  Machine parent;
  int index;

  InputOutput(Machine parent, int index) {
    this.index = index;
    this.parent = parent;
    setPos();
  }

  abstract void setPos();
  abstract void drawWires();

  void draw() {
    stroke(255);
    fill(128);
    rect(pos.x, pos.y, IOSIZE, IOSIZE);
    drawWires();
    
  }

  InputOutput clicked () {
    if (mouseX >= pos.x  && mouseX <= pos.x + IOSIZE && mouseY >= pos.y && mouseY <= pos.y + IOSIZE) {
      return this;
    } else {
      return null;
    }
  }
}

class Input extends InputOutput {
  //ArrayList<Wire> incomingWires = new ArrayList<Wire>();
  Input(Machine parent, int index) {
    super(parent, index);
  }

  void setPos() {
    pos = new PVector(parent.pos.x, parent.pos.y + (IOSIZE * index));
  }
  
  void drawWires() {
    
  }
}

class Output extends InputOutput {
  Wire outgoing = null;
  Output(Machine parent, int index) {
    super(parent, index);
  }

  void setPos() {
    pos = new PVector(parent.pos.x + SIZE - IOSIZE, parent.pos.y + (IOSIZE * index));
  }
  
  void drawWires() {
    stroke(255);
    if (outgoing != null) {
      outgoing.draw();
    }
  }
  
  void update() {
    if (outgoing != null) {
      outgoing.update();
    }
  }

  boolean send(Item item) {
    if (outgoing != null) {
      return outgoing.addItem(item);
    }
    return false;
  }
}