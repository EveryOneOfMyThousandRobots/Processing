

class DNA {
  TreeMap<String, Float> dna = new TreeMap<String, Float>();

  DNA() {
    add(MUT_RATE, 0.001, 0.01);
    add(MUT_RANGE_LOW, -0.01);
    add(MUT_RANGE_HIGH, 0.01);
  }
  
  DNA(DNA dna) {
    for (String s : dna.dna.keySet()) {
      this.add(s, dna.get(s));
    }
    mutate();
  }

  void add(String s, Float f) {
    dna.put(s.toUpperCase(), f);
  }

  void add(String s, Float rangeLow, Float rangeHigh) {
    dna.put(s.toUpperCase(), random(rangeLow, rangeHigh));
  }

  float get(String s) {
    s = s.toUpperCase();
    if (dna.containsKey(s)) {
      return dna.get(s);
    } else {
      add(s, 0f);
      return 0f;
    }
  }
  
  String getString(String s) {
    return nfc(get(s),4);
  }

  void mutate() {
    float mr = get(MUT_RATE);
    float mal = get(MUT_RANGE_LOW);
    float mah = get(MUT_RANGE_HIGH);

    for (String s : dna.keySet()) {
      if (random(1) < mr) {
        float nv = dna.get(s) + random(mal, mah);
        nv = constrain(nv, -1,1);
        dna.put(s, nv);
      }
    }
  }
}
