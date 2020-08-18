Segment seg;


void makeSegment() {
  seg.makeVisibleCanvas();
}
float angleStep = TWO_PI / 32;
void setup() {
  size(800, 800, P3D);
  colorMode(HSB);
  //noLoop();
  //noSmooth();

  seg = new Segment(width/2, height/2, angleStep);

  makeSegment();
  //image(seg.canvas, 0,0);
  //image(seg.visibleCanvas, seg.canvas.width,0);
}

void mouseReleased() {
  makeSegment();
}


void draw() {
  background(0);
  int i = 0;
  for (float a = 0; a < TWO_PI; a += angleStep) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(a);
    if (i % 2 ==0) {
      rotateY(PI);
    }
    image(seg.visibleCanvas, 0, 0);

    popMatrix();
    i += 1;
  }
}


class Segment {
  PGraphics canvas, visibleCanvas;
  float angle, half_angle;
  int w, h;
  Segment(int w, int h, float angle) {
    this.w = w;
    this.h = h;


    this.angle = angle;
    half_angle = angle / 2;
  }

  void makeVisibleCanvas() {
    canvas = createGraphics(w, h);
    canvas.beginDraw();
    canvas.stroke(255);

    canvas.noFill();
    canvas.strokeWeight(3);



    int r = floor(random(5, 10));
    for (int i = 0; i < r; i += 1) {
      canvas.ellipse(random(canvas.width), random(canvas.height), random(canvas.width), random(canvas.height));
    }
    r = floor(random(3, 6));
    for (int i = 0; i < r; i += 1) {
      canvas.line(0, random(canvas.height), canvas.width, random(canvas.height));
    }

    r = floor(random(2, 4));
    for (int i = 0; i < r; i += 1) {
      float rad = random(canvas.width);
      canvas.ellipse(0, 0, rad, rad);
    }


    canvas.endDraw();

    visibleCanvas = createGraphics(w, h);
    canvas.beginDraw();
    visibleCanvas.beginDraw();
    visibleCanvas.colorMode(HSB);

    canvas.loadPixels();
    visibleCanvas.loadPixels();
    PVector DIAG = new PVector(canvas.width, canvas.height);
    DIAG.normalize();


    for (int x = 0; x < canvas.width; x += 1) {
      for (int y = 0; y < canvas.height; y += 1) {
        int i = y * canvas.width + x;
        PVector p = new PVector(x, y);
        float pd = p.mag();
        p.normalize();
        float a = PVector.angleBetween(DIAG, p);
        //println("(" + x + "," + y + ") = " + a);
        if (a <= half_angle && pd <= canvas.width) {
          color ca =canvas.pixels[i];
          if (brightness(ca) > 128) {
            visibleCanvas.pixels[i] = color(map(pd,0,canvas.width,0,255),128,255);
          }
        }
      }
    }
    visibleCanvas.updatePixels();
    visibleCanvas.endDraw();
    canvas.endDraw();
  }
}
