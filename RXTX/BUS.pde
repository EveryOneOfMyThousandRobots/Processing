class BUS {
  float clock = 0;
  float data = 0;
  
  void draw() {
    fill(255);
    text(nfc(clock, 2) + " " + nfc(data,2), width / 2, height / 2);
  }
}
