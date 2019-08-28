class DNA {
  HashMap<String, Float> dna = new HashMap<String, Float>();
  float mutationFactor = 0.01;

  DNA(DNA dna) {
    for (String s : dna.dna.keySet()) {
      this.dna.put(s, dna.dna.get(s));
    }
    this.mutationFactor = dna.mutationFactor;
  }

  DNA() {
  }
  
  float get(String s) {
    if (!dna.containsKey(s)) {
      dna.put(s, random(1));
    }
    
    return dna.get(s);
  }  
  
  float getMapped(String s, float from, float to) {
    return map(this.get(s), 0, 1, from, to);
    
  }
  void init() {
    dna.clear();
    dna.put("EYES", random(1));
    dna.put("VIEW_DISTANCE", random(1));
    dna.put("FIRE_RATE", random(1));
    
  }
  

  void mutate() {
    for (String s : dna.keySet()) {
      if (random(1) < mutationFactor) {
        float f = dna.get(s);
        f += random(-0.01,0.01);
        
        f = constrain(f, 0, 1);
        dna.put(s, f);
      }
    }
  }
}
