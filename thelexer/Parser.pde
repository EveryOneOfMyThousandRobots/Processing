




class Parser {
  ArrayList<Token> tokens;
  Token currentToken;
  int tokenIndex = -1;
  Parser(ArrayList<Token> tokens) {
    this.tokens = tokens;
    
  }
  
  void advance() {
    tokenIndex += 1;
    if (tokenIndex <= tokens.size()-1) {
      currentToken = tokens.get(tokenIndex);
    }
  }
  
  
  ParseResult parse() {
    ParseResult res = expr();
    
    if (!res.error
    
    
    return res;
    
  }
  
  BinaryOpNode
}
