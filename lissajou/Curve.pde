class Curve {
  color col;
  PGraphics image;
  ArrayList<PVector> path;
  //PVector current;
  ParentCircle top, left;
  PVector pos;
  float prevX =-1, prevY=-1;
  Curve(ParentCircle top, ParentCircle left, int size, float x, float y) {
    //path = new ArrayList<PVector>();
    //current = new PVector();
    image = createGraphics(size, size);
    pos = new PVector(x, y);

    this.top = top;
    this.left= left;
    //col = color(random(255), 200, 255);
    
  }



  void addPoint(float x, float y) {
    x -= pos.x;
    y -= pos.y;
    col = color(map(x, 0, width, 0, 255), 0, map(y, 0, height, 0, 255));
    if (prevX == -1 && prevY == -1) {
    } else {
      image.beginDraw();
      image.stroke(col);
      image.strokeWeight(2);
      image.line(prevX, prevY, x,y);
      image.endDraw();
    }
    prevX = x;
    prevY = y;
  }

  void update() {
    addPoint(top.x, left.y);
  }

  void draw() {
    image(image, pos.x, pos.y);
    stroke(col);
    fill(col);
    ellipse(top.x, left.y, 8, 8);
    //stroke(255);
    //fill(255);
    //ellipse(top.x, left.y, 4, 4);
    //noFill();
    //beginShape();
    //for (PVector p : path) {
    //  vertex(p.x, p.y);
    //}
    //endShape();
  }
}
