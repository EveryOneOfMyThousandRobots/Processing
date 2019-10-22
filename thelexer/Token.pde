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
  Position start, end;

  Token (TYPES type, String value, Position start, Position end) {
    this.type = type;
    this.value = value;
    this.start = start;
    this.end = end;
  }

  Token (TYPES type, String value) {
    this.type = type;
    this.value = value;
    this.start = null;
    this.end = null;
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
