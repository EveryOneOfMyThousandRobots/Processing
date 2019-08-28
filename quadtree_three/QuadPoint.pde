int QUAD_POINT_ID = 0;
class QuadPoint {
  final int id;
  final PVector pos;
  
  {
    QUAD_POINT_ID += 1;
    id = QUAD_POINT_ID;
  }
  
  QuadPoint(float x, float y) {
    pos = new PVector(x,y);
    
  }
  
  
  void draw() {
    stroke(255);
    point(pos.x, pos.y);
  }
}
