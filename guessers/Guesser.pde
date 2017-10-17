int getNum() {
  return floor(random(GUESS_MIN, GUESS_MAX));
}

import java.util.Comparator;
GuesserComparator gc = new GuesserComparator();
class Guesser implements Comparable<Guesser>{
  int score;//, guess;
  
  
  
  void test(int answer) {
    if (getNum() == answer) {
      score += 1;
    }
    
  }
  
  int compareTo(Guesser o) {
    if (score > o.score) {
      return 1;
    } else if (score < o.score) {
      return -1;
    } else {
      return 0;
    }
  }
}

class GuesserComparator implements Comparator<Guesser>{
  int compare(Guesser g1, Guesser g2) {
    return g1.compareTo(g2);
  }
  
  
}