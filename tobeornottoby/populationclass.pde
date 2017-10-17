class Population {

  ArrayList<Phrase> pop = new ArrayList<Phrase>();
  String bestLastRound = "";

  Population(int size) {
    for (int i = 0; i < size; i += 1) {
      pop.add(new Phrase());
    }
  }

  Phrase getPartner() {
    Phrase p = null;
    while (true) {
      int r1 = floor(random(pop.size()));
      float r2 = random(1);

      p = pop.get(r1);
      //println("found " + r1 + " fitness " + p.fitness);
      
      if (r2 < p.fitness) {
      //  println(r1 + " succeeded");
        break;
      } else {
       // println(r1 + " failed");
      }
    }
    
    return p;
  }

  void breed() {
    ArrayList<Phrase> newPop = new ArrayList<Phrase>();

    for (int i = 0; i < pop.size(); i += 1) {
      Phrase mum = getPartner();
      Phrase dad = getPartner();

      Phrase child = mum.makeSweetSweetLove(dad);
      child.mutate();
      newPop.add(child);
    }
    pop.clear();
    pop = newPop;
  }

  void calc() {
    maxFitness = 0;
    for (Phrase p : pop) {
      p.calc();
      if (p.fitness > maxFitness) {
        maxFitness = p.fitness;
        bestLastRound = p.toString();
        if (bestFirstGuess.length() == 0) {
          bestFirstGuess = bestLastRound;
          bestFirstFitness = p.fitness;
        }
      }
    }

    for (Phrase p : pop) {
      p.normalise();
    }
  }

  void draw() {
    float x = 10;
    float y = height / 2;
    for (int i = 0; i < pop.size() && y < height - 10; i += 1) {
      text(pop.get(i).toString(), x, y);
      y += 10;
    }

    text("Highest Fitness: " + maxFitness, 10, 10);
    text(bestLastRound, 10, 20);
    text("Max fitness: " + FITNESS_LIMIT, 10, 30);
    text("First guess: " + bestFirstGuess, 10, 40);
    text("First fitess: " + bestFirstFitness, 10, 50);
    text("GEN: " + frameCount, 10, 60);
    text("Millis: " + millis(), 10, 70);
    
  }
}