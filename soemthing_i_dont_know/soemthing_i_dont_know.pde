int[][] xy;
void setup () {
  size(400,400);
  xy = new int[100][100];
  
  for (int x = 0; x < xy.length; x += 1) {    
    for (int y = 0; y < xy[x].length; y += 1) {
    //  xy[x][y] = color(random(255), random(255), random(255));
      double xx = 1 / degrees(sin(x));
      double yy = 1 / degrees(cos(y));
     // println(xx + "," + yy);
      xy[x][y] = (int)(255 / (xx * yy));
    }
  }
  noLoop();
}

void draw() {
  loadPixels();
  
  int i = 0;
  for (int x = 0; x < xy.length; x += 1) {    
    for (int y = 0; y < xy[x].length; y += 1) {
      int ii = i + 1;
      for ( ; i < ii; i += 1) {
        pixels[i] = xy[x][y];
      }
      
    }
  }
  
    
  
  /*
  int i = 0;
   
  for (int x = 0; x < xy.length; x += 1) {    
    for (int y = 0; y < xy[x].length; y += 1) {
       pixels[i] = xy[x][y];
      i += 1;
    }
  }
  */
  updatePixels();
}