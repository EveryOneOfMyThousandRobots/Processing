Module beingDragged = null;
int grabOffsetX = -1;
int grabOffsetY = -1;

boolean dragConn = false;
Module dragConnSrc = null;
int dragConnSrcOutput = -1;

void mousePressed() {
  for (Module mod : mods) {
    if (mod.isMouseOver(mouseX,mouseY)) {
      println("mouse is over " + mod.id);
      
      int i = mod.getMouseOverInputIndex(mouseX,mouseY);
      if (i >= 0) {
        
        
        println("mouse is over input " + i);
      }
      
      int o = mod.getMouseOverOutputIndex(mouseX,mouseY);
      if (o >= 0) {
        dragConn = true;
        dragConnSrc = mod;
        dragConnSrcOutput = o;
        println("mouse is over output " + o);
      }
      
      if (i == -1 && o == -1) {
        
        grabOffsetX = floor(mod.pos.x - mouseX);
        grabOffsetY = floor(mod.pos.y - mouseY);
        beingDragged = mod;
        break;
      }
    }
  }
}

void mouseDragged() {
  if (beingDragged != null) {
    beingDragged.pos.x = mouseX + grabOffsetX;
    beingDragged.pos.y = mouseY + grabOffsetY;
  } else if (dragConn) {
    
  }
}

void mouseReleased(){
  if (dragConn) {
    
  }
  
  beingDragged = null;
  dragConn = false;
}
