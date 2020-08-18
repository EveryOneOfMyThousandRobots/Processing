float fx(float x, float y, float t) {

  float rx = sin(y) * y + cos(t);

  return rx;
}


float fy(float x, float y, float t) {

  float ry = cos(x) * x + sin(t);

  return ry;
}

final float T_MIN = -3;
final float T_MAX = 3;
final int TOTAL_FRAMES = 2400;




void setup() {
  size(300, 300);
  noSmooth();
  noLoop();
}

void draw() {
  background(0);

  float t = map(frameCount % TOTAL_FRAMES, 0, TOTAL_FRAMES, T_MIN, T_MAX);
  float px = 0, py = 0;
  stroke(255, 64);
  FloatList xList = new FloatList();
  FloatList yList = new FloatList();

  boolean min_xb = false;
  float min_x = 0;

  boolean max_xb = false;
  float max_x = 0;

  boolean min_yb = false;
  float min_y = 0;

  boolean max_yb = false;
  float max_y = 0;  

  float xp = 0;
  float yp = 0;
  for (float x = 0; x < width; x += 1) {

    xp = constrain(fx(px, py, t), -1e9,1e9);
    yp = constrain(fy(px, py, t), -1e9,1e9);

    xList.append(xp);
    yList.append(yp);
    println(frameCount + " (" + xp + "," + yp + ") (" + px + "," + py + ")");


    px = xp;
    py = yp;

    if (!min_xb || xp < min_x) {
      min_x = xp;
      min_xb =true;
    }

    if (!min_yb || yp < min_y) {
      min_y = yp;
      min_yb = true;
    }

    if (!max_xb || xp > max_x) {
      max_x = xp;
      max_xb = true;
    }

    if (!max_yb || yp > max_y) {
      max_y = yp;
      max_yb = true;
    }
  }






  float prev_x = map(xList.get(0), min_x, max_x, 0, width);
  float prev_y = map(yList.get(0), min_y, max_y, 0, height);
  for (int i = 1; i < xList.size(); i += 1) {
    float x0 = xList.get(i);
    float y0 = yList.get(i);



    float xx = map(x0, min_x, max_x, 0, width);
    float yy = map(y0, min_y, max_y, 0, height);


    line(prev_x, prev_y, xx, yy);
    prev_x = xx;
    prev_y = yy;
  }
  fill(255);
  text(frameCount + "\nt=" + t + 
    "\nx(" + min_x + "," + max_x  + ")" +
    "\ny(" + min_y + "," + max_y  + ")" +
    "", 10, 10);
}
