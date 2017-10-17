import java.util.TreeMap;

class Genome {
  TreeMap<String, Integer> hox = new TreeMap<String, Integer>();
  ArrayList<Integer> genes = new ArrayList<Integer>();


  Genome() {
    for (int i = 0; i < 20; i += 1) {
      genes.add(floor(random(1, 1000)));
    }
  }

  Genome(Genome g) {
    for (String s : g.hox.keySet()) {
      hox.put(s, g.hox.get(s));
    }

    for (Integer i : g.genes) {
      genes.add(i);
    }
  }

  void add(String s) {
    if (!hox.containsKey(s)) {
      for (int i = 0; i < 3; i += 1) {
        genes.add(floor(random(1, 1000)));
      }
      hox.put(s, floor(random(0, genes.size())));
    }
  }

  int get(String s) {
    if (!hox.containsKey(s)) {
      add(s);
    }
    return genes.get(hox.get(s));
  }

  void mutate() {
    for (String s : hox.keySet()) {
      if (random(1, 100) < 0.5) {
        hox.put(s, floor(random(0, genes.size())));
      }
    }

    for (int i = 0; i < genes.size(); i += 1) {
      if (random(1, 100) < 1) {
        int ii = genes.get(i);
        while (random(1, 100) < 30) {
          
          ii += floor(random(-1, 2));
          if (ii < 0) ii = 999;
          if (ii > 999) ii = 0;
          
        }
        genes.set(i, ii);
      }
    }
  }

  String toString() {
    String s = "";
    for (Integer i : genes) {
      s += i;
    }

    return s;
  }
}