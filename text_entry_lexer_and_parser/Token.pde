class Token {
  final TT type;
  final String value;
  
  Token (TT type, String value) {
    this.type = type;
    this.value = value;
    
  }
  
  Token (TT type) {
    this.type = type;
    this.value = null;
    
  }
  
  String toString() {
    if (value == null) {
      return "[" + type.toString() + "]";
    } else {
      return "[" + type.toString() + "]=[" + value + "]";
    }
  }
  
  
}

enum TT {
  ADD,
  SUB,
  MLT,
  DIV,
  TXT,
  NUM,
  SYM,
  EQU,
  LPN,
  RPN
}
