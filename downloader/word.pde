

class Word {
  
  String toString() {
    String out = "\n" + word;
    
    for (String s : follows.keySet()) {
      out += "\n\t" + s + " = " + follows.get(s);
    }
    
    
    
    return out;
  }
  
  Word(String word) {
    this.word = word;
  }
  String word;

  HashMap<String, Integer> follows = new HashMap<String, Integer>();

  ArrayList<String> chooseFrom = new ArrayList<String>();

  void makeChooseFrom() {
    chooseFrom.clear();
    for (String s : follows.keySet()) {
      int j = follows.get(s);

      for (int i = 0; i < j; i += 1) {
        chooseFrom.add(s);
      }
    }
  }

  String choose() {
    if (chooseFrom.size() == 0) {
      makeChooseFrom();
    }

    if (chooseFrom.size() > 0) {
      return chooseFrom.get(floor(random(chooseFrom.size())));
    } else {
      return null;
    }
  }

  void follow(String s) {
    if (follows.containsKey(s)) {
      int i = follows.get(s);
      follows.put(s, i+1);
    } else {
      follows.put(s, 1);
    }
  }
}
