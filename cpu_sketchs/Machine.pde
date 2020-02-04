class Machine {
  CPU cpu;
  BUS dataBus;
  BUS addrBus;
  RAM ram;
  ROM rom;
  Machine(int dataBusW, int addrBusW) {
    cpu = new CPU(dataBusW, addrBusW);
    this.dataBus = cpu.dataBus;
    this.addrBus = cpu.addrBus;
  }
  
  void draw() {
    cpu.draw();
  }
  
  
  void tick() {
    
    
    addrBus.write(cpu.programCounter);
    dataBus.write(rom.read(cpu.programCounter));
    cpu.programCounter += 1;
  }
}
