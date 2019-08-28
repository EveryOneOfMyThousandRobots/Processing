int NUM_ITERATIONS = 50;
int NUM_SWIPES = 20;
int SWIPE_LENGTH = 100;
int SWIPE_WIDTH = 10;
final int CHUNK_HEIGHT = 20; 

boolean go() {
  return random(1) < 0.01;
}

int idx(int x, int y, int w) {
  return x + y * w;
}

int getRandomChoice() {
  return floor(random(3));
}

int cAvg(int a, int b) {
  return (a + b) / 2;
}

int cAvg2(int a, int b) {
  return (int)constrain(sqrt((a*a) + (b*b)), 0, 255);
}

int rr(color c) {
  return (c >> 16) & 255;
}

int gg(color c) {
  return (c >> 8) & 255;
}

int bb(color c) {
  return c & 255;
}

int roughAvg(int a, int b) {
  float r = sqrt(a * b);

  return floor(constrain(r, 0, 255));
}

color getC(int choice, int thisColour, int nextColour) {
  color c = color(thisColour);
  if (choice == 0) {
    c = color(rr(nextColour), gg(thisColour), bb(thisColour));
  } else if (choice == 1) {
    c = color(rr(thisColour), gg(nextColour), bb(thisColour));
  } else if (choice == 2) {
    c = color(rr(thisColour), gg(thisColour), bb(nextColour));
  } else {
    c = color(rr(nextColour), gg(nextColour), bb(nextColour));
  }

  return c;
}

color getCAvg(int choice, int thisColour, int nextColour, float cf) {

  int nr = (int) (float(rr(nextColour)) * cf) ;
  int ng = (int) (float(gg(nextColour)) * cf) ;
  int nb = (int) (float(bb(nextColour)) * cf) ;

  int tr = rr(thisColour);
  int tg = gg(thisColour);
  int tb = bb(thisColour);

  color c = color(thisColour);
  if (choice == 0) {
    c = color(cAvg2(tr, nr), tg, tb);
  } else if (choice == 1) {
    c = color(tr, cAvg2(tg, ng), tb);
  } else if (choice == 2) {
    c = color(tr, tg, cAvg2(tb, nb));
  } else {
    c = color(cAvg2(tr, nr), cAvg2(tg, ng), cAvg2(tb, nb));
  }

  return c;
}
