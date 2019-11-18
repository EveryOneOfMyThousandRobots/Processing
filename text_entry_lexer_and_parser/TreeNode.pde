class Node {
  Node left = null;
  Token op = null;
  Node right = null;
  Token token = null;
  String value = "ERROR";
  float floatVal = -1;
  NT type = NT.EMPTY;

  String toString() {
    switch (type) {
    case EMPTY:
      return "EMPTY";

    case BASE:
      return "BASE";
    case BINOP:
      return "(" + left.toString() + ") " + op.toString() + " (" + right.toString() + ")";
    case SYMBOL:
      return "SYMBOL(" + value + ")";
    case NUMBER:

      return "NUMBER(" + floatVal +")";
    }


    return "NOTHING!!";
  }
}

enum NT {
  EMPTY, 
    BASE, 
    BINOP, 
    NUMBER, 
    SYMBOL
}

Node makeEmptyNode() {
  return new Node();
}

Node makeBinop (Node left, Token op, Node right) {
  Node node = makeEmptyNode();
  node.left = left;
  node.op = op;
  node.right = right;
  node.type = NT.BINOP;
  return node;
}

Node makeNumberNode(Token token) {
  Node node = makeEmptyNode();
  node.value = token.value;
  node.floatVal = Float.valueOf(token.value);
  node.type = NT.NUMBER;
  return node;
}
