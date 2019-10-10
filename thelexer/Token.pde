enum TYPES {
    INT, 
    FLOAT, 
    PLUS, 
    SUB, 
    MULT, 
    DIV, 
    LPAREN, 
    RPAREN,
    STRING,
    EOF
}

class Token {
  final TYPES type;
  final String value;
  
  Token (TYPES type, String value) {
    this.type = type;
    this.value = value;
  }
  
  Token(TYPES type) {
    this.type = type;
    this.value = null;
  }
  
  String toString() {
    if (value == null) {
      return type.toString();
    } else {
      return type.toString() + ":" + value;
    }
  }
}
