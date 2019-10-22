
final char CHAR_NONE = (char)-1;
boolean isDigit(char c) {
  return DIGITS.indexOf(str(c)) >= 0;
}

boolean isDigitOrDot(char c) {
  return DIGITS_DOT.indexOf(str(c)) >= 0;
}
final String ALLOWED_KEYS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .:=;/*-+_()<>{}[]@~'\"";

boolean isKeyAllowed(char c) {
  //println(ALLOWED_KEYS.indexOf(str(c).toUpperCase()));
  return ALLOWED_KEYS.indexOf(str(c).toUpperCase()) >= 0;
}
final String DIGITS = "0123456789";
final String DIGITS_DOT = DIGITS + ".";
PFont font;
ArrayList<String> lines = new ArrayList<String>();
String currentLine = ">";
int cursorPos = 1;
float cursorTimer = 0;
boolean cursorOn = false;
float time_last = millis();
float time_now = 0;
float time_delta = 0;
float char_width;



void setup() {
  size(800, 600);
  font = createFont("Consolas", 12);
  textFont(font);
  char_width = textWidth('W');
}





void draw() {
  time_now = millis();
  time_delta = time_now - time_last;
  time_last = time_now;

  cursorTimer += time_delta;
  if (cursorTimer > 500) {
    cursorTimer = 0;
    cursorOn = !cursorOn;
  }
  background(0);
  int x = 3;
  int y = 12;
  for (int i = 0; i < lines.size(); i += 1) {
    text(lines.get(i), x, y);
    y += 12;
  }
  text(currentLine, x, y);
  if (cursorOn) {
    fill(255);
    noStroke();
    float xx = 2 + cursorPos * char_width;
    y -= 12;

    rect(xx, y, char_width, 12);
  }
}

void keyReleased() {
  println("[" + keyCode + ":" + str(key) + ":" + (key==CODED) + "]");
  //if (key == CODED) {
  //  return;
  //}

  switch (key) {
  case BACKSPACE:
    if (currentLine.length() > 1) {
      currentLine = currentLine.substring(0, currentLine.length()-1);

      cursorPos -= 1;
    }
    break;
  case ENTER:
    if (currentLine.toUpperCase().equals(">CLS")) {
      lines.clear();
    } else {
      run();
    }
    cursorPos = 1;
    currentLine = ">";
    break;
    //case SHIFT:
    //case ALT:
    //case CONTROL:
    //case UP:
    //case DOWN:
    //case LEFT:
    //case RIGHT:
    //  break;

  default:
    if (isKeyAllowed(key)) {
      currentLine += str(key);
      cursorPos += 1;
    }
  }
}

void run() {
  lines.add(currentLine);
  if (currentLine.length() > 1) {
    String cl = currentLine.substring(1, currentLine.length());
    Lexer lexer = new Lexer("dummy", cl);

    ArrayList<Token> tokens = lexer.makeTokens();
    if (tokens != null) {
      for (Token token : tokens) {
        lines.add(token.toString());
      }
      Parser parser = new Parser(tokens);
      lines.add(parser.parse().toString());
    } else if (lexer.error != null) {
      lines.add(lexer.errorString());
    }
  }
}
