class CPU {
  BUS bus;
  RAM cpuRAM;
  
  ROM rom;
  
  //registers
  short PC;
  char AC;
  char X;
  char Y;
  char SR;
  char SP;
  
  
  
  
  CPU() {
    bus = new BUS();
    cpuRAM = new RAM(32768);
    rom = new ROM();
  }
  
}
