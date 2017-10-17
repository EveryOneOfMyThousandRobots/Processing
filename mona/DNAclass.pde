import java.util.TreeMap;
class DNA {
  TreeMap<String, Gene> genes = new TreeMap<String, Gene>();

  DNA copy() {
    DNA newdna = new DNA();

    for (String s : genes.keySet()) {
      newdna.genes.put(s, genes.get(s).copy());
    }

    return newdna;
  }

  String toString() {
    int i = 0;
    String output= "\nDNA";
    for (String s : genes.keySet()) {
      output += "\t" + s + " : " + genes.get(s).value +"\n";
      i += 1;
      if (i > 10) {
        break;
      }
    }

    return output;
  }

  DNA cross(DNA partner) {
    DNA newdna = new DNA();
    for (String s : genes.keySet()) {
      if (!partner.genes.containsKey(s)) {

        newdna.genes.put(s, genes.get(s).copy());
      } else if (random(1) < 0.5) {
        newdna.genes.put(s, genes.get(s).copy());
      } else {
        newdna.genes.put(s, partner.genes.get(s).copy());
      }
    }

    for (String s : partner.genes.keySet()) {
      if (!genes.containsKey(s)) {
        newdna.genes.put(s, partner.genes.get(s));
      }
    }

    return newdna;
  }

  void add(String s, float value, float min, float max) {
    if (!genes.containsKey(s)) {
      genes.put(s, new Gene(value, min, max));
    }
  }

  float get(String s, float min, float max) {

    if (!genes.containsKey(s)) {
      add(s, random(min, max), min, max);
    }

    return genes.get(s).value;
  }

  float get(String s) {
    if (!genes.containsKey(s)) {
      add(s, random(0, 1), 0, 1);
    }

    return genes.get(s).value;
  }
  
  void mutate() {
    if (random(1) < MUTATION_RATE && random(1) < MUTATION_RATE) {
      mutate_radical();
    } else {
      mutate_regular();
    }
  }

  void mutate_radical() {
    println("radical dude!");
    
    for (String s : genes.keySet()) {
      if (random(1) < MUTATION_RATE) {
        Gene g = genes.get(s);

        g.value = random(g.min, g.max);
      }
    }
  }

  void mutate_regular() {
    for (String s : genes.keySet()) {
      if (random(1) < MUTATION_RATE) {
        Gene g = genes.get(s);

        g.value += random(-2, 2);
        if (g.value < g.min) {
          g.value = g.min;
          //g.value += g.max - abs(g.value);
        }
        if (g.value > g.max) {
          g.value = g.max;
          //g.value = g.min + (g.value - g.max);
        }
      }
    }
  }
}

class Gene {
  float value;
  float min;
  float max;

  Gene copy() {
    return  new Gene(value, min, max);
  }

  Gene(float value, float min, float max) {
    this.value = value;
    this.min = min;
    this.max = max;
  }
  Gene(float min, float max) {
    this(random(min, max), min, max);
  }
}