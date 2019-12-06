
String markup = "<hello>hi</hello>";

Lexer lexer;

void setup () {
  size(400, 400);
  lexer = new Lexer(markup);
  try {
    lexer.tokenise();
    println("[markup]:[" + markup +"]");
    for (Token token : lexer.tokens) {
      println(token);
    }
  } 
  catch (Exception e) {
    println(e.getMessage());
  }
}


void draw() {
}
