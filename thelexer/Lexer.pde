

class Lexer {
  Error error = null;
  String text;
  Position pos = null; 
  String fileName;
  
  
  char currentChar = CHAR_NONE;
  Lexer(String fileName, String text) {
    this.fileName = fileName;
    this.text= text;
    pos = new Position(-1,0,-1, fileName, text);
    
    advance();
  }
  
  String errorString() {
    if (error == null) {
      return "none";
    } else {
      return error.toString();
    }
    //return //errorName + ": " + errorDetails + " start: " + errorStart.toString() + "->" + errorEnd.toString();
  }
  
  
  
  void advance() {
    pos.advance(currentChar);
    if (pos.idx > text.length()-1) {
      currentChar = CHAR_NONE;
    } else {
      currentChar = text.charAt(pos.idx);
    }
    
  }
  
  void setError(String name, String details, Position start, Position end) {
    error = new Error(name,details, start, end);

    
  }
  
  ArrayList<Token> makeTokens() {
    ArrayList<Token> tokens = new ArrayList<Token>();
    
    while(currentChar != CHAR_NONE) {
      if (currentChar == ' ' || currentChar == '\t') {
        advance();
      } else if (currentChar == '"') {
        tokens.add(makeStringLiteral());
      } else if (currentChar == '+') {
        tokens.add(new Token(TYPES.PLUS));
        advance();
      } else if (currentChar == '-') {
        tokens.add(new Token(TYPES.SUB));
        advance();
      } else if (currentChar == '/') {
        tokens.add(new Token(TYPES.DIV));
        advance();
      } else if (currentChar == '*') {
        tokens.add(new Token(TYPES.MULT));
        advance();
      } else if (currentChar == '(') {
        tokens.add(new Token(TYPES.LPAREN));
        advance();
      } else if (currentChar == ')') {
        tokens.add(new Token(TYPES.RPAREN));
        advance();
      } else if (isDigit(currentChar)) {
        tokens.add(makeNumber());
        
      } else {
        Position start = pos.copy();
        char c = currentChar;
        advance();
        setError("illegal character", "encountered: '" + str(c) + "'", start, pos.copy());
        return null;
      }
    }
    
    
    return tokens;
    
  }
  
  Token makeStringLiteral() {
    String s = "";
    advance();
    while (currentChar != CHAR_NONE && currentChar != '"') {
      s += str(currentChar);
      advance();
    }
    
    advance();
 
    return new Token(TYPES.STRING, s);
  }
  
  Token makeNumber() {
    String num = "";
    int dots = 0;
    
    while (currentChar != CHAR_NONE && isDigitOrDot(currentChar)) {
      //println("make Number : " + currentChar + " " + isDigitOrDot(currentChar));
      if (currentChar == '.'){
        if (dots == 1) break;
        dots += 1;
        num += ".";
      } else {
        num += str(currentChar);
        
      }
      advance();
      println("make Number after advance: " + currentChar + " " + isDigitOrDot(currentChar));
    }
    
    if (dots == 0) {
      //int
      return new Token(TYPES.INT, num);
    } else {
      //float
      return new Token(TYPES.FLOAT, num);
    }
    
    
  }
}
