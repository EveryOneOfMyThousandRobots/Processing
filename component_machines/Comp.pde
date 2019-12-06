enum COMP_TYPE {
    C_ADD, 
    C_SUB, 
    C_MULT
}
int COMP_ID = 0;
class Comp {
  
  boolean isInput = false;
  final int id; 
  {
    COMP_ID += 1;
    id = COMP_ID;
  }

  int hashCode() {
    return Integer.hashCode(id);
  }

  @Override
    boolean equals(Object o) {
    if (!(o instanceof Comp)) {
      return false;
    } else {
      Comp co = (Comp) o;
      return co.id == id;
    }
  }
  COMP_TYPE type;
  float threshold;
  float value;
  float bias = 0;

  String name;
  PVector pos;
  //final int XI, YI;

  ArrayList<Conn> inputs = new ArrayList<Conn>();
  ArrayList<Conn> outputs = new ArrayList<Conn>();
  Machine machine;
  Layer layer;

  Comp(Machine machine, Layer layer) {

    this.machine = machine;
    this.layer = layer;
    switch (floor(random(3))) {
    case 0:
      type = COMP_TYPE.C_ADD;
      break;
    case 1:
      type = COMP_TYPE.C_SUB;
      break;
    case 2:
      type = COMP_TYPE.C_MULT;
      break;
    }
  }




  void update() {
    value = 0;
    for (Conn input : inputs) {
      switch(type) {
      case C_ADD:
        value += input.from.value * input.weight;
        break;
      case C_SUB:
        value -= input.from.value * input.weight;
        break;
      case C_MULT:
        value *= input.from.value * input.weight;
        break;
      }
    }
    value += layer.bias;
    value = sig(value);
    
  }

  void draw() {
  }
}
