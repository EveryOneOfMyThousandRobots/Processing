class VisibleBoxConstraint extends RectConstraint {

  public VisibleBoxConstraint(Vec2D min, Vec2D max) {
    super(min,max);
  }
  
  public void draw() {
    
  }
  
  //public void draw() {
  //  Vec2D m=rect.getMin();
  //  Vec2D n=box.getMax();
  //  beginShape(QUAD_STRIP);
  //  stroke(0);
  //  vertex(m.x,m.y,m.z); vertex(n.x,m.y,m.z);
  //  vertex(m.x,n.y,m.z); vertex(n.x,n.y,m.z);
  //  vertex(m.x,n.y,n.z); vertex(n.x,n.y,n.z);
  //  vertex(m.x,m.y,n.z); vertex(n.x,m.y,n.z);
  //  vertex(m.x,m.y,m.z); vertex(n.x,m.y,m.z);
  //  endShape();
  //}
}