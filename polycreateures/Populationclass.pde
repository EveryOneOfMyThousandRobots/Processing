class Pop {
  ArrayList<Thing> things = new ArrayList<Thing>();
  float highestFitness = 0;
  float lowestFitness = 0;
  int popSize = 0;
  int generation = 0;
  int index = -1;
  

  Pop(int size) {
    popSize = size;
    for (int i = 0; i < size; i += 1) {
      things.add(new Thing(null));
    }
  }

  Thing getPartner() {
    Thing t = null;

    while (t == null) {
      int r1 = floor(random(things.size()));
      float r2 = random(1);
      t = things.get(r1);
      if (r2 < t.fitness) {
        break;
      } else {
        t = null;
      }
    }

    return t;
  }

  void draw() {
    for (Thing t : things) {
      t.draw();
      t.eval();
    }
  }

  void drawOne() {
    index += 1;
    if (index > things.size() -1) {
      calc();
      breed();
      index = -1;
    } else {
      Thing t = things.get(index);
      t.draw();
      t.eval();
    }
  }

  void cycle() {
    noStroke();
    drawOne();
    //draw();
    //calc();
    //breed();
  }

  void breed() {
    generation += 1;
    ArrayList<Thing> newPop = new ArrayList<Thing>();

    while (newPop.size() < popSize ) { 

      Thing a = getPartner();
      Thing b = getPartner();

      if (a != null && b != null) {
        for (int i = 0; i < 2; i += 1) {
          Thing child = a.breed(b);
          newPop.add(child);
        }
      }
    }

    
    things.clear();
    things = newPop;
  }
  
  String toString() {
    String output  = "";
    output += "gen: " + generation;
    output += "\nhighest: " + highestFitness;
    output += "\nlowest: " + lowestFitness;

    
    return output;
  }

  void calc() {
    highestFitness = 0;
    lowestFitness = 100000000;
    for (Thing t : things) {
      if (t.fitness > highestFitness) {
        highestFitness = t.fitness;
      }
      if (t.fitness < lowestFitness) {
        lowestFitness = t.fitness;
      }
    }
    graph.add(highestFitness);
    for (Thing t : things) {
      t.fitness /= highestFitness;
    }
  }
}