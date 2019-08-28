final float FRAMES_TO_TURN = 100;
class Cube {
  Cubie[] cubies;

  boolean turning = false;
  boolean turningX = false;
  boolean turningY = false;
  boolean turningZ = false;
  float turnAngle = 0;
  float turningFrame = 0;

  int turningIdx = 0;

  Cube() {
    int idx = 0;
    cubies = new Cubie[TOTAL_CUBIES];
    for (int x = -1; x < 2; x += 1) {
      for (int y = -1; y < 2; y += 1) {
        for (int z = -1; z < 2; z += 1) {
          //float len = 50;
          //float offset = (DIM - 1)* len * 0.5;
          //float xx = len * x - offset;
          //float yy = len * y - offset;
          //float zz = len * z - offset;
          PMatrix3D m = new PMatrix3D();
          m.translate(x, y, z);
          cubies[idx] = new Cubie(m, x, y, z);
          idx += 1;
        }
      }
    }
    //frameRate(1);
    cubies[0].highlight = true;
    cubies[1].highlight = true;
    cubies[2].highlight = true;
  }

  void draw() {
    for (int i = 0; i < cubies.length; i++) {

      cubies[i].draw();
      //cube[i].highlight = false;
    }
  }

  void update() {
    if (turning) {
      if (turningZ) {
        turningFrame += 1;
        turnAngle = lerp(0,HALF_PI, turningFrame / FRAMES_TO_TURN);
        for (int i = 0; i < cubies.length; i += 1) {
          Cubie c = cubies[i];
          if (c.z == turningIdx) {
            PMatrix2D m = new PMatrix2D();
            m.rotate(turnAngle);
            m.translate(c.x, c.y);
            //m.print();
            c.update(m.m02, m.m12, c.z);
          }
        }
        if (int(turningFrame) == int(FRAMES_TO_TURN)) {
          turning =false;
          turningZ = false;
          turnAngle = 0;
          turningFrame = 0;
        }
      }
    }
  }

  void turnZ(int idx) {
    if (!turning) {
      turning = true;
      turningZ = true;
      turningIdx = idx;
      turnAngle = 0;
      turningFrame = 0;
    }
  }
}
