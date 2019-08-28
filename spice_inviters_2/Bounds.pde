final int NOT_OUT = 0;
final int OUT_TOP = 1;
final int OUT_BOTTOM = 2;
final int OUT_LEFT = 3;
final int OUT_RIGHT = 4;


int outOfBounds(Mover o) {
  int x = floor(o.pos.x);
  int y = floor(o.pos.y);
  int w = floor(o.dims.x);
  int h = floor(o.dims.y);
  int w2 = w/2;
  int h2 = h/2;
  if (PLAY_BOUNDS.inside(x,y)) {
    return NOT_OUT;
  } else {
    if (x < PLAY_XPOS - w2) {
      return OUT_LEFT; 
      
    }
    
    if (x > PLAY_XPOS + PLAY_WIDTH + w2) {
      return OUT_RIGHT;
    }
    
    if (y < PLAY_YPOS - h2) {
     return OUT_TOP; 
    }
    
    if (y > PLAY_YPOS + PLAY_HEIGHT + h2){
      return OUT_BOTTOM;
    }
    
    return NOT_OUT;
    
    
  }
  
  
}
