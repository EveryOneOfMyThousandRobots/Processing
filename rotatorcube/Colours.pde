final float NUM_COLOURS = 8;
final float COL_FACTOR = 255.0 / NUM_COLOURS;
float[][] m = {
  {0,8,2,10},
  {12,4,14,6},
  {3,11,1,9},
  {15,7,13,5}
};
float[][] ma;
final int SIZE = 4;
//float[][] m = new float[SIZE][SIZE]; 


float rc(float c) {
  float cc = c;
  cc = ceil(cc / COL_FACTOR);
  cc *= COL_FACTOR;
  
  
  return cc;
  
}
