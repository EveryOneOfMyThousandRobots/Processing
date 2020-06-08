final int WW = 800;
final int WH = 800;

final int TW = 100;
final int TH = 80;

final int TA = WW / TW;
final int TD = WH / TH;

final int SHELVES = 12;
final int BINS = 7;

class Bay {
  
  PVector pos, dims;
  int x,y;
  int dir;
  float shelfWidth;
  float binHeight;
  Bay (int x, int y) {
    this.x = x;
    this.y = y;
    pos = new PVector(x * TW, y * TH);
    dims = new PVector(TW,TH);
    
    dir = x % 2;
    
    shelfWidth = dims.x / (float)SHELVES;
    binHeight = dims.y / (float)BINS;
  }
  
  void draw() {
    noFill();
    stroke(255);
    rect(pos.x, pos.y, dims.x, dims.y);
    float px = pos.x;
    float py = pos.y;
    if (dir == 0) {
      px = pos.x + dims.x - shelfWidth;
    }
    
    for (int s = 0; s < SHELVES; s += 1) {
      stroke(255,0,0);
      noFill();
      rect(px+1,py+1,shelfWidth-2,dims.y-2);
      float bpy = py;
      for (int b = 0; b < BINS; b += 1) {
        stroke(255,255,0);
        fill(255,255,0);
        rect(px+2,bpy+2,shelfWidth-4,binHeight-2);
        bpy += binHeight;
        
        
      }
      if (dir == 0) {
        px -= shelfWidth;
      } else {
        px += shelfWidth;
      }
    }
    
    
    
  }
}
ArrayList<Bay> bays = new ArrayList<Bay>();

void settings() {
  size(WW,WH);
}
void setup() {
  
  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      
      bays.add( new Bay(x,y));
    }
  }
}


void draw() {
  background(0);
  
  for (Bay bay : bays) {
    bay.draw();
  }
}
