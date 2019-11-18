
String numeric = "0123456789";
String numeric_plsu = "0123456789.";
String alpha = "abcdefghijklmnopqrstuvwxyz";
class Token {
  final String type;
  final String value;
  Token (String type, String value) {
    this.type = type;
    this.value = value;
  }
  Token (String type) {
    this.type = type;
    this.value = null;
  }
  
}
class Lexer {
  ArrayList<Token> tokens; 
  int index = -1;
  String data;
  String current = "";
  Lexer(String data) {
    this.data = data;
    advance();
  }
  
  
  
  void makeTokens() {
    tokens = new ArrayList<Token>();
    while (current != null) {
      if (current.equals(" ") || current.equals("\t")) {
        advance();
      }
      
      
    }
  }
  
  void advance() {
    index += 1;
    if (index > data.length()-1) {
      current = null;
    } else {
      current = str(data.charAt(index));
    }
  }
  
  
}




String data = "1 + 12";

void setup() {
}


void draw() {
}
