class Layer {
  private ArrayList<VW> vals = new ArrayList<VW>();
  
  
  void createLayer(int num) {
    for (int i = 0; i < num; i += 1) {
      putValue(0, random(0.0001,1));
    }
  }
  
  
  void putValue(float v, float w) {
    vals.add(new VW(v,w));
    
  }
  
  
  
  
}

class VW {
  private float v, w;
  
  VW(float v, float w) {
    this.v = v;
    this.w = w;
  }
  
  float getValue() {
    return v;
  }
  
  float getWeight() {
    return w;
  }
  
  float getVW() {
    return v * w;
  }
  
 
  
}