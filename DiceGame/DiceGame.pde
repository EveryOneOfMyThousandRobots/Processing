void setup() {
  size(400,400);
  d1 = new Die(width / 4, height / 2);
  d2 = new Die(width / 2, height / 2);
  d3 = new Die(width * 0.75, height / 2);
  
  
  
  
}

int diff  = 0;
void draw() {
  background(0);
  roll();
  d1.draw();
  d2.draw();
  d3.draw();
  fill(255);
  text("gambler:" + score_1, 20, height * 0.75);
  text("house:" + score_2, (width / 2) + 20, height * 0.75);
  text("diff: " + (diff), 20, height * 0.9);
  
  if (frameCount % 100 == 0) {
    diff = score_1 - score_2;
  }
  
}