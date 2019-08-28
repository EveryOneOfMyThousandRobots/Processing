void setup() {
  noLoop();
  
  println(GCD(11,22));
}


void draw() {
}


int a(int n) {
  int answer = 0;

  if (n == 0 || n == 1) return 1;




  return answer;
}

int GCD(int a, int b) {
  int gcd = 0;
  int D = 0, R = 1;
  
  int A = max(a,b);
  int B = min(a,b);
  gcd = A%B;
  do { 
    
    D = int(A/B);
    R = A%B;
    if (R != 0) {
      gcd = R;
    } else {
      break;
    }
    
    A = B;
    B = R;
  } while (R > 0);
  
  
  
  return gcd;
}
