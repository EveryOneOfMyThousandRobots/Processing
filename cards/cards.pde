Deck deck;

void setup () {
  size(800,500);
  deck = new Deck();
}

void draw() {
  background(0);
  deck.draw();
}