class Word {
  String word;
  int totalFollows = 0;
  HashMap<String, Integer> followedBy = new HashMap<String,Integer>();
  ArrayList<String> chooseFrom =new ArrayList<String>();
  
  Word(String s) {
    word = s;
  }
  
  void createChooseFrom() {
    chooseFrom.clear();
    
    for (String s : followedBy.keySet()) {
      int i = followedBy.get(s);
      
      for (int j = 0; j < i; j += 1) {
        chooseFrom.add(s);
      }
    }
  }
  
  String choose() {
    if (chooseFrom.size() == 0) {
      createChooseFrom();
    }
    
    return chooseFrom.get(floor(random(chooseFrom.size())));
  }
  
  
  
  
  String toString() {
    
    String output = "\n" + word + " : ";
    for(String w : followedBy.keySet()) {
      output += "\n\t" + w + " : " + followedBy.get(w);
    }
    
    
    return output;
    
    
  }
  void follow(String s) {
    totalFollows += 1;
    if (followedBy.containsKey(s)) {
      int g = followedBy.get(s)+1;
      g += 1;
      followedBy.put(s, g);
    } else {
      followedBy.put(s, 1);
    }
    
  }
}

Word getWord(String s) {
  if (words.containsKey(s)) {
    return words.get(s);
  } else {
    Word w = new Word(s);
    words.put(s,w);
    return w;
    
  }
}
