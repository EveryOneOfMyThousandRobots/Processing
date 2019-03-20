class TX extends RXTX {
  float clock = 0;
  String message;
  int stringPos;
  String msgBytes = "";
  byte b = 0;
  TX(float x, float y, String message) {
    super(x, y);
    this.message = message;
    col = color(100, 20, 20);
    
    byte[] bar = message.getBytes();
    
    for (int i = 0; i < bar.length; i += 1) {
      msgBytes += binary(bar[i]);
    }
    
    print(msgBytes);
    stringPos = -1;
  } 
  void update() {
    clock = (int)1 - clock;
    
    if (clock > 0) {
      stringPos += 1;
      if (stringPos == msgBytes.length()-1) {
        stop();
      }
      byte c = (byte)msgBytes.charAt(stringPos);
      
      b = (byte)(c == (byte)48 ? 0 : 1); 
      
    }
  }


  void draw() {
    super.draw();
    if (clock > 0) {
      noStroke();
      fill(255);
      ellipse(pos.x, pos.y, 5, 5);
      
    }
    
    fill(255);
    text(b, pos.x + 5, pos.y);
  }
}
