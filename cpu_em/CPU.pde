class CPU {
  BUS16 addr;
  BUS8 bus;
  MEMORY ram = new MEMORY(16);
  MEMORY rom = new MEMORY(16);
  BUS8 A;
  BUS8 B;
  BUS8 X;
  BUS8 Y;
  BUS16 PC;
  
  
  CPU() {
    addr = new BUS16();
    bus = new BUS8();
    A = new BUS8();
    B = new BUS8();
    X = new BUS8();
    Y = new BUS8();
    PC = new BUS16();
  }
  
  void tick() {
    
  }
}



class Machine {
  CPU cpu;
}
