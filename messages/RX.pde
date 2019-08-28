class RX extends RXTX {

  TX tx;
  float prevClock = 0;
  float clock = 0;
  String msgBytes = "";
  String message = "";
  RX(float x, float y, TX tx) {
    super(x, y);
    col = color(20, 100, 20);
    this.tx = tx;
  }

  void receive() {
    msgBytes += tx.b;
    message = "";
    if (msgBytes.length() >= 8) {
      for (int i = 0; i < msgBytes.length(); i += 8) {
        if (i + 8 > msgBytes.length()) break;
        String c = "";
        for (int j = i; j < i + 8 && j < msgBytes.length(); j += 1) {
          c += msgBytes.charAt(j);
        }
        message += str((char)unbinary(c));
        
      }
    }
  }

  void update() {
    clock = tx.clock;

    if (clock > prevClock) {
      receive();
    }

    prevClock = clock;
  }
  
  void draw() {
    super.draw();
    fill(255);
    //text(message, pos.x + 5, pos.y);
    
  }
}
