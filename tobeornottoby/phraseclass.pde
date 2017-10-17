class Phrase {
  String[] DNA;
  float fitness = 0;

  Phrase() {

    DNA = new String[floor(random(255))];

    for (int i = 0; i < DNA.length; i += 1) {
      DNA[i] = getChar();
    }
  }

  String toString() {
    String output = "";
    for (int i = 0; i < DNA.length; i += 1) {
      output += DNA[i];
    }

    return output;
  }

  void calc() {
    fitness = 0.01;
    
    for (int i = 0; i < DNA.length && i < MATCH_ME_LEN; i += 1) {
      
      if (str(MATCH_ME.charAt(i)).equals(DNA[i])) {
        fitness += 1;
      }
    }
    
    fitness += 1 abs(MATCH_ME_LEN - DNA.length);

    fitness = pow(fitness, FITNESS_EXP);
  }

  void normalise() {
    fitness /= maxFitness;
  }

  Phrase makeSweetSweetLove(Phrase partner) {
    Phrase p = new Phrase();


    for (int i = 0; i < p.DNA.length; i += 1) {
      float r = random(1);


      String ch = getChar(); //DNA[i];
      if (r < 0.5) {
        if (i < partner.DNA.length) {
          ch = partner.DNA[i];
        }
      } else {
        if (i < DNA.length) {
          ch = DNA[i];
        }
      }

      p.DNA[i] = ch;
    }

    return p;
  }

  void mutate() {
    for (int i = 0; i < DNA.length; i += 1) {
      if (random(1) <= MUTATION_RATE) {
        DNA[i] = getChar();
      }
    }
  }
}

String getChar() {
  int r = floor(random(63, 123));

  if (r == 63) r = 32;
  if (r == 64) r = 46;

  return str(char(r));
}