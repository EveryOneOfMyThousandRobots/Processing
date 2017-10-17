class Shp {
  int points;
  PVector pos;
  float rad;
  float diam;
  ArrayList<PVector> drawPoints = new ArrayList<PVector>();
  Shp(float x, float y, int points, float rad, float angleStart) {
    pos = new PVector(x, y);
    this.points = points;
    this.rad = rad;
    diam = rad * 2;
    
    //float ff = radians(45);
    float highestY = 0;
    
    //pos.y = height - rad;
    float ai = TWO_PI / points;
    float aa = ((TWO_PI / 4) * 3) + angleStart;
    for (int i = 0; i < points; i++) {

      float xx = pos.x + rad * cos(aa + ai * i);
      float yy = pos.y + rad * sin(aa + ai * i);
      if (yy > highestY) {
        highestY = yy;
      }
      drawPoints.add( new PVector(xx, yy));
    }
    
    float ay = height - highestY;
    for (PVector p : drawPoints) {
      p.y += ay;
      p.y -= 10;
    }
  }

  void draw() {
    for (int i = 1; i < drawPoints.size(); i++) {
      PVector p = null, lp = null, np = null;
      p = drawPoints.get(i);
      lp = drawPoints.get(i-1);
      if (i == drawPoints.size() - 1) {
        np = drawPoints.get(0);
      }

      line(p.x, p.y, lp.x, lp.y);
      if (np != null) {
        line(p.x, p.y, np.x, np.y);
      }
    }
  }
}

ArrayList<Shp> shapes = new ArrayList<Shp>();
void setup () {
  size(600, 600);
  for (int i = 0; i < 7; i++) {
    float rad = (width / 8) + ((width / 16) * i);
    int pnts = i + 3;

    float aa = 0;
    if (pnts == 8) {
      aa = (TWO_PI / 16) * 3;
    } else if (pnts % 2 == 0) {
      aa = (TWO_PI / 16) * (i + 1);
    }
    //} else if (pnts % 4 == 0) {
    //  aa += TWO_PI / 8;

    //}
    Shp s = new Shp(width / 2, height / 2, i + 3, rad, aa);
    shapes.add(s);
  }
}

void draw() {
  background(0);
  stroke(255);
  noFill();

  for (Shp s : shapes) {
    s.draw();
  }
  stop();
}