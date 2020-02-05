class Area {

  PVector pos;
  PVector dims;

  Area(float x, float y, float z) {
    pos = new PVector(x,y,z);
    dims = new PVector(10, 10, 5);
  }
  
  
  PVector toScreen(float x, float y) {
    
    x *= dims.x;
    y *= dims.y;
    PVector p = new PVector();
    
    
    float sx = (pos.x * x) + (pos.y * y);
    float sy = -(pos.x * x) + (pos.y * y) + (pos.z * dims.z);
    
    
    
    p.set(sx, sy);
    
    return p;
  }
}
