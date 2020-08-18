float angle = 0;
float angleStep = HALF_PI;

long timeNow = gt();
long timeLast = gt();
long timeDelta = 0;
float dt = 0;
PFont font;
long gt() {
  return System.nanoTime();
}
PGraphics img;

final int PX_FACTOR = 8;

float imgw2, imgh2;
void setup() {
  font = createFont("Consolas", 8);
  size(800, 800);
  img = createGraphics(width / PX_FACTOR, height / PX_FACTOR);
  noSmooth();
  imgw2 = img.width / 2;
  imgh2 = img.height / 2;
  img.beginDraw();
  img.textFont(font);
  img.endDraw();
}


void draw() {
  background(0);

  timeNow = gt();
  timeDelta = timeNow - timeLast;
  timeLast = timeNow;
  dt = (float) timeDelta / 1e9;

  angle += angleStep * dt;
  if (angle > TWO_PI) {
    angle -= TWO_PI;
  }


  img.beginDraw();
  img.background(0);
  img.noFill();
  img.stroke(255);
  img.ellipse(imgw2, imgh2, img.width, img.width);
  img.ellipse(imgw2, imgh2, 4, 4);
  
  float xx = cos(angle);
  float yy = sin(angle);
  float d = dist(0,0,xx,yy);
  
  img.beginShape();
  
  img.vertex(imgw2, imgh2);
  img.vertex(imgw2 + floor(imgw2 * xx), imgh2);
  img.vertex(imgw2, imgh2 + floor(imgh2 * yy));
  
  img.endShape(CLOSE);
  
  img.ellipse(imgw2 + (imgw2 * xx), imgh2 + (imgh2 * yy), 5, 5);
  img.fill(0,128);
  img.noStroke();
  img.rect(0,0,img.width,30);
  img.fill(255);
  img.text(nfc(xx, 2) + "," + nfc(yy,2) + " d:" + nfc(d,2) + "\nangle:" + nfc(angle,2), 10, 10);
  img.endDraw();
  image(img, 0, 0, width, height);
}
