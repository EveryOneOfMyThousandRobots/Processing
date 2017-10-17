//class FlowField {
//  PVector[][] field;
//  int cols, rows;
//  int res;
//  float zoff;

//  FlowField(int res) {
//    this.res = res;
//    cols = width  /res;
//    rows = height / res;
//    field = new PVector[cols][rows];
//    zoff = 0;
//    init();
//    newValues();
//  }

//  PVector find(PVector pos) {
//    int column = int(constrain(pos.x / res, 0, cols-1));
//    int row = int(constrain(pos.y / res, 0, rows-1));
//    //ellipse(pos.x, pos.y, 50,50);
//    //println(column + "," + row + ": " + field[column][row]);
//    return field[column][row].copy();
//  }

//  void draw() {

//    for (int x = 0; x < field.length; x += 1) {

//      for (int y = 0; y < field[x].length; y += 1) {
//        float xx = x * res;
//        float yy = y * res;
//        //line(xx, yy, xx + (field[x][y].x * res), yy + (field[x][y].y * res));
//        drawVector(field[x][y], xx, yy, res - 2);
//      }
//    }
//  }

//  void drawVector(PVector v, float x, float y, float scale) {
//    pushMatrix();
//    translate(x, y);
//    stroke(128, 100);
//    rotate(v.heading());
//    float len = v.mag() * scale;
//    line(0, 0, len, 0);
//    popMatrix();
//  }

//  void init() {

//    for (int x = 0; x < field.length; x += 1) {

//      for (int y = 0; y < field[x].length; y += 1) {

//        field[x][y] = new PVector(0, 0);
//      }
//    }
//  }
//  void newValues() {
//    zoff += 0.001;
//    float xoff = 0;
//    for (int x = 0; x < field.length; x += 1) {
//      float yoff = 0;
//      for (int y = 0; y < field[x].length; y += 1) {
//        float theta = map(noise(xoff, yoff, zoff), 0, 1, 0, TWO_PI);
//        field[x][y].set(cos(theta), sin(theta));
//        yoff += 0.1;
//      }
//      xoff += 0.1;
//    }
//  }

//  void update() {
//    newValues();
//    //if (frameCount % 10 == 0) {
//    //  zoff += 0.01;
//    //  init();
//    //}
//  }
//}