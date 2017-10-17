float sigmoid(float x) {
  return 1.0 / (1.0 + exp(-x));
}

float dSigmoid(float y) {
  return y * ( 1 - y);
}