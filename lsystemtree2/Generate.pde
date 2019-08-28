void generate() {
  len *= 0.5;
  String newSentence = "";
  for (int i = 0; i < sentence.length(); i += 1) {
    String curr = str(sentence.charAt(i));
    String addMe = "";//curr;
    for (int j = 0; j < rules.size(); j += 1) {
      addMe = rules.get(j).eval(curr);
      if (addMe == null) {
        addMe = curr;
        
      } else {
        break;
      }
    }
    newSentence += addMe;
  }
  sentence = newSentence;
}
