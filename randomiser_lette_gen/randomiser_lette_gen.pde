String A = "A";

int charIndex = -1;

void setup() {
}

void draw() {
  background(0);
  text(A, 10, 10);

  int idx = A.length()-1;
  while (true) {
    if (idx < 0) {
      break;
    }
    char c = A.charAt(idx);
    idx -= 1;
    
    

    if (c == 'Z') {
      if (A.length() > 1) {
        A = A.substring(0,A.length()-1) + "A";
        
        
      } else {
        A = "AA";
      }
    } else {
      char a = A.charAt(idx);
      a += 1;
      if (a == 'Z') {
        
      }
    }
  }
}
