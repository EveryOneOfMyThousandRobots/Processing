class Circ {
  Circ parent;
  Circ child;
  float ratio;
  float angle, angle_inc;
  float radius;
  PVector pos;
  PVector outerPos;
  Circ (Circ parent, float ratio, float radius) {
    this.parent = parent;
    this.ratio = ratio;
    this.angle_inc = 0.1 * radians(1/ratio);
    this.radius = (width / 64) * (1/radius);
    outerPos = new PVector();

    if (parent == null) {
      pos = new PVector(width / 2, height / 2);
    } else {
      pos = new PVector();
    }
  }

  void updatePos() {

    if (parent != null) {
      pos.x = parent.pos.x + parent.radius * cos(parent.angle);
      pos.y = parent.pos.y + parent.radius * sin(parent.angle);
    }

    outerPos.x = pos.x + radius * cos(angle);
    outerPos.y = pos.y + radius * sin(angle);
  }

  void update() {
    updateAngle();
    updatePos();
    if (child != null) {
      child.update();
    }
  }

  void updateAngle() {
    angle += angle_inc * deltaTime;
  }

  void addChild(float ratio, float radius) {
    if (child != null) {
      child.addChild(ratio, radius);
    } else {
      child = new Circ(this, ratio, radius);
    }
  }

  void draw() {
    stroke(255);
    noFill();
    ellipse(pos.x, pos.y, radius*2, radius*2);
    stroke(255, 0, 0, 128);
    line(pos.x, pos.y, outerPos.x, outerPos.y);
    if (child != null) {
      child.draw();
    } else {
      if (tracePrev == null) {
        tracePrev = outerPos.copy();
      }
      trace.beginDraw();
      trace.strokeWeight(2);
      trace.stroke(255);
      trace.line(tracePrev.x, tracePrev.y, outerPos.x, outerPos.y);
      trace.endDraw();
      tracePrev.set(outerPos);
    }
  }
}
