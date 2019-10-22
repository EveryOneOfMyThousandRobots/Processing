abstract class TreeNode {
  TreeNode node;
  Token token;
  String toString() {
    return "TN("+token.toString() + ")";
  }
}

class NumberNode extends TreeNode {
  NumberNode (Token token) {
    this.token = token;
  }
  
  String toString() {
    return "NN(" + token.toString() + ")";
  }
}
abstract class OperatorNode extends TreeNode {
  Token operatorToken;
}
class BinaryOpNode extends OperatorNode {
  TreeNode left, right;
  
  BinaryOpNode(TreeNode left, Token op, TreeNode right) {
    this.left = left;
    this.operatorToken = op;
    this.right = right;
  }
  
  String toString() {
    String l = left.toString();
    String o = operatorToken.toString();
    String r = right.toString();
    return "BN([" + l + "] [" + o + "] [" + r + "])";
  }
}

class UnaryOpNode extends OperatorNode {
  UnaryOpNode(Token op, TreeNode node) {
    this.node = node;
    this.operatorToken = op;
  }
  
}
