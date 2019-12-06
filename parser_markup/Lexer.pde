class Lexer {
  ArrayList<Token> tokens;
  String data = null;
  String current = null;
  int index = -1;
  Lexer(String data) {
    this.data = data;
    advance();
  }
  
  void tokenise() throws Exception{
    tokens = new ArrayList<Token>();
    
    while (current != null) {
      
      if (current.equals("<")) { // tag
        addToken(getTagToken());
      } else {
        addToken(getTagContent());
      }
      //advance();
    }
  }
  
  Token getTagContent() {
    String value = "";
    
    while (current != null && !current.equals("<")) {
      println(current);
      value += current;
      advance();
    }
    
    return new Token("content", value);
  }
  
  void addToken(Token token) {
    tokens.add(token);
  }
  
  Token getTagToken() {
    
    String value = "";
    advance();
    while (current != null && !current.equals(">") && !current.equals("\"")) {
      value += current;
      advance();
    }
    advance();
    
    
    
    return new Token("tag", value);
  }
  
  void advance() {
    index += 1;
    if (index > data.length()-1) {
      current = null;
    } else {
      current = str(data.charAt(index));
    }
  }
}
