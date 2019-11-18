class Lexer {
  int pos = -1;
  String txt;
  ArrayList<Token> tokens = new ArrayList<Token>();
  String c = null;
  final String DIGITS = "0123456789";
  final String DIGITS_DOT = "0123456789.";
  final String SYMBOL_START = "abcdefghijklmnopqrstuvwxyz_$".toUpperCase();
  final String SYMBOL_CONTENTS = "abcdefghijklmnopqrstuvwxyz_$0123456789".toUpperCase();

  Lexer() {
  }
  Lexer(String txt) {
    this.txt = txt;
    advance();
  }


  void reset(String txt) {
    pos = -1;
    this.txt = txt;
    println("txt.length = " + txt.length());
    advance();
  }

  void advance() {

    pos += 1;

    if (pos > txt.length() -1) {
      c = null;
    } else {
      c = str(txt.charAt(pos));
    }
    //println("pos new value = " + pos + " c = [" + (c == null ? "NULL" : c )) ;
  }

  void tokenise() throws Exception {
    tokens.clear();
    while (c != null) {
      if (c.equals(" ")) {
        advance();
      } else if (isDigit(c)) {
        addToken(getNumberToken());
      } else if (c.equals("+")) {
        addToken(new Token(TT.ADD));
        advance();
      } else if (c.equals("-")) {
        addToken(new Token(TT.SUB));
        advance();
      } else if (c.equals("/")) {
        addToken(new Token(TT.DIV));
        advance();
      } else if (c.equals("*")) {
        addToken(new Token(TT.MLT));
        advance();
      } else if (c.equals("=")) {
        addToken(new Token(TT.EQU));
        advance();
      } else if (c.equals("(")) {
        addToken(new Token(TT.LPN));
        advance();
      } else if (c.equals(")")) {
        addToken(new Token(TT.RPN));
        advance();
      } else if (isSymbolStart(c)) {
        addToken(getSymbolToken());
      } else if (c.equals("\"")) {
        addToken(getStringLiteralToken());
        advance(); //skip closing quotes
      } else {
        throw new Exception("Unrecognised Token type at pos[" + pos + "]");
      }
    }
  }

  Token getStringLiteralToken() {
    String value = "";
    advance();
    while (c != null && !c.equals("\"")) {
      value += c;
      advance();
    }

    return new Token(TT.TXT, value);
  }

  void tokensToString() {
    addText(">>tokens->");

    for (Token token : tokens) {

      addText("    "+ token.toString());
    }
  }

  void addToken(Token token) {
    tokens.add(token);
  }

  Token getSymbolToken() {
    String value = "";


    while (c != null && isSymbolValid(c)) {
      value += c.toUpperCase();
      advance();
    }


    return new Token(TT.SYM, value);
  }

  Token getNumberToken() {

    String value = "";
    int countDots = 0;
    while (c != null && isDigitOrDot(c)) {
      if (c.equals(".")) {
        if (countDots == 1) {
          break;
        } else {
          countDots += 1;
        }
      }
      value += c;
      advance();
    }



    return new Token(TT.NUM, value);
  }

  boolean isSymbolStart(String s) {
    return contains(SYMBOL_START, s);
  }

  boolean isSymbolValid(String s) {
    return contains(SYMBOL_CONTENTS, s);
  }

  boolean isDigit(String s) {
    return contains(DIGITS, s);
  }

  boolean isDigitOrDot(String s) {
    return contains(DIGITS_DOT, s);
  }

  boolean contains(String stringToSearch, String stringToSearchFor) {

    return stringToSearch.toUpperCase().indexOf(stringToSearchFor.toUpperCase(), 0) >= 0;
  }
}
