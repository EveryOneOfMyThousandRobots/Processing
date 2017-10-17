import java.util.TreeMap;
final float MUTATION_RATE = 0.01;
class DNA {
  TreeMap<String, Float> genes = new TreeMap<String, Float>();


  //mutate
  void mutate() {
    for (String s : genes.keySet()) {
      if (random(1) < MUTATION_RATE) {
        float f = genes.get(s);
        f += random(-1,1);
        if (f < 0) f += 1;
        if (f > 1) f -= 1;
        genes.put(s, f);
      }
    }
  }

  //add get etc
  void add(String name) {
    genes.put(name, random(0, 1));
  }
  
  //breed
  DNA cross(DNA partnerDNA) {
    DNA newDNA = new DNA();
    
    for (String s : genes.keySet()) {
      if (!partnerDNA.genes.containsKey(s) || random(1) < 0.5) {
        newDNA.genes.put(s, genes.get(s));
      } else {
        newDNA.genes.put(s, partnerDNA.genes.get(s));
      }
    }
    
    for (String s : partnerDNA.genes.keySet()) {
      if (!genes.containsKey(s)) {
        newDNA.genes.put(s, partnerDNA.genes.get(s));
      }
    }
    
    return newDNA;
    
    
  }



  void add(String name, float val) {
    genes.put(name, val);
  }

  float get(String name, float val) {
    if (!genes.containsKey(name)) {
      add(name, val);
    }
    return genes.get(name);
  }

  float get(String name) {
    if (!genes.containsKey(name)) {
      add(name);
    }
    return genes.get(name);
  }
}