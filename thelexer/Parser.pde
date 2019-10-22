
class Parser {
  Node node;
  
}

enum NODE_TYPE {
  LEFT_OPERAND,
  RIGHT_OPERAND,
  OPERATOR,
  
}

class Node {
  NODE_TYPE type;
  Token token;
  ArrayList<Node> nodes = new ArrayList<Node>();
  
  Node(NODE_TYPE type) {
    this.type = type;
  }
  
  
}




//class Parser {
//  ArrayList<Token> tokens;
//  Token currentToken;
//  int tokenIndex;
//  Parser(ArrayList<Token> tokens) {
//    this.tokens = tokens;
//    tokenIndex = -1;
//    advance();
    
//  }

//  Token advance() {
//    tokenIndex += 1;
//    if (tokenIndex <= tokens.size()-1) {
//      currentToken = tokens.get(tokenIndex);
//      return currentToken;
//    }

//    return null;
//  }

//  NumberNode factor() {
//    Token token = currentToken;

//    if (token.type == TYPES.INT || token.type == TYPES.FLOAT) {
//      advance();
//      return new NumberNode(token);
//    }

//    return null;
//  }


//  BinaryOpNode term() {
//    BinaryOpNode bop = null;
//    NumberNode left = factor();

//    Token op = null;
//    NumberNode right = null;
//    while (currentToken.type == TYPES.MULT || currentToken.type == TYPES.DIV) {
//      op = currentToken;
//      advance();
//      right = factor();
//      bop = new BinaryOpNode(left, op, right);
//    }

//    return bop;
//  }


//  BinaryOpNode expr() {
//    BinaryOpNode bop = null;
//    NumberNode left = factor();

//    Token op = null;
//    NumberNode right = null;
//    while (currentToken.type == TYPES.PLUS || currentToken.type == TYPES.SUB) {
//      op = currentToken;
//      advance();
//      right = factor();
//      bop = new BinaryOpNode(left, op, right);
//    }

//    return bop;
//  }


//  BinaryOpNode parse() {
//    BinaryOpNode res = expr();




//    return res;
//  }
//}
