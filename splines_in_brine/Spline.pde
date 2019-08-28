class Spline {
  ArrayList<PVector> points = new ArrayList<PVector>();
  int cw = canvas.width;
  int cw8 = canvas.width/8;
  int cw4 = canvas.width/4;
  int cw2 = canvas.width/2;
  int cw16 = canvas.width/16;

  int ch2 = canvas.height/2;

  public Spline() {
    for (int i = 0; i < 10; i += 1) {
      addPoint(random(canvas.width), random(canvas.height));
    }
    //for (int x = cw8; x < cw-cw8; x += cw16) {
    //  addPoint(x,ch2);
    //}
  }

  void draw() {




    canvas.stroke(255);
    canvas.noFill();
    
    for (float t = 0; t < (float)points.size()-3; t += 0.005f) {
      PVector p = splinePoint(t);
      canvas.point(p.x, p.y);
    }


    for (int i = 0; i < points.size(); i += 1) {
      PVector p = points.get(i);

      if (i == selectedPoint) {
        canvas.stroke(255, 0, 0);
        canvas.ellipse(p.x, p.y, 6, 6);
        canvas.stroke(255);
      }
      canvas.ellipse(p.x, p.y, 4, 4);
    }
  }

  public void addPoint(float x, float y) {
    points.add(new PVector(x, y));
  }

  PVector splinePoint(float t) {

    PVector p = new PVector(0, 0);
    int p0,p1,p2,p3;
    
    p1 = (int)t + 1;
    p2 = p1 + 1;
    p3 = p2 + 1;
    p0 = p1 - 1;
    t = t - (int)t;
    
    float tt = t * t;
    float ttt = tt * t;
    
    float q1 = -ttt + 2*tt - t;
    float q2 = 3*ttt - 5 *tt + 2;
    float q3 = -3*ttt + 4*tt + t;
    float q4 = ttt - tt;
    
    float tx = 0.5 * (points.get(p0).x * q1 + points.get(p1).x * q2 + points.get(p2).x * q3 + points.get(p3).x * q4);
    float ty = 0.5 * (points.get(p0).y * q1 + points.get(p1).y * q2 + points.get(p2).y * q3 + points.get(p3).y * q4);
    p.set(tx,ty);

    return p;
  }
}
