void setup() {
  size(600,600);
  frameRate(10000);
  background(0);
}

final int RANGE_LOW = 1;
final int RANGE_HIGH = 10000;
int m = RANGE_LOW;
float len = 5;
final float angle = PI / 32;
void draw() {
  resetMatrix();
  stroke(255,64);
  //strokeWeight(2);
  int n = m;
  
  translate(0, height / 2);
  IntList seq = new IntList();
  do {
    seq.append(n);
    n = collatz(n);
    //steps += 1;

  } while (n != 1);
  
  seq.reverse();
  for (int i : seq) {
    if (i % 2 == 0) {
      rotate(-angle);
    } else {
      rotate(angle);
    }
    line(0,0,len,0);
    translate(len, 0);
    
    
    
  }
  
  
  //println(m + " = " + steps);
  m += 1;
  
  if (m >= RANGE_HIGH) {
    stop();
  }
}


int collatz(int n) {
  if (n % 2 == 0) {
    return n / 2;
  } else {
    return ((n * 3) + 1)/2;
  }
}
