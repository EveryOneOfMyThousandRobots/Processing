class Block {
  PVector pos;
  PVector dims;
  Block(int x, int y, int w, int h) {
    pos = new PVector(x*BLOCK_SIZE,y*BLOCK_SIZE);
    dims = new PVector(w*BLOCK_SIZE,h*BLOCK_SIZE);
  }
  
  void draw() {
    stroke(0,128);
    fill(255,0,0,128);
    rect(pos.x, pos.y, dims.x, dims.y);
  }
  
  boolean intersects(float sx, float sy, float ex, float ey) {
    boolean inside = (sx >= pos.x && sx <= pos.x + dims.x && sy >= pos.y && sy <= pos.y + dims.y);
    if (inside) return inside;
    
    inside = (ex >= pos.x && ex <= pos.x + dims.x && ey >= pos.y && ey <= pos.y + dims.y);
    if (inside) return inside;

    //top
    boolean top = linesIntersect(sx,sy,ex,ey,pos.x,pos.y,pos.x+dims.x,pos.y);
    if (top) return top;
    
    //bottom
    boolean bottom = linesIntersect(sx,sy,ex,ey,pos.x,pos.y+dims.y,pos.x+dims.x,pos.y+dims.y);
    if (bottom) return bottom;
    
    //left
    boolean left = linesIntersect(sx,sy,ex,ey,pos.x,pos.y,pos.x,pos.y+dims.y);
    if (left) return left;
    
        //left
    boolean right = linesIntersect(sx,sy,ex,ey,pos.x+dims.x,pos.y,pos.x+dims.x,pos.y+dims.y);
    if (right) return right;
    
    return false;
    
    
  }
}

void newBlocks() {
  for (int i = 0; i < 10; i += 1) {
    int x = floor(random(3,BLOCKS_ACROSS-3));
    int y = floor(random(3,BLOCKS_DOWN-3));
    int w = floor(random(1,5));
    int h = floor(random(1,5));
    blocks.add( new Block(x,y,w,h));
  }
  
  
}
