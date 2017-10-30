enum TYPE {
  DUPLICATOR, RANDOMIZER, CHANGER, CREATE_ITEM, TAKE_ITEM;
}

class Machine {

  PVector pos;
  final boolean masterInput;
  final boolean masterOutput;
  final TYPE type;

  int outputs = 5;
  int inputs = 5;
  Machine(boolean masterInput, boolean masterOutput, float x, float y) {
    this.masterInput = masterInput;
    this.masterOutput = masterOutput;

    if (masterInput) {
      type = TYPE.CREATE_ITEM;
      inputs = 0;
      outputs = 1;
    } else if (masterOutput) {
      type = TYPE.TAKE_ITEM;
      inputs = 1;
      outputs = 0;
    } else {
      type = TYPE.CHANGER;
    }

    pos = new PVector(x, y);
  }
  
  void clicked() {
    if (mouseX >= pos.x && mouseX <= pos.x + SIZE && mouseY >= pos.y && mouseY <= pos.y + SIZE) {
      
    }
  }

  void update() {
  }

  void draw() {
    stroke(255);
    fill(200, 200, 10);
    rect(pos.x, pos.y, SIZE, SIZE);
    stroke(128);
    fill(255);
    float x = pos.x;
    for (int i = 0; i < inputs; i += 1) {

      float y = pos.y + (5 * i);

      rect(x, y, 5, 5);
    }
    x = pos.x + (SIZE-5);
    for (int i = 0; i < outputs; i += 1) {

      float y = pos.y + (5 * i);

      rect(x, y, 5, 5);
    }
  }
}