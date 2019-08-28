class Slider {
  private PVector pos;
  private PVector dims;
  private PVector sliderPos;
  private float min, max;
  private float value;
  Slider(float y, float min, float max) {
    this.pos = new PVector(0, y);
    this.min = min;
    this.max = max;
    this.dims = new PVector(width, 20);
    sliderPos = new PVector();
    value = 0.5;
    setSliderPos();
  }
  
  float getValue() {
    return map(value, 0, 1, min, max);
  }

  void draw() {
    noStroke();
    fill(128, 128);
    rect(pos.x, pos.y, dims.x, dims.y);
    fill(255,128);
    rect(sliderPos.x, sliderPos.y, 20, 20);
    
  }
  
  private void setSliderPos() {
    sliderPos.x = pos.x + map(value, 0, 1, 0, dims.x);
    sliderPos.y = pos.y;
  }

  void setValue() {
    if (mouseX >= pos.x && mouseX < pos.x + dims.x && mouseY >= pos.y && mouseY < pos.y + dims.y) {
      value = map(mouseX, pos.x, pos.x + dims.x, 0,1);
      setSliderPos();
    }
  }
  
  void setValue(float x) {
    value = constrain(x, 0, 1);
    setSliderPos();
  }
}
