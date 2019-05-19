class Die {
  int value;
  PVector pos;
 
  Die(float x, float y) {
    getNewValue();
    pos = new PVector(x,y);
  }
  
  void getNewValue() {
    value = floor(random(1,7));
  }
  
  void draw() {
    fill(0);
    stroke(255);
    rect(pos.x, pos.y, 50,50);
    fill(255);
    text(value, pos.x + 10, pos.y + 20);
  }
}

Die d1,d2,d3;
int score_1, score_2;
int sixes;

void roll() {
  d1.getNewValue();
  d2.getNewValue();
  d3.getNewValue();
  sixes = 0;
  if (d1.value == 6) sixes += 1;
  if (d2.value == 6) sixes += 1;
  if (d3.value == 6) sixes += 1;
  
  if (sixes > 0) {
    score_1 += sixes;
  } else {
    score_2 += 1;
  }
  
}