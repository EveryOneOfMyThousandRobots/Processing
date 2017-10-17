class DNAVAL {
  
}
class DNA {
  TreeMap<String, Float> dna = new TreeMap<String, Float>();
  float mutationRate = 0.03;
  
  void mutate() {
    for (String s : dna.keySet()) {
      float f = dna.get(s);
      if (random(1) < mutationRate) {
        f += random(-0.1, 0.1);
        dna.put(s, f);
      }
    }
  }
  
  DNA cross(DNA partner) {
    DNA child = new DNA();
    
    for (String s : dna.keySet()) {
      Float f1 = dna.get(s);
      Float f2 = partner.dna.get(s);
      
      if (f2 == null) {
        child.dna.put(s, f1);
        
      } else {
        if (random(1) < 0.5) {
          child.dna.put(s, f1);
        } else {
          child.dna.put(s, f2);
        }
      }
    }
    
    child.mutate();
    return child;
  }
  
  void add(String s, float min, float max) {
    
    if (!this.dna.containsKey(s)) {
      dna.put(s,random(min, max));
    }
    
  }
  
  void add(String s) {
    add(s,-1,1);
  }
  
  float get(String s) {
    if (!dna.containsKey(s)) {
      add(s, -1,1);
    }
    return dna.get(s);
  }
  
  float get(String s, float min, float max) {
    if (!dna.containsKey(s)) {
      add(s, min, max);
    }
    
    return dna.get(s);
  }
}