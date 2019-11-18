ArrayList<String> lines = new ArrayList<String>();
String currentLine = ">";
void addLine() {
  if (currentLine.length() > 1) {
    lines.add(currentLine);
  } else {
    lines.add(">");
  }
  resetCurrent();
}

void addText(String s) {
  lines.add(s);
  resetCurrent();
}

void resetCurrent() {
  currentLine = ">";
}
final int FONT_SIZE = 16;
final int FONT_STEP_VERT = 12;
PFont font;
color textColour = color(20,200,50);
void setup() {
  size(600, 600);
  surface.setLocation(-900, 0);
  font = createFont("Nouveau IBM", FONT_SIZE);
  
  textFont(font);
  noSmooth();
}


void draw() {
  background(51);
  int x = 5;
  int y = FONT_STEP_VERT;
  fill(textColour);
  for (String line : lines) {
    text(line, x, y);
    y += FONT_STEP_VERT;
  }
  text(currentLine, x, y);
}
Lexer lexer = new Lexer();
void lexCurrentLine() {
  if (currentLine.length() > 1) {
    String cl = currentLine; //String.copyValueOf(currentLine.toCharArray());
    //println("before " + cl);
    addLine();
    //println("after " + cl);
    lexer.reset(cl.substring(1,cl.length()));
    try {
      lexer.tokenise();
      lexer.tokensToString();
      
      Parser parser = new Parser(lexer.tokens);
      Node n = parser.parse();
      addText(n.toString());
      
    } catch (Exception e) {
      addText("error: " + e.getMessage());
    }
    
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == ENTER) {
      addLine();
    }
  } else {
    if (keyCode == BACKSPACE) {
      if (currentLine.length() > 1) {
        currentLine = currentLine.substring(0,currentLine.length()-1);
      }
    } else if (keyCode == ENTER) {
      lexCurrentLine();
    } else {
      currentLine += str(key);
    }
  }
}
