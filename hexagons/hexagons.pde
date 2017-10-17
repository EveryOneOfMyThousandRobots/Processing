PVector hex_corner(PVector ctr, float size, int i) {
  float angle = radians(60 * i);
  
  return new PVector(ctr.x + size * cos(angle), ctr.y + size * sin(angle));
}


void drawHex(float x, float y, float size) {
  PVector ctr = new PVector(x,y);
  ArrayList<PVector> corners = new ArrayList<PVector>();
  for (int i = 0; i < 6; i += 1) {
    corners.add(hex_corner(ctr, size, i));
    
  }
  PVector last = corners.get(0);
  for (int i = 1; i < corners.size(); i += 1) {
    PVector corner = corners.get(i);
    line(last.x, last.y, corner.x, corner.y);
    last = corner;
    //text(i, corner.x, corner.y);
  }
  line(last.x, last.y, corners.get(0).x, corners.get(0).y);
  ellipse(ctr.x, ctr.y, 10, 10);
}
void setup() {
  size(800,800);
  noLoop();
}

void draw() {
  background(0);
  stroke(255);
  
  
  float size = width / 8;
  int xoff = 0;
  float w = size;
  float h = (sqrt(3) / 2) * w;
  float xinc = w * 1.5;
  float yinc = h;
  for (float x = w; x < width; x += xinc) {
    xoff += 1;
    int yoff = 0;
    
    for (float y = w; y < height; y += yinc){
      float xx = 0;
      float yy = 0;
      if (yoff % 2 == 0) {
        xx = x + xinc;
        yy = y + h;
      } else {
        xx = x;
        yy = y;
      }
      if (xoff % 2 != 0 ) {
        yy += h;
      }
      drawHex(xx,yy,size);
      yoff += 1;
    }
  }
  
}