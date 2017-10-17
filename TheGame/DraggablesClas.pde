class Slider {
  float x, y;
  float bw, bh;
  float sw, sh;
  float xValue, yValue;
  boolean showX = false;
  boolean showY = false;
  boolean affecting = false;
  float xWant;
  float xwd = 1;
  float xDiff;
  float yWant;
  float ywd = 1;
  float yDiff;
  float factor = 0;
  color sc = color(255);




  boolean selected = false;

  Slider(float x, float y, float sw, float sh, float bw, float bh, float xValue, float yValue) {
    this.x = x;
    this.y = y;
    this.sw = sw;
    this.sh = sh;
    this.bh = bh;
    this.bw = bw;
    this.xValue = xValue;
    this.yValue = yValue;
    updateAmt();
    update();
  }

  boolean inside(float x, float y) {
    if (x >= xValue && x <= xValue + bw && y >= yValue && y <= yValue + bh) {
      return true;
    }
    return false;
  }

  void updateAmt() {
    xWant = random(sw - bw);
    yWant = random(sh - bh);
  }

  void updateWant() {
    float range = 1;
    int r = (int) random(10000) % 100;

    if (r <= 10) {
      xWant += random(range) * xwd;
    } else if (r <= 20) {
      yWant += random(range) * ywd;
    }

    if (xWant < 0) {
      xWant = 0;
      xwd *= -1;
    } 

    if (xWant > sw - bw) {
      xWant = sw-bw;
      xwd *= -1;
    }

    if (yWant < 0) {
      yWant = 0;
      ywd *= -1;
    } 

    if (yWant > sh - bh) {
      yWant = sh-bh;
      ywd *= -1;
    }
    update();
  }

  void update() {
    
    if (xValue > x + sw - bw) {
      this.xValue = x + sw - bw;
    }

    if (xValue < x) {
      this.xValue = x;
    }

    if (yValue > y + sh - bh) {
      this.yValue = y + sh - bh;
    }

    if (yValue <= y) {
      this.yValue = y;
    }

    xDiff = abs((xValue - x) - xWant);
    yDiff = abs((yValue - y) - yWant);
    factor = map(xDiff + yDiff, 0, sw + sh - (bw + bh), 1, 0);
    sc = color(255 * (1 - factor), 255 * factor, 0);
  }

  void draw() {
    fill(sc);
    stroke(255);
    rect(x, y, sw, sh);
    updateWant();

    int xV = (int) map(xValue, x, x + sw - bw, 0, 100);
    int yV = (int) map(yValue, y, y + sh - bh, 0, 100);


    fill(0);
    rect(xValue + 2, yValue + 2, bw - 4, bh - 4);
    fill(255);
    String out = "";
    String out2 = "" + nfc(factor,3);
    if (showX) {
      out = "" + xV;
    }

    if (showY) {
      if (out.length() > 0) {
        out += "," + yV;
      } else {
        out = ""+yV;
      }
    }

    if (out.length() > 0) {
      text(out, x, y + sh + 12);
      text(out2, x, y + sh + 24);
      text("xw: " + nfc(xWant, 3), x, y + sh + 36);
      text("yw: " + nfc(yWant, 3), x, y + sh + 48);
    }
  }
}