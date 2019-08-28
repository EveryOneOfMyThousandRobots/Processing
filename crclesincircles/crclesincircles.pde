float cx, cy;
float angle = 0;
float inc = radians(45);
float r1, r2;
PImage p1, mask;
float aa_inc;
float aa_angle;
final float RADIANS_ONE = radians(1);
final float RADIANS_45 = radians(45);
final float RADIANS_90 = radians(90);
final float RADIANS_ONE_TENTH = radians(0.1);
final float RADIANS_FIVE_TENTHS = radians(0.5);
void setup() {
  size(400, 400);
  cx = width / 2;
  cy = height / 2;
  r1 = width / 4;
  r2 = width / 3;
  p1 = createImage(width, height, ARGB);
  mask = createImage(width, height, RGB);
  background(0);
  fill(255);
  stroke(255);
  ellipse(cx, cy, width / 2, width / 2);
  loadPixels();
  mask.loadPixels();
  
  for (int i = 0; i < pixels.length; i += 1) {
    mask.pixels[i] = pixels[i];
  }
  mask.updatePixels();
}

void draw() {
  noFill();
  stroke(0);
  background(255);
  aa_angle = (aa_angle + RADIANS_FIVE_TENTHS) % TWO_PI;
  aa_inc = map(sin(aa_angle), -1, 1, RADIANS_45, RADIANS_90);
  for (float a = angle; a < angle + TWO_PI; a += inc) {
    float xx = cx + r1 * cos(a);
    float yy = cy + r1 * sin(a);
    beginShape();
    
    for (float aa = 0; aa < TWO_PI; aa += aa_inc) {
      float x1 = xx + r2 * cos(aa);
      float y1 = yy + r2 * sin(aa);

      //if (dist(x1, y1, cx, cy) < r1) {
      vertex(x1, y1);
      //}
    }
    endShape(CLOSE);
  }

  loadPixels();
  p1.loadPixels();
  for (int i = 0; i < pixels.length; i += 1) {
    p1.pixels[i] = pixels[i];
  }
  p1.updatePixels();
  p1.mask(mask);
  background(255);
  image(p1, 0, 0);
  angle += RADIANS_ONE_TENTH;
}