


TX tx;
RX rx;
PFont fwFont;
void setup () {
  size(800, 800);
  String msg = "Very slow transmission!\"£$%^&*()";
  tx = new TX(50, height/2, msg);
  rx = new RX(width-50, height/2, tx);
  frameRate(10);

  for (int i = 0; i < msg.length(); i += 1) {
    byte b = (byte) msg.charAt(i);
    println(binary(b));
  }
  
  fwFont = createFont("Consolas", 14);
  textFont(fwFont);
}


void draw() {
  background(0);
  tx.update();
  rx.update();
  

  rx.draw();
  tx.draw();
  fill(255);
  
  //text(tx.msgBytes, 10,10);
  text(tx.message, 10, 25);
  //text(rx.msgBytes, 10, 40);
  text(rx.message, 10, 55);
}
