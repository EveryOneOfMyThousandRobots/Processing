

class Rule {
  String from, to; 

    Rule(String from, String to) {
    this.from = from; 
      this.to = to;
  }

  String eval(String s) {
    if (s.equals(from)) {
      return to;
    }
    return null;
  }
}
