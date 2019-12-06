class Token {
  final String type, value;
  
  Token (String type, String value) {
    this.type = type;
    this.value = value;
    
  }
  Token(String type) {
    this.type = type;
    this.value = null;    
  }
  
  String toString() {
    if (value == null) {
      return "[" + type + "]";
    } else {
      return "[" + type + "(" + value + ")]";
    }
  }
}
