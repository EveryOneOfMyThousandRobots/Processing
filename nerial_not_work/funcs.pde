float sig(float n) {
  return 1 / (1 + exp(-n));
}

float td(float out) {
  return out * (1 - out);
}

float rectify(float n) {
  return max(0,n);
}
