final float MIN_SIZE = 10;

float zz = 0;
float xo = 0;
float yo = 0;
color getColour(float x, float y) {
  
  
  
  float xx = x * 0.01;
  float yy = y * 0.01;
  
  float h = noise(xo + xx,yo + yy,zz);
  float s = noise(xo + xx,yo + yy,zz+10);
  float b = noise(xo + xx,yo + yy,zz+20);
  
  color c = color(h * 255, s * 255, b * 255);
  
  
  
  
  
  
  return c;
}

class Tile {
  PVector pos, dims;
  Tile parent;
  Tile[] children = null;
  color c;
  
  void update() {
    if (children == null) {
      c = getColour(pos.x, pos.y);
      
    } else {
      for (Tile t : children) {
        t.update();
      }
    }
  }
  Tile(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    dims = new PVector(w, h);
    c = getColour(x,y);
    int ca = floor(random(4, 17));
    ca -= ca % 2;
    int childrenAcross = ca; 

    float cw = dims.x / (float)childrenAcross;

    if (cw < MIN_SIZE) {
    } else {
      children = new Tile[childrenAcross * childrenAcross];
      
      for (int xp = 0; xp < childrenAcross; xp += 1) {
        for (int yp = 0; yp < childrenAcross; yp += 1) {
          int index = yp * childrenAcross + xp;
          float xx = pos.x + (xp * cw);
          float yy = pos.y + (yp * cw);
          
          
          children[index] = new Tile(xx,yy,cw,cw);
        }
      }
        
      
    }
  }


  void draw() {
    if (children == null) {
      
      noStroke();
      fill(c);
      rect(pos.x, pos.y, dims.x+5, dims.y+5);
    } else {
      for (Tile t : children) {
        t.draw();
      }
    }
  }
}
Tile tile;
void setup() {
  zz += 0.1;
  size(800,800);
  colorMode(HSB);
  tile = new Tile(0,0,width,height);
  tile.update();
}


void draw() {
  background(0);
  tile.update();
  tile.draw();
  zz += 0.001;
  xo += 0.001;
  yo += 0.001;
}
