//class Parser {
//  ArrayList<Token> tokens;
//  int tokenIndex = -1;
//  Token currentToken = null;
  
//  boolean finished = false;
  
  
//  Parser(ArrayList<Token> tokens) {
//    this.tokens = tokens;
//  }
  
  
  
//  boolean getNextToken() {
//    tokenIndex += 1;
    
//    if (tokenIndex > tokens.size() - 1) {
//      currentToken = null;
//      finished = true;
//    } else {
//      currentToken = tokens.get(tokenIndex);
//    }
    
//    return finished;
//  }
  
  
//  Token peekNextToken() {
//    int i = tokenIndex + 1;
//    if (i > tokens.size() - 1) {
//      return null;
//    } else {
//      return tokens.get(i);
//    }
//  }
  
//  Node parse() throws Exception {
//    getNextToken();
//    Node node = expr();
//    return node;
//  }
  
//  boolean eat(TT expectedType) throws Exception{
    
//    if (currentToken.type == expectedType) {
//      return !getNextToken();
//    } else {
//      throw new Exception("Syntax Error");
      
//    }
//  }
  
//  Node term() throws Exception{
//    Node node = factor();

//    while (currentToken != null && In(currentToken.type, TT.MLT, TT.DIV)) {
//      Token token = currentToken;
      
//      if (token.type == TT.MLT) {
//        eat(TT.MLT);
//      } else if (token.type == TT.DIV) {
//        eat(TT.DIV);
//      }
      
//      node = makeBinop(node,token,factor());
//    }
    
//    return node;
//  }
//  Node factor() throws Exception{
//    if (currentToken != null) {
//      Token token = currentToken;
//      if (token.type == TT.NUM) {
//        eat(TT.NUM);
//        return makeNumberNode(token);
//      } else if (token.type == TT.LPN) {
        
//        if (eat(TT.LPN)) {
//          Node node = expr();
//          eat(TT.RPN);
//          return node;
//        }
//      }
//    }
//    throw new Exception("syntax error parsing number");
//  }
  
  
//  Node expr() throws Exception{
//    Node node = term();
    
//    if (currentToken != null && In(currentToken.type, TT.ADD, TT.SUB)) {
//      Token token = currentToken;
//      if (token.type == TT.ADD) {
//        eat(TT.ADD);
//      } else if (token.type == TT.SUB) {
//        eat(TT.SUB);
//      }
//      node = makeBinop(node,token,term());
//    }
    
//    return node;
//  }
  
//}


boolean In(TT t, TT... list) {
  for (int i = 0; i < list.length; i += 1) {
    if (t == list[i]) {
      return true;
    }
  }
  return false;
}
