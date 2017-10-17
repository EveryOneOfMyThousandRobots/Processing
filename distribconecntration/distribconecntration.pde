float boxmuller(float high, float low) {
  float answer = 0;
  float U = random(-1, 1), V = random(-1, 1);
  float S = (U * U) + (V * V);
  
  
  while (S >= 1) {
    U = random(-1, 1);
    V = random(-1, 1);
    S = (U * U) + (V * V);
  }





  //answer = sqrt(-2 * log(U)) * cos(TWO_PI
  answer = U * sqrt((-2 * log(S)) / S);

  answer = map(answer, -TWO_PI, TWO_PI, high, low);

  return answer;
}

int[] numbs = new int[100];
void setup() {

  size(200, 1000);
}

void draw() {
  background(0);
  for (int i = 0; i < 10000; i += 1) {
    int x = (int)boxmuller(0, 100);
    if (x >= 0 && x < numbs.length - 1) {
      numbs[x] += 1;
    }
  }

  for (int i = 0; i < numbs.length; i += 1) {
    text(i + "    " + numbs[i], 10, 10 + (10 * i));
  }
}