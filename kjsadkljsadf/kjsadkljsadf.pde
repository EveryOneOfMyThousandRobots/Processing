void setup() {
  noLoop();
  println(getId(110));
  println(getId(11));
}

void draw() {
}

String getId(int i) {
  String ii = ""+i;
  int sumA = 1;
  int sumB = 0;
  
  for (int j = 0; j < ii.length(); j += 1) {
    sumA +=  int(ii.charAt(j));
    int pb = 0;
    for (int k = 0; k < j; k += 1) {
      pb +=  int(ii.charAt(k));
    }
    sumB += ( 1 + pb);
    
  }
  
  
  return ii = sumA + " " + sumB;
}