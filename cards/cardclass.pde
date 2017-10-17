enum COLOUR {
  RED, BLACK;
}

enum SUIT {
  DIAMONDS("Diamonds", COLOUR.RED), 
  CLUBS("Clubs", COLOUR.BLACK), 
  SPADES("Spades", COLOUR.BLACK), 
  HEARTS("Hearts", COLOUR.RED);

  String name;
  COLOUR colour;

  SUIT(String name, COLOUR colour) {
    this.name = name;
    this.colour = colour;
  }


}

enum VALUE {
  ACE(1, "Ace"), TWO(2, "Two"), 
    THREE(3, "Three"), FOUR(4, "Four"), 
    FIVE(5, "Five"), SIX(6, "Six"), 
    SEVEN(7, "Seven"), EIGHT(8, "Eight"), 
    NINE(9, "Nine"), TEN(10, "Ten"), 
    JACK(11, "Jack"), QUEEN(12, "Queen"), 
    KING(13, "King");

  int value;
  String name;

  VALUE(int value) {
    this.value = value;
    name = "" + value;
  }

  VALUE(int value, String name) {
    this.value = value;
    this.name = name;
  }
}


//final int SUIT_LOWEST = 0;
//final int SUIT_CLUBS = 0;
//final int SUIT_SPADES = 1;
//final int SUIT_HEARTS = 2;
//final int SUIT_DIAMONDS = 3;
//final int SUIT_HIGHEST = 3;

//final int VALUE_ACE = 1;
//final int VALUE_JACK = 11;
//final int VALUE_QUEEN = 12;
//final int VALUE_KING = 13;

final int CARD_HEIGHT = 110;
final int CARD_WIDTH = 80;


class Card {
  VALUE value;
  SUIT suit;
  PVector pos;

  Card (VALUE value, SUIT suit, float x, float y) {
    this.value = value;
    this.suit = suit;
    pos = new PVector(x, y);
  }

  void draw() {
    stroke(0);
    fill(255);
    rect(pos.x, pos.y, CARD_WIDTH, CARD_HEIGHT);
    if (suit.colour == COLOUR.RED) {
      stroke(255, 0, 0);
      fill(255, 0, 0);
    } else {
      stroke(0);

      fill(0);
    }
    text(value.name, pos.x + 10, pos.y + 10);
    text(suit.name, pos.x + 10, pos.y + 40);
  }



   
  
}