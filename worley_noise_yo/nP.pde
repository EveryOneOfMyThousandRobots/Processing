class nPV extends PVector implements Comparable<nPV>{
  
  nPV(float x, float y) {
    super(x,y);
  }
  @Override
  int hashCode() {
    return int(y) * width + int(x);
  }
  
  int compareTo(nPV a) {
    int i = hashCode();
    int j = a.hashCode();
    
    return Integer.compare(i,j);
  }
  
  @Override 
  boolean equals(Object o) {
    if (o instanceof nPV) {
      nPV p = (nPV)o;
      if (hashCode() == p.hashCode()) {
        return true;
      }
    }
    
    return false;
  }
  
  
  
}

nPV getRandom2DPV() {
  PVector v = PVector.random2D();
  return new nPV(v.x, v.y);
}
