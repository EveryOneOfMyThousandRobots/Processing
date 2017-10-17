class Node {
  float x, y;
  float w, h;
  boolean dragging = false;
  
  Node (float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
  
  }

  Node inside(float xx, float yy) {
    
    float bx = x - w / 2;
    float by = y - h / 2;
    float bxx = bx + w;
    float byy = by + h;
    println("(" + xx + "," + yy + ") (" + x + "," + y + ") (" + w + "," + h + ") (" + bx + "," + by + ") (" + bxx + "," + byy + ")");
    if (xx >= bx && xx <= bxx && yy >= by && yy <= byy) {
      return this;
    } else { 
      return null;
    }
  }
  
  void draw() {
    stroke(255);
    fill(255);
    ellipse(x,y,w,h);
  }
}

ArrayList<Node> nodes = new ArrayList<Node>();

Node overNode(float x, float y) {
  
  Node nr = null;
  for (Node n : nodes) {
     nr = n.inside(x,y);
     
     if (nr != null) {
       break;
     }
  }
  println(" " + (nr == null));
  return nr;
}