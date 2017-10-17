int w = 500;
int h = 500;

int t_w = 10;
int t_h = 10;

color[] tiles;

int tiles_across;// = w / t_w;
int tiles_down;// = h / t_h;

float xb, yb, xd, yd;

void setup () {

  tiles_across = w / t_w;
  tiles_down = h / t_h;
  tiles = new color[tiles_across * tiles_down];

  for (int x = 0; x < tiles_across; x += 1) {
    for (int y = 0; y < tiles_down; y += 1) {

      int t = x + y * tiles_across;

      tiles[t] = color(255, 0, 0);
    }
  }
  println(tiles.length);
  xb = width / 2;
  yb = height / 2;
  xd = random(-4, 4);
  yd = random(-4, 4);
  //  frameRate(10);
}


void settings() {
  size(w, h);
}




void draw() {

  if (xb + xd >= width || xb + xd < 0) {
    xd *= -1;
  }
  if (yb + yd >= height || yb + yd < 0) {
    yd *= -1;
  }

  xb += xd;
  yb += yd;
  background(0);
  for (int x = 0; x < tiles_across; x += 1) {

    for (int y = 0; y < tiles_down; y += 1) {
      int t = x + y * tiles_across;
      // println(x + " + " + y + "* " + t_w + " = " +t);


      color tt = tiles[t];
      float xx = x * t_w;
      float yy = y * t_h;
      noStroke();//(0);
      fill(tt);
      rect(xx, yy, xx + t_w, yy + t_h);
      if (xb > xx && xb < xx + t_w && yb > yy && yb < yy + t_h) {
        
        fill(255);
        rect(xx, yy, xx + t_w, yy + t_h);
        
      }
      
    }
  }


  //int t = (int) ((xb/t_w) + (yb/t_w) * tiles_across);
  //tiles[t] = color(255);
  //stroke(255);
  //fill(255);
  //line(width / 2, height / 2, xb, yb);
  //print(" (" + xb + "," + yb +")");
}