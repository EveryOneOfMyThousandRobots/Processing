final int ioUP = 8;
final int ioDOWN = 4;
final int ioLEFT = 2;
final int ioRIGHT = 1;

final int idxUP = 0;
final int idxDOWN = 1;
final int idxLEFT = 2;
final int idxRIGHT = 3;

enum OP {
  ADD, SUB, MULT, DIV, MOD;
}

class Module {
  Input[] inputs = new Input[4];
  Output[] outputs = new Output[4];
  int ix, iy;
  PVector pos;

  Module(int ix, int iy, int inputMask, int outputMask) {
    pos = new PVector(ix * TILE_SIZE, iy * TILE_SIZE);
    inputs[idxUP] = (inputMask & ioUP) > 0 ? new Input(this, ioUP) : null;
    inputs[idxDOWN] = (inputMask & ioDOWN) > 0 ? new Input(this, ioDOWN) : null;
    inputs[idxLEFT] = (inputMask & ioLEFT) > 0 ? new Input(this, ioLEFT) : null;
    inputs[idxRIGHT] = (inputMask & ioRIGHT) > 0 ? new Input(this, ioRIGHT) : null;

    outputs[idxUP] = (outputMask & ioUP) > 0 ? new Output(this, ioUP) : null;
    outputs[idxDOWN] = (outputMask & ioDOWN) > 0 ? new Output(this, ioDOWN) : null;
    outputs[idxLEFT] = (outputMask & ioLEFT) > 0 ? new Output(this, ioLEFT) : null;
    outputs[idxRIGHT] = (outputMask & ioRIGHT) > 0 ? new Output(this, ioRIGHT) : null;
  }

  void draw() {
    fill(200, 200, 4);
    noStroke();
    rect(pos.x, pos.y, TILE_SIZE, TILE_SIZE);
    for (int i = 0; i < inputs.length; i += 1) {
      if (inputs[i] != null) {
        inputs[i].draw();
      }
    }

    for (int i = 0; i < outputs.length; i += 1) {
      if (outputs[i] != null) {
        outputs[i].draw();
      }
    }
  }
}



abstract class InputOutput {
  Wire wire = null;
  final int type;
  final Module module;
  PVector pos;
  InputOutput(Module module, int type) {
    this.module = module;
    this.type = type;
  }

  abstract void draw();
}

class Input extends InputOutput {
  Input(Module module, int type) {
    super(module, type);

    switch (type) {
    case ioUP:
      pos = new PVector(module.pos.x + (TILE_SIZE / 3), module.pos.y);
      break;
    case ioDOWN:
      pos = new PVector(module.pos.x + (TILE_SIZE / 3), module.pos.y + TILE_SIZE -1);
      break;
    case ioLEFT:
      pos = new PVector(module.pos.x, module.pos.y + (TILE_SIZE / 3));
      break;
    case ioRIGHT:
      pos = new PVector(module.pos.x + TILE_SIZE - 1, module.pos.y + (TILE_SIZE / 3));
      break;
    }
  }

  void draw() {
    noStroke();
    fill(0, 255, 0);
    rect(pos.x, pos.y, 2, 2);
  }
}

class Output extends InputOutput {
  Output(Module module, int type) {
    super(module, type);

    switch (type) {
    case ioUP:
      pos = new PVector(module.pos.x + (TILE_SIZE * 0.66), module.pos.y);
      break;
    case ioDOWN:
      pos = new PVector(module.pos.x + (TILE_SIZE *0.66), module.pos.y + TILE_SIZE -1);
      break;
    case ioLEFT:
      pos = new PVector(module.pos.x, module.pos.y + (TILE_SIZE * 0.66));
      break;
    case ioRIGHT:
      pos = new PVector(module.pos.x + TILE_SIZE - 1, module.pos.y + (TILE_SIZE * 0.66));
      break;
    }
  }

  void draw() {
    noStroke();
    fill(255, 0, 0);
    rect(pos.x, pos.y, 2, 2);
  }
}

class Wire {
  Output from;
  Input to;
}