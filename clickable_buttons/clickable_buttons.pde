class ShiftButton extends Button {
  String name;
  int shiftType;
  int w, h;
  ShiftButton(String name,float x, float y, float w, float h, boolean shiftLeft) {
    super(x,y,1);
    this.name = name;
    value = false;
    if (shiftLeft) {
      shiftType = 0;
    } else {
      shiftType = 1;
    }
    this.w = floor(w);
    this.h = floor(h);
  }
  
  void draw() {
    stroke(255);
    fill(0);
    rect(pos.x, pos.y, w,h);
    fill(255);
    text(name, pos.x + 10, pos.y + 10);
    
    
  }
  
  
}
class Button {
  PVector pos;

  float radius;

  boolean value = false;

  Button(float x, float y, float r) {
    pos = new PVector(x, y);
    radius = r;
  }

  void draw() {
    stroke(255);
    fill(value ? 255 : 0);

    ellipse(pos.x, pos.y, radius * 2, radius * 2);
    //stroke(0);
    //point(pos.x, pos.y);
  }


  boolean pointInside(float x, float y) {

    if (x >= pos.x - radius && x < pos.x + radius && y >= pos.y - radius && y < pos.y + radius && dist(x, y, pos.x, pos.y) <= radius) {
      return true;
    }
    return false;
  }

  void toggle() {
    value = !value;
  }
}

ArrayList<Button> buttons = new ArrayList<Button>();
void setup() {
  size(800, 400);
  int w = width / 10;
  for (int x = w; x < width; x += w) {
    buttons.add(new Button(x, height / 2, (w/2)-5));
  }
  
  buttons.add(new ShiftButton("<<", width / 4, height * 0.75, width / 8, height / 8, true));
  buttons.add(new ShiftButton(">>", width * 0.75, height * 0.75, width / 8, height / 8, false));
}


void draw() {
  background(51);
  for (Button b : buttons) {
    b.draw();
  }
  int val = 0;
  for (int i = buttons.size() -1; i >= 0; i -= 1) {
    Button b = buttons.get(i);
    int c = buttons.size() - i - 1;
    if (b.value) {
      val += pow(2, c);
    }
  }
  fill(255);
  text(val, 10, 10);
}

void mouseReleased() {
  for (Button b : buttons) {
    if (b.pointInside(mouseX, mouseY)) {
      b.toggle();
      break;
    }
  }
}
