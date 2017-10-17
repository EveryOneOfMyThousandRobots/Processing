import java.util.TreeMap;
final String MUTATION_RATE_NAME = "MUTATION_RATE";
final float MUTATION_RATE = 0.03;

class DNA {
  
  TreeMap<String, Float> genes = new TreeMap<String, Float>();

  DNA() {
    //add(MUTATION_RATE_NAME, random(-1, 1));
  }

  String toString() {
    String output = "\nDNA";
    int count = 1;
    for (String s : genes.keySet()) {
      if (count % 3 == 0) {
        output += "\n";
      }
      output += "\t" + s + ": " + genes.get(s);
      count += 1;
    }

    return output;
  }
  //mutate
  void mutate() {
    float mutationRate = MUTATION_RATE;//get(MUTATION_RATE_NAME, 0.001, 0.5);
    for (String s : genes.keySet()) {
      if (random(1) < mutationRate) {
        float f = genes.get(s);
        f += random(0, 0.1);
        if (f < -1) f = random(-1,1);
        if (f >= 1) f = -1;
        genes.put(s, f);
      }
    }
  }

  DNA cross (DNA partner) {
    DNA newDNA = new DNA();
    newDNA.genes.clear();

    for (String s : genes.keySet()) {
      if (!partner.genes.containsKey(s) || random(1) < 0.5) {
        newDNA.genes.put(s, genes.get(s));
      } else {
        newDNA.genes.put(s, partner.genes.get(s));
      }
    }
    
    for (String s : partner.genes.keySet()) {
      if (!newDNA.genes.containsKey(s)) {
        newDNA.genes.put(s, partner.genes.get(s));
      }
    }
    return newDNA;
  }



  //standard get set etc

  void add(String name, float f) {
    if (!genes.containsKey(name)) {
      genes.put(name, f);
    }
  }

  void set(String name, float f) {
    if (!genes.containsKey(name)) {
      add(name, f);
    } else {
      genes.put(name, f);
    }
  }

  float get(String name) {
    if (!genes.containsKey(name)) {
      add(name, random(-1, 1));
    }

    return genes.get(name);
  }

  float get(String name, float mapFrom, float mapTo) {
    float value = get(name);
    if (Float.isNaN(value)) {
      value = 0;
    }
    value = map(value, -1, 1, mapFrom, mapTo);

    return value;
  }



  float get(String name, float defaultValue) {
    if (!genes.containsKey(name)) {
      add(name, defaultValue);
    }

    return genes.get(name);
  }
}