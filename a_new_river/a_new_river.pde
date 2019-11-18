Map map;
void reset() {
  map = new Map(20);
  rivers.clear();
  float sx = random(width / 4, width - (width / 4));
  
  float ex = random(width / 4, width - (width / 4));
  
  River r = new River(sx, -50, ex, height+50);
  rivers.add(r);
}
ArrayList<River> rivers = new ArrayList<River>();
void setup() {
  size(800, 800);
  noSmooth();
  reset();
}

void draw() {
  background(51);
  
  for (int i = rivers.size()-1; i >= 0; i -= 1) {
    River r = rivers.get(i);
    r.update();
    r.draw();
  }
  
  map.draw();

}

void mouseReleased() {
  if (mouseButton == LEFT) {
    //addPoint();
    reset();
  }
}




PVector GetSplinePoint(ArrayList<PVector> points, float t, boolean bLooped) {
  int p0, p1, p2, p3;
  if (!bLooped) {
    p1 = (int)t + 1;
    p2 = p1 + 1;
    p3 = p2 + 1;
    p0 = p1 - 1;
  } else {
    p1 = (int)t;
    p2 = (p1 + 1) % points.size();
    p3 = (p2 + 1) % points.size();
    p0 = p1 >= 1 ? p1 - 1 : points.size() - 1;
  }

  t = t - (int)t;

  float tt = t * t;
  float ttt = tt * t;

  float q1 = -ttt + 2.0f*tt - t;
  float q2 = 3.0f*ttt - 5.0f*tt + 2.0f;
  float q3 = -3.0f*ttt + 4.0f*tt + t;
  float q4 = ttt - tt;

  PVector pv0 = points.get(p0);
  PVector pv1 = points.get(p1);
  PVector pv2 = points.get(p2);
  PVector pv3 = points.get(p3);

  float tx = 0.5f * (pv0.x * q1 + pv1.x * q2 + pv2.x * q3 + pv3.x * q4);
  float ty = 0.5f * (pv0.y * q1 + pv1.y * q2 + pv2.y * q3 + pv3.y * q4);


  return new PVector(tx, ty);
  //return{ tx, ty };
}
