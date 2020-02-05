class TX extends RXTXBase{
  
  String message;
  int byteIndex = 0;
  int bitIndex = 0;
  
  
  int timer = 0;
  long BPS = 20;
  long timeNow = millis();
  long timeLast = millis();
  long timeDelta = 0;
  TX(String message, float x, float y, BUS bus) {
    super(x,y,bus);
    this.message = message;
  }
  
  @Override 
  void draw() {
    fill(255);
    text(message + 
    "\n" + toBin(message.charAt(byteIndex)), drawPos.x, drawPos.y + 14);
  }
  
  @Override 
  void update() {
    setClock(false);
    timeNow = millis();
    timeDelta = timeNow - timeLast;
    timer += timeDelta;
    timeLast = timeNow;
    
    if (timer > (1000 / BPS)) {
      timer = 0;
      char c = message.charAt(byteIndex);
      boolean d = false;
      if ((c & (0x80 >> bitIndex)) > 0) {
        //print(" " + c);
        d = true;
      }
      setData(d);
      setClock(true);
      bitIndex += 1;
      if (bitIndex == 8) {
        bitIndex = 0;
        byteIndex += 1;
        if (byteIndex == message.length()) {
          byteIndex = 0;
        }
      }
    }
  }
  
  
  void setClock(boolean c) {
    bus.clock = c ? 1 : 0;
  }
  
  void setData(boolean d) {
    bus.data = d ? 1 : 0;
  }
}
