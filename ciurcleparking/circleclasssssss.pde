int CIRCLE_ID = 0;
class Circle {
  int id;
  PVector pos;
  float r;
  boolean growing = true;
  color col;

  Circle ( float x, float y) {
    pos = new PVector(x, y);
    r = 0.5;
    CIRCLE_ID += 1;
    id = CIRCLE_ID;
    float hue = (255.0 / (0.0 + width)) * x;
    col = color(hue, 255, 255);
  }

  void grow() {
    //float hue = (255.0 / (0.0 + width)) * (pos.x + r);
    //col = color(hue, 255, 255);
    if (growing) {
      r += 0.5;
    }
  }

  boolean touchedAnything() {
    boolean touched = !growing;

    if (!touched) {

      touched = touchedOtherCircle();

      if (!touched) {
        touched = touchedEdgeOfWindow();
      }
    }
    return touched;
  }

  private boolean touchedOtherCircle() {
    boolean overlapping = false;
    if (growing) {
      for (Circle o : circles) {
        if (o.id != id) {
          if (PVector.dist(o.pos, pos) <= o.r + r) {
            overlapping = true;
            break;
          }
        }
      }
    }

    return overlapping;
  }

  private boolean touchedEdgeOfWindow() {
    boolean returnValue = false;
    if (pos.x + r >= width || pos.x - r <= 0 || pos.y + r >= height || pos.y - r <= 0) {
      returnValue = true;
    } else {
      returnValue = false;
    }

    return returnValue;
  }

  void draw() {
    fill(col);
    noStroke();


    ellipse(pos.x, pos.y, r*2, r*2);
  }
}