class Deck {
  ArrayList<Card> cards = new ArrayList<Card>();
  
  Deck() {
    float x = 10;
    float y = 10;
    for (int suit = SUIT_LOWEST; suit <= SUIT_HIGHEST; suit += 1) {
      for (int value = 1; value <= 13; value += 1) {
        Card card = new Card(value, suit, x + (value * (CARD_WIDTH * 0.9)), y + (CARD_HEIGHT * suit));
        cards.add(card);
      }
    }
  }
  
  void draw() {
    for (Card card : cards) {
      card.draw();
    }
  }
}