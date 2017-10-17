class Firefly extends Entity {
  PVector origPos;
  float dist = 0;
  float cDist = 0;
  int numberOfRings = 30;
  float crH = 200;
  float crL = 100;
  color c = color(random(crL, crH), random(crL, crH), random(crL, crH));


  void changeColour() {
    float r = red(c);
    float g = green(c);
    float b = blue(c);

    r = getNewColour(r);
    g = getNewColour(g);
    b = getNewColour(b);
    c = color(r, g, b);
  }

  float getNewColour(float cc) {
    if (cc <= crL) {
      cc = crL + 1;
    } else if (cc >= crH) {
      cc = crH - 1;
    } else {
      if ((int) random(0, 10) < 2) {
        cc += (int)random(-1, 1);
      }
    }
    return cc;
  }

  Firefly(PVector position) {
    super(position);
    origPos = position.copy();
    speed = random(0.001, 0.005);
  }
  void draw() {
    stroke(c);
    fill(c);
    ellipse(position.x, position.y, 2, 2);
    for (int i = 3; i < numberOfRings + 3; i++) {
      noFill();
      int j = numberOfRings - (i - 3);
      float s = (200 / numberOfRings) * j;

      stroke(c, s);
      ellipse(position.x, position.y, i, i);
    }
    
    if (target != null) {
      stroke(c);
      line(position.x, position.y, target.x, target.y);
    }
    changeColour();
  }

  public String toString() {
    String output = "pos(" + position.x + "," + position.y + ")";

    if (target != null) {
      output +=  " tar(" + target.x + "," + target.y + ")";
    }

    output += " s:" + speed;
    output += " dist(" + cDist + "/" + dist + ")";


    return  output;
  }


  void update() {

    if (target != null) {
      //int xx = abs((int) target.x - (int) position.x);
      //int yy = abs((int) target.y - (int) position.y);
      float cDist = abs(position.dist(target));
      if ((int) cDist <= 2) {
        target = null;
      } else {      

        float d = (cDist / dist) * (PI);
        speed = abs(sin(d)) * 0.1;
        if (speed < 0.001) speed = 0.001;
        position.lerp(target, speed);
      }
    } else {
      if (target == null) {
        target = new PVector(random(0, width), random(0, height));
        origPos = position.copy();
        dist = origPos.dist(target);
      }
    }
  }
}