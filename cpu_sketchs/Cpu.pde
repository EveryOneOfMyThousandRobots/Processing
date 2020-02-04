class CPU {
  BUS dataBus;
  BUS addrBus;
  RAM ram;
  boolean clock = false;
  boolean notClock = false;
  int programCounter;
  CPU(int dataBusW, int addrBusW) {
    this.dataBus = new BUS(dataBusW);
    this.addrBus = new BUS(addrBusW);
    ram = new RAM(floor(pow(2,12)));
  }
  
  void tick() {
    clock = !clock;
    notClock = !clock;
  }
  
  void setAddr(int a) {
    addrBus.write(a);
  }
  
  void setData(int d) {
    dataBus.write(d);
  }
  void draw() {
    fill(255);
    text("data bus     : " + dataBus.toString(), 10, 10);
    text("address bus  : " + addrBus.toString(), 10, 20);
    
    
  }
}
