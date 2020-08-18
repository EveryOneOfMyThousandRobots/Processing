class Tile {
  final int x, y;
  PVector pos;
  color c;
  boolean chosen = false;
  float a = random(TWO_PI);
  Tile (int x, int y) {
    this.x = x;
    this.y = y;
    pos = new PVector(x * TS, y * TS);
    
  }
  


  void update(float f) {
    
    float ns = fNoise(x,y);

    float n = map(cos(a + ((ns + f) * TWO_PI)), -1, 1, 0, 1);

    float xs = (float)x / (float)TA;
    float ys = (float)y / (float)TD;
    c = lerpColor(A, B, (xs + ys) / 2);

    if (chosen) {
      c = lerpColor(A,B,n);
    } else {
    }
  }


  void draw() {
    noStroke();
    fill(c);
    rect(pos.x, pos.y, TS, TS);
  }
}

float fNoise(int x, int y) {
  float xx = (float) x * ns;
  float yy = (float) y * ns;
  
  return noise(xx,yy, Z);
}
