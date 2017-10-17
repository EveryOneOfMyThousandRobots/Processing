class Wh extends DrawMe {
  ArrayList<Wh> children = new ArrayList<Wh>();
  Wh (float x, float y, float w, float h, float b, color fill, color border) {
    super(x,y,w,h,b,fill, border);
  }
}

class Row extends Wh {
  
  Row (float x, float y, float w, float h, float b) {
    super(x,y,w,h,b,color(0), color(255,0,0));
    
    for (int i = 0; i < 5; i += 1) {
      Bay b = new Bay(x, y + 
    }
    
  }
}

class Bay extends Wh {
  Bay (float x, float y, float w, float h, float b) {
    super(x,y,w,h,b,color(0), color(255,255,0));
  }
}