
import processing.pdf.*;
String pi;
PGraphics canvas;
boolean drawText = false;
boolean writePDF = false;
void setup() {


  size(800, 800);
  canvas = createGraphics(1600,1600);
  
  background(0);
  noLoop();
  float w;// = 12;
  float h;// = 12;
  float cols = 1000;
  float rows = 1000;
  w = canvas.width / cols;
  h = canvas.height / rows;
  pi = loadStrings("pi-million.txt")[0];
  int index = 0;
  if (writePDF) {
    beginRecord(PDF, "pi.pdf");
  }
  
  canvas.beginDraw();
  canvas.noStroke();
  for (float y = 0; y < canvas.height; y += h) {
    for (float x = 0; x < canvas.width; x += w) {
      int digit = int(""+pi.charAt(index));
      float b = map(digit, 0, 9, 0, 255);
      canvas.fill(b);
      canvas.rect(x, y, w, h);
      if (drawText) {
        canvas.fill(255 - b);
        canvas.textAlign(CENTER);
        canvas.text(digit, x + (w/2), y + h);
      }
      index += 1;
      index = index % pi.length();
    }
  }
  canvas.endDraw();
  if (writePDF) {
    endRecord();
  }
  image(canvas, 0, 0, width, height);
  canvas.save("poster.png");
}

void draw() {
}
