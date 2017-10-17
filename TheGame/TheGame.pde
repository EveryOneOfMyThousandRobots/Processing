ArrayList<Slider> sliders = new ArrayList<Slider>();
boolean selected = false;
Slider sel = null;
float ps = 0;
float stuff = 0;
float factor = 0;
void setup() {

  size(400, 400);
  for (int i = 0; i < 5; i++) {
    float xPos = 5 + (i * (width/ 5));
    float yPos = 10;
    float sw = width / 6;
    float sh = height / 3;
    float bw = sw / 5;
    float bh = sw / 5;
    float xV = xPos + sw / 2 - bw / 2;
    float yV = yPos + sh / 2 - bh / 2;

    Slider s = new Slider(xPos, yPos, sw, sh, bw, bh, xV, yV);

    s.showX = true;
    s.showY = true;
    sliders.add(s);
  }

  //for (int i = 0; i < 5; i++) {
  //  sliders.add(new Slider( 10, 130 + (25 * i), width - 20, 20, 20, 20, 0, 0));
  //}
}

void draw() {
  background(0);
  ps = 0;
  factor = 1;
  for (Slider s : sliders) {
    s.draw();
    factor *= s.factor;
    if (s.affecting) {
      //ps += (s.amt * s.factor);
      
      
    }
  }
  
  ps = factor;

  stuff += (ps / frameRate);
  if (stuff < 0) {
    stuff = 0;
  }
  text("stuff: " + stuff, width / 2, height - 20);
  text(nfc(ps,4) + "p/s", width / 2, height - 40);
}

void mousePressed() {
  sel = null;
  for (Slider s : sliders) {
    s.selected = false;
  }
  for (Slider s : sliders) {
    if (s.inside(mouseX, mouseY)) {
      s.selected = true;
      sel = s;
    }
  }
}

void mouseDragged() {
  if (sel != null) {
    sel.xValue = mouseX - sel.bw / 2;
    sel.yValue = mouseY - sel.bh / 2;
    sel.update();
  }
}

void mouseReleased() {
  if (sel != null) {
    sel.affecting = true;
    //sel.updateAmt();
    sel.selected =false;
    sel = null;
  }
  
  //for(Slider s : sliders) {
  //  println(s.xWant + ": " + s.xDiff + " " + s.yWant + ": " + s.yDiff); 
  //  break;
  //}
}