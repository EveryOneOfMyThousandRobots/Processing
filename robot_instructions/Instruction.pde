enum InstrType {
  MOVE, FETCH, DELIVER;
}
class Instruction {
  InstrType type;
  PVector target = null;
  Bin bin = null;
  
  String toString() {
    String output = "";
    if (type == InstrType.MOVE) {
      output = "MOVE :" + floor(target.x) + "," + floor(target.y);
    } else {
      output = type.toString() + " :" + floor(target.x) + "," + floor(target.y);
    }
    
    return output;
  }
  
  Instruction() {
    this(random(width), random(height));
    type = InstrType.MOVE;
  }
  
  Instruction(PVector p) {
    this(p.x, p.y);
  }
  
  Instruction(float x, float y) {
    type = InstrType.MOVE;
    target = new PVector(x,y);
  }
  
  Instruction(Bin bin, InstrType type) {
    this.bin = bin;
    this.type = type;
    target = bin.pos;
    
  }
  
  
}
Bin getRandomBin() {
  return bins.get(floor(random(bins.size())));
}

class InstructionList {
  private ArrayList<Instruction> list = new ArrayList<Instruction>(); 
  
  String toString() {
    String output = "";
    for (Instruction instr : list) {
      output += "\n" + instr.toString();
    }
    return output;
  }
  
  InstructionList(boolean pickup) {
    Bin a = getRandomBin();
    Bin b = null;
    while(b == null) {
      b = getRandomBin();
      if (b.equals(a)) {
        b = null;
      }
    }
    add(new Instruction(a.pos));
    add(new Instruction(a, InstrType.FETCH));
    add(new Instruction(b.pos));
    add(new Instruction(b, InstrType.DELIVER));
  }
  
  InstructionList() {
    add(new Instruction());
    add(new Instruction());
  }
  
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
