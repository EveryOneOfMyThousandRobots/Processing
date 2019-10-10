class Position {
  int idx, line, col;
  String fileName, text;
  Position(int idx, int line, int col, String fileName, String text) {
    this.idx = idx;
    this.line = line;
    this.col = col;
    this.fileName = fileName;
    this.text= text;
  }
  
  void advance(char c) {
    idx += 1;
    col += 1;
    if (c == '\n') {
      line += 1;
      col = 0;
    }
  }
  
  Position copy() {
    return new Position(this.idx, this.line, this.col, this.fileName, this.text);
  }
  
  String toString() {
    return "position(" + line + ":" + col + ":" + idx + ")";
  }
}
