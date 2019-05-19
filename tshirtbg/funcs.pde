float gs(float x, float min, float max) {
  return map(getSigmoid(map(x,0,1,-6,6)), 0, 1, min, max);
  
}
float gs(float x) {
  return getSigmoid(map(x,0,1,-6,6));
}
float getSigmoid(float x) {
  return 1.0 / (1.0 + exp(-x));
}
