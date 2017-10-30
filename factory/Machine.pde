enum TYPE {
  DUPLICATOR, RANDOMIZER, CHANGER, CREATE_ITEM, TAKE_ITEM;
}
int MACHINE_ID = 0;
class Machine {

  int id;
  {
    MACHINE_ID += 1;
    id = MACHINE_ID;
  }
  PVector pos;
  final boolean masterInput;
  final boolean masterOutput;
  final TYPE type;
  Input[] in = new Input[5];
  Output[] out = new Output[5];
  int interval = 100;
  int timer = 0;
  float size = SIZE;
  ArrayList<Item> items = new ArrayList<Item>();

  int outputs = 5;
  int inputs = 5;
  Machine(boolean masterInput, boolean masterOutput, float x, float y) {
    this.masterInput = masterInput;
    this.masterOutput = masterOutput;
    pos = new PVector(x, y);
    if (masterInput) {
      type = TYPE.CREATE_ITEM;
      inputs = 0;
      outputs = 1;
      out[0] = new Output(this, 0);
    } else if (masterOutput) {
      type = TYPE.TAKE_ITEM;
      inputs = 1;
      outputs = 0;
      in[0] = new Input(this, 0);
    } else {
      type = TYPE.CHANGER;
      for (int i = 0; i < 5; i += 1) {
        in[i] = new Input(this, i);
        out[i] = new Output(this, i);
      }
    }
  }

  InputOutput clicked() {
    InputOutput n = null;
    if (mouseX >= pos.x && mouseX <= pos.x + SIZE && mouseY >= pos.y && mouseY <= pos.y + SIZE) {
      println("machine " + id);
      for (int i = 0; i < inputs; i += 1) {

        n = in[i].clicked();
        if (n != null) {
          break;
        }
      }
    }
    if (n == null) {
      for (int i = 0; i < outputs; i += 1) {

        n = out[i].clicked();
        if (n != null) {
          break;
        }
      }
    }

    return n;
  }




  void update() {
    timer += 1;
    if (timer >= interval) {
      timer = 0;
      if (outputs > 0) {
        if (masterInput) {
          items.add(new Item());
        }
        size = float(SIZE) * 1.5;
        for (int i = 0; i < outputs; i += 1) {
          if (!items.isEmpty()) {
            if (out[i].send(items.get(0))) {
              items.remove(0);
            }
          }
        }
      }
    }
    size = lerp(size, SIZE, 0.1);
    for (int i = 0; i < outputs; i += 1) {
      out[i].update();
    }
  }

  void draw() {
    stroke(255);
    fill(200, 200, 10);
    rect(pos.x, pos.y, size, size);
    stroke(128);
    fill(255);

    for (int i = 0; i < inputs; i += 1) {

      in[i].draw();
    }

    for (int i = 0; i < outputs; i += 1) {

      out[i].draw();
    }
  }
}