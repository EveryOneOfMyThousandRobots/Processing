class Polygon {
  ArrayList<Wall> walls = new ArrayList<Wall>();
  PVector pos;
  float points = 4; //floor(random(3,6));
  
  Polygon(float x, float y) {
    pos = new PVector(x,y);
    float step = TWO_PI / points;
    float r = random(10,50);
    float xf = 0, yf = 0;
    float xx = 0, yy = 0, xl = 0, yl = 0;
    int i = 0;
    for (float a = 0; a < TWO_PI; a += step) {
      //r = random(10,50);
      xx = pos.x + r * cos(a+QUARTER_PI);
      yy = pos.y + r * sin(a+QUARTER_PI);
      
      
      if (i == 0) {
        xf = xx;
        yf = yy;
      } else {
        walls.add(new Wall(xl, yl, xx, yy));
      }
      xl = xx;
      yl = yy;
      i += 1;
    }
    walls.add(new Wall(xl, yl, xf, yf));
    
  }
  
  void draw() {
    for (Wall wall : walls) {
      wall.draw();
    }
  }
}
