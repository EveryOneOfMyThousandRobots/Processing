class Num {
  int num = 0;
  boolean done = false;

  Num () {
    reset();
  }

  void inc() {
    if (num + 1 > 128) {
      done = true;
    } else {
      num += 1;
    }
  }

  void reset() {
    num = 33;
    done = false;
  }
}

ArrayList<Num> chars = new ArrayList<Num>();

int i = 0;

void setup() {
  chars.add(new Num());
  size(400, 400);
  //frameRate(5);
}

void draw() {
  background(0);

  if (i >= chars.size()) {
    i = 0;
    return;
  }
  Num n = chars.get(i);
  n.inc();
  if (n.done && i == chars.size() - 1) {
    n.reset();
    chars.add(new Num());
  } else if (n.done) {
    i += 1;
  }
  printStuff();
}

void printStuff() {
  String printMe = "";
  for (int j = chars.size()-1; j >= 0; j -= 1) {
    Num n = chars.get(j);
    printMe += str(char(n.num));
  }
  text(chars.size() + " " + i + " " + printMe, width / 2, height / 2);
}