OpenSimplexNoise sNoiseA, sNoiseB;

final float range = 0.5 * (sqrt(2));
void setup() {
  size(400,400);
  sNoiseA = new OpenSimplexNoise();
  sNoiseB = new OpenSimplexNoise();
  background(0);
}

void draw() {
  stroke(255);
  
  float xxa = random(1);
  float yya = random(1);
  float xxb = random(1);
  float yyb = random(1);
  float x, y;
  for (int i = 0; i < 10; i += 1) {
    
    x = map((float)sNoiseA.eval((float)(i) * xxa, i * yya), -range, range, 0, width);
    
    
    y = map((float)sNoiseB.eval((float)(i) * xxb, i * yyb), -range, range, 0, height);
    println(x + "," + y);
    point(x,y);
  }
  
}
