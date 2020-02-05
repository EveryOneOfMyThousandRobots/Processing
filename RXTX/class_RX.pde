

class RX extends RXTXBase {
  
  boolean clockPrev;
  boolean clockNow;
  boolean data;
  char currentByte = 0;

  int bitIndex = 0;
  String message;

  RX(float x, float y, BUS bus) {
    super(x, y, bus);
    message = "";
  }

  @Override 
    void draw() {
    fill(255);
    text(message + 
    "\n" + toBin(currentByte) + "  " + currentByte +  
    "\n" + bitIndex + "" 
    , drawPos.x, drawPos.y);
  }
  


  @Override 
    void update() {
    readClock();
  }

  void readClock() {
    clockNow = isHigh(bus.clock);
    if (clockNow && !clockPrev) {
      readBit();
    }

    clockPrev = clockNow;
  }


  void readBit() {
    data = isHigh(bus.data);
    if (data) {
      currentByte |= (0x80 >> bitIndex);
    }
    bitIndex += 1;
    if (bitIndex == 8) {
      message += str(currentByte);
      currentByte = 0;

      bitIndex = 0;
    }
  }
}
