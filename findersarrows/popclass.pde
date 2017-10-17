class Pop {
  ArrayList<C> cs = new ArrayList<C>();
  float highestFitness = 0;
  int timer = 0;
  Pop () {
    for (int i = 0; i < POP_SIZE; i += 1) {
      cs.add(new C());
    }
  }


  void calc() {
    highestFitness = 0;
    for (C c : cs) {
      if (c.fitness > highestFitness) {
        highestFitness =c.fitness;
      }
    }
    for (C c : cs) {
      c.fitness /= highestFitness;
    }
  }

  void breed() {
    ArrayList<C> new_cs = new ArrayList<C>();

    while (new_cs.size() < cs.size()) {

      C a = getPartner();
      if ( a != null) {
        new_cs.add(new C(a));
      }
    }


    cs = new_cs;
    println(this);
  }

  C getPartner() {
    C t = null;

    while (t == null) {
      int r1 = floor(random(cs.size()));
      float r2 = random(1);
      t = cs.get(r1);
      if (r2 < t.fitness) {
        break;
      } else {
        t = null;
      }
    }

    return t;
  }

  void draw() {
    for (C c : cs) {
      c.update();
    }
  }

  String toString() {
    String output = " pop " + timer + "\n";
    for (C c : cs) {
      output += "\n" + c.toString();
    }
    return output;
  }

  void update() {
    for (C c : cs) {
      c.draw();
    }
    timer += 1;

    if (timer > RESTART_AFTER) {
      calc();
      breed();
      timer = 0;
    }
  }
}