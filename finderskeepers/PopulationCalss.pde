class Population {
  final int size;
  Arena arena;
  ArrayList<C> bots = new ArrayList<C>();
  int generation = 0;
  int age = 0;
  float highestFitness = 0;
  C fittestLastRound = null;

  Population(Arena arena, int size) {
    this.arena = arena;
    this.size = size;

    for (int i = 0; i < size; i += 1) {
      bots.add(new C(arena, null));
      // bots.get(i).applyForce(PVector.random2D());
    }

    // println(bots.get(0).toString());
  }

  void cycle() {
    age += 1;
    for ( C c : bots) {
      c.update();
    }

    if (age > 200) {
      if (printAll) {
        for (C c : bots) {
          println(c);
        }
      }
      breed();
      age = 0;
      generation += 1;
    }
  }

  void draw() {
    for (C c : bots) {
      c.draw();
    }
  }

  C getPartner() {
    C c = null;

    while (c == null) {
      int r1 = floor(random(bots.size()));
      float r2 = random(1);
      c = bots.get(r1);
      if (r2 < c.fitness) {
        break;
      } else {
        c = null;
      }
    }

    return c;
  }

  void breed() {
    ArrayList<C> newBots = new ArrayList<C>();
    fittestLastRound = null;
    highestFitness = 0;
    for (C bot : bots) {
      bot.eval();
      if (bot.fitness > highestFitness) {
        highestFitness = bot.fitness;
        fittestLastRound = bot;
      }
    }
    for (C bot : bots) {
      bot.fitness /= highestFitness;
      bot.fitness /= 2;
    }

    //  println(fittestLastRound);





    while (newBots.size() < bots.size()) {
      C a = getPartner();
      C b = getPartner();
      if (a != null && b != null && a.id != b.id) {
        C baby = a.cross(b);
        newBots.add(baby);
      }
    }
    bots.clear();
    bots = newBots;
  }
}