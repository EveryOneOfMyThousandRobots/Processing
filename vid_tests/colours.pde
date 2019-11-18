final float NUM_COLOURS = 5;
final float COL_FACTOR = 255.0 / NUM_COLOURS;
float rc(float c) {
  float cc = c;
  cc = ceil(cc / COL_FACTOR);
  cc *= COL_FACTOR;
  
  
  return cc;
  
}
