enum ANIM_STATE {

  BEGIN_LEAVING, 
    LEAVING, 

    FINISHED_LEAVING, 
    BEGIN_ENTERING, 
    ENTERING, 
    FINISHED_ENTERING
}

class Digit {
  int value = 0;
  int nextValue = 0;
  PVector pos;
  PVector dims;
  byte map = 0;
  ANIM_STATE state = ANIM_STATE.FINISHED_LEAVING;
  ANIM_STATE nextState = state;
  boolean changed = false;
  float t = 0;


  float x0, x1, x2;
  float x00, x10, x20;
  float y0, y1, y2, y3, y4;
  float y00, y10, y20, y30, y40;
  float horiz_w, horiz_h;
  float vert_w, vert_h;

  Digit(float x, float y, float w, float h) {
    value = nextValue = 0;
    pos = new PVector(x, y);
    dims = new PVector(w, h);
    setDims();
  }

  void setDims() {
    horiz_w = (dims.x / 5) * 3;
    horiz_h = (dims.y / 9);
    vert_w  = (dims.x / 5);
    vert_h = (dims.y / 9) * 3;


    x00 = x10 = x20 = -2 * horiz_w;
    x0 = pos.x;

    x1 = pos.x + (dims.x / 5);
    x2 = pos.x + ((dims.x / 5) * 4);



    y00 = y10 = y20 = y30 = y40 = -2 * vert_h;
    y0 = pos.y;
    y1 = pos.y + (dims.y / 9);
    y2 = pos.y + ((dims.y / 9) * 4);
    y3 = pos.y + ((dims.y / 9) * 5);
    y4 = pos.y + ((dims.y / 9) * 8);
  }


  void setValue(int val) {
    int oldValue = this.value;
    this.nextValue = val % 10;
    if (oldValue != this.nextValue) {
      changed = true;
    }
  }

  void update() {
    switch (state) {
    case BEGIN_ENTERING:
      t = 0;
      nextState = ANIM_STATE.ENTERING;
      break;
    case ENTERING:
      t = lerp(t, 1, 0.05);
      if (t >= 0.99) {
        t = 1;
        nextState = ANIM_STATE.FINISHED_ENTERING;
      }
      break;
    case FINISHED_ENTERING:
      if (changed) {
        nextState = ANIM_STATE.BEGIN_LEAVING;
      }
      break;
    case BEGIN_LEAVING:
      t = 1;
      nextState = ANIM_STATE.LEAVING;
      break;
    case LEAVING:
      t = lerp(t, 0, 0.1);
      if (t < 0.01) {
        t = 0;
        nextState = ANIM_STATE.FINISHED_LEAVING;
      }
      break;
    case FINISHED_LEAVING:
      nextState = ANIM_STATE.BEGIN_ENTERING;
      value = nextValue;
      map = getDigitMap(value);
      break;
    }

    changed = false;
    state = nextState;
  }

  void draw() {
    fill(0);
    stroke(51);
    rect(pos.x, pos.y, dims.x, dims.y);

    noStroke();
    fill(255);

    //0 top middle
    if ((map & 0x01) != 0) {
      rect(lerp(x10, x1, t), y0, horiz_w, horiz_h);
    }


    //1 top right
    if ((map & 0x02) != 0) {
      rect(x2, lerp(y10, y1, t), vert_w, vert_h);
    }

    //2 bottom right
    if ((map & 0x04) != 0) {
      rect(x2, lerp(y30, y3, t), vert_w, vert_h);
    }

    //3 bottom middle
    if ((map & 0x08) != 0) {
      rect(lerp(x10, x1, t), y4, horiz_w, horiz_h);
    }
    //4 bottom left
    if ((map & 0x10) != 0) {
      rect(x0, lerp(y30, y3, t), vert_w, vert_h);
    }
    //5 top left
    if ((map & 0x20) != 0) {
      rect(x0, lerp(y10, y1, t), vert_w, vert_h);
    }
    //6 middle middle
    if ((map & 0x40) != 0) {
      rect(lerp(x10, x1, t), y2, horiz_w, horiz_h);
    }
  }
}
