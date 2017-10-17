class Chr {
  int val;
  boolean done = false;

  boolean inc() {
    if (val + 1 > 128) {
      val = 32;
      done = true;
    } else {
      val += 1;
      done = false;
    }
    return done;
  }

  Chr() {
    val = 32;
  }

  String toString() {
    return str(char(val));
  }
}

class Chrs {
  int guessIdx = 0;
  ArrayList<String> guesses = new ArrayList<String>();
  ArrayList<Chr> chars = new ArrayList<Chr>();
  int index;
  Chrs() {
    for (int i = 0; i < 8; i += 1) {
      chars.add(new Chr());
    }
  }

  void display() {
    for (int y = 0; y < guesses.size(); y += 1) {
      int pos = 10 + (y * 11);
      text(guesses.get(y), 10, pos); 
    }
  }

  String toString() {
    String returnVal= "";
    for (int i = chars.size()-1; i >= 0; i -= 1) {
      Chr c = chars.get(i);
      returnVal += c.toString();
    }
    return trim(returnVal);
  }

  void update() {
    index = 0;
    while (true) {
      if (index >= chars.size()) break;

      Chr c = chars.get(index);
      if (c.inc()) {
        index += 1;
      } else {
        break;
      }
    }
    if (guesses.size() > 20 && guessIdx > 18) {
      guessIdx = 0;
    }
    
    if (guesses.size() -1 < guessIdx) {
      
      guesses.add( this.toString());
      guessIdx += 1;
    } else {
      guesses.set(guessIdx, this.toString());
      guessIdx += 1;
    }
  }
}

Chrs chrs;
void setup() {
  size(400, 400);
  chrs = new Chrs();
  frameRate(500);
}

void draw() {
  
  chrs.update();
  if (frameCount % 100 == 0) {
    background(0);
    chrs.display();
  }
}