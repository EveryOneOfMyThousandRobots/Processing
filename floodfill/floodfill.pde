void setup() {
  size(150,150);
  noLoop();
}





void draw() {
  background(255);
  noFill();
  stroke(0);
  rectMode(CENTER);
  square(width / 2, height / 2, width/2);
  loadPixels();
  make();
  
  flood( width / 2, height / 2, color(255,0,0));
}


ArrayList<MP> getNeighbours(MP p) {
  return null;
  
}


void flood(int x, int y, color fl) {
  loadPixels();
  
  ArrayList<MP> open = new ArrayList<MP>();
  ArrayList<MP> closed = new ArrayList<MP>();
  ArrayList<MP> path = new ArrayList<MP>();
  
  MP c = getList(x,y);
  if (c != null) {
    open.add(c);
    if (c.c != color(0)) {
      c.c = fl;
      set(x,y,fl);
    } else {
      return;
    }
  }
  
  
  
  
  while (!open.isEmpty()) {
    println(open.size());
    MP current = open.get(open.size()-1);
    
    //ArrayList<MP> neighbours = getNeighbours(current);
    path.clear();
    MP temp = current;
    path.add(temp);
    
    
    open.remove(current);
    closed.add(current);
    
    for (MP m : current.neighbours) {
      if (!closed.contains(m)) {
       m.c = fl;
       set(m.x, m.y, fl);
       open.add(m);
      }
    }
    
  }
  
  //for (int yy = y; yy < width; yy += 1) {
  //  color ppc;
  //  for (int xx = x; xx > 0; xx -= 1) {
  //    color pc = get(xx,yy);
  //    if (brightness(pc) < 2) {
  //      break;
  //    } else {
  //      set(xx,yy,fl);
        
  //    }
  //  }
  //}
}
