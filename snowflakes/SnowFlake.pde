class Snowflake {
  PVector pos;
  float angleStep;
  float branchAngle;
  float lengthFactor;
  float size;
  PGraphics img;
  float len;
  Snowflake(float x, float y, float angle, float lf, float s, float branchAngle) {
    this.pos = new PVector(x, y);
    this.angleStep = angle;
    this.branchAngle = branchAngle;
    this.lengthFactor = lf;
    this.size = s;
    img = createGraphics(floor(s), floor(s));
    this.len = s / 4;
  }

  void generate() {

    img.beginDraw();
    img.clear();
    img.stroke(255);
    img.strokeWeight(2);

    for (float a = 0; a < TWO_PI; a += angleStep) {
      //println("angle:" + a);
      img.pushMatrix();
      img.translate(img.width / 2, img.height / 2);
      img.rotate(a);
      ln(len);
      
      img.popMatrix();
    }


    img.endDraw();
  }

  boolean ln(float branchLen) {
    //print(branchLen + " ");
    if (branchLen < 1) return false;
    img.line(0, 0, 0, -branchLen);
    //len *= lengthFactor;
    img.translate(0, -len);

    img.pushMatrix();

    img.rotate(branchAngle);
    ln(branchLen * lengthFactor);
    img.popMatrix();

    img.pushMatrix();
    //img.translate(0, -len);
    img.rotate(-branchAngle);
    ln(branchLen * lengthFactor);
    img.popMatrix();

    //len = floor(len);
    return true;
  }

  void draw() {
    image(img, pos.x, pos.y);
  }
}
