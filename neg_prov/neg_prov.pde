final float MILLION = pow(10,6);
final float BILLION = pow(10,9);
final float TWO_BILLION = BILLION * 2.0;

String roundMe(float n) {
  String output = "";
  boolean negative = n < 0;
  float x = abs(n);
  
  
  if (x >= 1000 && x < MILLION) {
    
    output = formatMe(x, 1000, "K");
    
  } else if (x >= MILLION  && x < BILLION) {
    output = formatMe(x, MILLION, "M");
    
  } else if (x >= BILLION ) {
    output = formatMe(x, BILLION, "B");
    
  }
  else {
    output = str(x);  
  }
  
  if (negative) {
    output = '-' + output;
  }
  
  
  return output;
}

String formatMe(float x, float divisor, String suffix) {
  x = x / divisor;
  float dec = round((x % 1) * 10);
  return int(x) + "." + int(dec) + suffix;
}


void setup() {
  size(400,400);
  frameRate(1);
}

void draw() {
  background(0);
  float n = floor(random(-TWO_BILLION, TWO_BILLION));
  
  println(int(n) + " = " + roundMe(n));
}
