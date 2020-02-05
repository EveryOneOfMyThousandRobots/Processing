abstract class RXTXBase {
  BUS bus;

  PVector drawPos;
  RXTXBase(float x, float y, BUS bus) {
    this.bus = bus;
    drawPos = new PVector(x, y);
  }



  abstract void draw();
  abstract void update();
}
