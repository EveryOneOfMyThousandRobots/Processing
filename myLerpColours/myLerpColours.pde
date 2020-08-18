color LC(color A, color B, float a) {
  

  float AR = red(A);
  float AG = green(A);
  float AB = blue(A);

  float BR = red(B);
  float BG = green(B);
  float BB = blue(B);
  
  float CR = AR + a * (BR - AR);
  float CG = AG + a * (BG - AG);
  float CB = AB + a * (BB - AB);
  

  return color(CR,CG,CB);
  
}

color CA = color(random(255), random(255), random(255));
color CB = color(random(255), random(255), random(255));
void setup() {
  size(400, 100);
  
}

void mouseReleased() {
   CA = color(random(255), random(255), random(255));
   CB = color(random(255), random(255), random(255));
}

void draw() {
  background(0);
  for (int x = 0; x < width; x += 1) {
    float a = (float) x / (float) width;

    stroke(LC(CA, CB, a));
    line(x, 0, x, height);
  }
  stroke(0);
  fill(CA);
  rect(0,0,50,50);
  fill(CB);
  rect(50,0,50,50);
}
