
class Circ {
  Circ xParent, yParent;
  PVector pos;
  float speed;
  float px, py, x, y;
  float cx, cy;
  float r;
  float a;
  PGraphics img;
  color c;
  boolean top, down;
  


  Circ(Circ xParent, Circ yParent, float x, float y, float speed) {
    px = -1;
    py = -1;
    top = down = false;
    this.xParent = xParent;
    this.yParent = yParent;
    this.pos = new PVector(x, y);
    cx = RAD;
    cy = RAD;
    this.speed = speed;
    this.r = RAD*0.9;
    img = createGraphics((int)WH, (int)WH);
    
    float hhue = map(pos.x + pos.y, 0, width + height, 0, 255);
    c = color(hhue, 255,255);
    
    img.beginDraw();
    img.colorMode(HSB);
    img.endDraw();
    
  }

  void update() {
    px = x;
    py = y;
    if (xParent != null && yParent != null) {
      x = xParent.x;
      y = yParent.y;
    } else {
      a += speed;
      x = cx + r * cos(a);
      y = cy + r * sin(a);
    }
  }


  void draw() {
    img.beginDraw();
    img.noStroke();
    //img.fill(0,20);
    //img.rect(0,0,img.width, img.height);
    img.stroke(c);
    img.fill(c);
    
    img.line(px, py, x, y);
    image(img, pos.x, pos.y);
    fill(255);
    stroke(255);
    ellipse(pos.x + x, pos.y + y, 3, 3);
    //noStroke();
    //noFill();
    //rect(pos.x, pos.y, WH, WH);
    img.endDraw();
  }
}
