class Button {
  PVector pos, dims;
  String text = "";
  Button (float x, float y, String text) {
    pos = new PVector(x, y);
    dims = new PVector((text.length() * 12) + 20, 30);
    this.text = text;
  }

  void draw() {
    stroke(255);
    fill(100, 100);
    rect(pos.x, pos.y, dims.x, dims.y);
    fill(0);
    text(text, pos.x + 5, pos.y + (dims.y * 0.7));
  }

  boolean clicked() {
    if (mouseX >= pos.x && mouseX <= pos.x + dims.x && mouseY >= pos.y && mouseY <= pos.y + dims.y) {
      return true;
    } else {
      return false;
    }
  }
}