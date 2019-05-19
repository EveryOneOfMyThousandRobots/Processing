String toGuess = "Hammer";
int startAt = 48;
int finishAt = 122;

String currentGuess = "";
ArrayList<Integer> chars = new ArrayList<Integer>();
PFont m;
void setup() {
  size(400, 400);
  for (int i = 0; i < 6; i += 1) {
    chars.add(startAt);
  }
  frameRate(10000);
  m = createFont("StencilStd", 20);
  textFont(m);
  background(0);
  //noLoop();
}

boolean first = true;
int iterations = 0;
void draw() {
  //background(0);
  for (int i = 0; i < 10000; i += 1) {
    iterations += 1;
    inc();
    currentGuess = "";
    for (int j = 0; j < chars.size(); j += 1) {
      currentGuess += str(char(chars.get(j)));
    }
    if (currentGuess.equals(toGuess)) {
      noLoop();
      println("found");
      first = true;
      break;
    }
  }

  if (first || frameCount % 1000 == 0) {
    first = false;
    background(0);
    fill(255);

    text("\"" + currentGuess + "\"", 10, 20);
    text(chars.size(), 10, 40);
    text(toGuess, 10, 60);
    text("frame:" + frameCount, 10, 80);
    text("iterations:" + iterations, 10,100);
  }
}

void inc() {
  int start = chars.size()-1;
  for (int i = start; i >= 0; i -= 1) {
    int k = chars.get(i);
    if (k == finishAt) {
      k = startAt;
      chars.set(i, k);
      if (i == 0) {
        chars.add(startAt);
        break;
      }
    } else {
      k += 1;
      chars.set(i, k);
      break;
    }
  }
}