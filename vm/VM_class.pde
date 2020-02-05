class VM {
  CPU cpu;
  BUS bus;
  ROM rom;
  RAM cpuRAM;
  VM() {
    cpu = new CPU();
    bus = cpu.bus;
    rom = cpu.rom;
    cpuRAM = cpu.cpuRAM;
  }
  
  
  void tick() {
  }
  
  void drawDebug() {
    String output = "";
    
    output += Integer.toBinaryString(bus.addr);
    output += " " + Integer.toBinaryString(bus.data);
    output += !bus.RW ? "R" : "W";
    
    
    fill(255);
    text(output, 10, 10);
  }
  
  void reset() {
  }
  
}
