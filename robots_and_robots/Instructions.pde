enum InstrType {
  MOVE, FETCH, DELIVER;
}
class Instruction {
  InstrType type;
  PVector target = null;
  Tbl bin = null;
  Item item = null;
  Component component = null;

  String toString() {
    String output = "";
    if (type == InstrType.MOVE) {
      output = "MOVE :" + floor(target.x) + "," + floor(target.y);
    } else {
      output = type.toString() + " :" + floor(target.x) + "," + floor(target.y);
    }

    return output;
  }



  Instruction(PVector p) {
    this(p.x, p.y);
  }

  Instruction(float x, float y) {
    type = InstrType.MOVE;
    target = new PVector(x, y);
  }

  Instruction(Tbl bin, Component component, InstrType type) {
    this.bin = bin;
    this.type = type;
    target = bin.pos;
    this.component = component;
  }

  Instruction(Tbl bin, Item item, InstrType type) {
    this.bin = bin;
    this.type = type;
    target = bin.pos;
    this.item = item;
  }
}
//Bin getRandomBin() {
//  return bins.get(floor(random(bins.size())));
//}

class InstructionList {
  private ArrayList<Instruction> list = new ArrayList<Instruction>(); 

  String toString() {
    String output = "";
    for (Instruction instr : list) {
      output += "\n" + instr.toString();
    }
    return output;
  }
  
  InstructionList(Tbl pickup, Tbl dropoff, Item item) {
    add(new Instruction(pickup.pos));
    add(new Instruction(pickup, item, InstrType.FETCH));
    add(new Instruction(dropoff.pos));
    add(new Instruction(dropoff, item, InstrType.DELIVER));
  }
  
  InstructionList(Tbl pickup, Tbl dropoff, Component component) {
    add(new Instruction(pickup.pos));
    add(new Instruction(pickup, component, InstrType.FETCH));
    add(new Instruction(dropoff.pos));
    add(new Instruction(dropoff, component, InstrType.DELIVER));
  }


  //InstructionList() {
  //  add(new Instruction());
  //  add(new Instruction());
  //}

  void add(Instruction i) {
    list.add(i);
  }

  Instruction get() {
    if (list.size() == 0) return null;
    return list.get(0);
  }

  Instruction pop() {
    if (list.size() == 0) return null;
    Instruction i = list.get(0);
    list.remove(0);
    return i;
  }
}
