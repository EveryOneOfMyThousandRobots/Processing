float boxmuller(float high, float low) {
  float answer = 0;
  
  float U = random(0,1), V = random(0,1);
  
  answer = sqrt(-2 * log(U)) * cos(TWO_PI * V);
  
  answer = map(answer, -5, 5, high, low);
  
  return answer;
}