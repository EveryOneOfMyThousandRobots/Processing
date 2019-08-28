PGraphics canvas;
Spline spline;
int res = 4;
void setup() {
  size(800, 600);
  noSmooth();
  canvas = createGraphics(width/res, height/res);
  spline = new Spline();
}


void draw() {
  canvas.beginDraw();

  canvas.background(0);
  //float angle = (float)frameCount;
  //angle /= 100;
  //angle %= TWO_PI;
  //float r = width / 8 + (canvas.width/4 * sin(angle));
  //canvas.noFill();
  //canvas.stroke(255);
  //canvas.ellipse(canvas.width / 2, canvas.height / 2, r, r); 

  spline.draw();
  canvas.endDraw();
  image(canvas, 0, 0, width, height);
}

int selectedPoint = 0;
boolean dragging = false;
PVector mousePos = new PVector();

void mousePressed() {
  mousePos.set(mouseX / res, mouseY / res);
  if (mouseButton == LEFT) {
    for (int i = 0; i < spline.points.size(); i += 1) {
      PVector p = spline.points.get(i);
      if (PVector.dist(p, mousePos) < 5) {
        selectedPoint = i;
        dragging = true;
        break;
      }
    }
  }
}

void mouseDragged() {
  mousePos.set(mouseX / res, mouseY / res);
  if (mouseButton == LEFT) {
    spline.points.get(selectedPoint).set(mousePos);
  }
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    dragging = false;
  }
}



void keyReleased() {
  //println(keyCode);
  if (key == 'x') {
    selectedPoint += 1;
    selectedPoint = selectedPoint % spline.points.size();
  } else if (key == 'z') {
    selectedPoint -= 1;
    if (selectedPoint < 0) {
      selectedPoint = spline.points.size()-1;
    }
  }
}
float speed = 3;
void keyPressed() {

  if (key == 'w') {
    spline.points.get(selectedPoint).y -= speed;
  } else if (key == 's') {
    spline.points.get(selectedPoint).y += speed;
  } else if (key == 'a') {
    spline.points.get(selectedPoint).x -= speed;
  } else if (key == 'd') {
    spline.points.get(selectedPoint).x += speed;
  }
}
