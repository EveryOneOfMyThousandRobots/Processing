final int PAPER_BG = 0xFFF7EAD7;
final int PAPER_BORDER = 0xFFCCC1B3;
PFont font_ibm;


class Stamp {
  PImage img;
}

Document doc;
void setup() {
  size(800,800);
  makeLetterMap();
  noSmooth();
  font_ibm = createFont("Nouveau IBM", 8);
  doc = new Document(width / 4);
  
}


void draw() {
  background(0);
  doc.draw();
  
}
