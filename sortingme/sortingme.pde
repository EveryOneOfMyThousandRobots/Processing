

int[] sortMe(int[] a) {


  if (a.length < 10) {
    boolean allDone = false;
    while (!allDone) {
      //check
      allDone = true;
      for (int i = 0; i < a.length - 1; i += 1) {
        int iv = a[i];
        int iv2 = a[i + 1];

        if (iv2 < iv) {
          allDone = false;
          break;
        }
      }

      if (!allDone) {
        int i =0;
        while (true) {
          if (i == a.length - 1) break;
          int iv = a[i];
          int iv2 = a[i+1];
          if (iv > iv2) {

            a[i + 1] = iv;
            a[i] = iv2;
          }
          i += 1;
        }
      }
    }
  } else {
    int p = (int) (a.length / 2);
    int pv = a[p];
    int[] left = {};
    int[] newLeft = {};
    int[] right = {};
    int[] newRight = {};

    for (int i = 0; i < p; i += 1) {
      left = append(left, a[i]);
    }
    //left = shorten(left);

    for (int i = p + 1; i < a.length; i += 1) {
      right = append(right, a[i]);
    }
    //right = shorten(right);

    for (int i = 0; i < left.length; i += 1) {
      int l = left[i];
      if (l >= p) {
        newRight = append(newRight, l);
      } else {
        newLeft = append(newLeft, l);
      }
    }

    for (int i = 0; i < right.length; i += 1) {
      int l = right[i];
      if (l >= p) {
        newRight = append(newRight, l);
      } else {
        newLeft = append(newLeft, l);
      }
    }

    newRight = sortMe(newRight);
    newLeft = sortMe(newLeft);

    a = newLeft;
    a = append(a, p);
    a = concat(a, newRight);
    if (!inOrder(a)) {
      sortMe(a);
    }
  }


  return a;
}

boolean inOrder(int[] a) {
  boolean inOrder = true;
  for (int i = 0; i < a.length - 1; i += 1) {
    int iv = a[i];
    int iv2 = a[i + 1];

    if (iv2 < iv) {
      inOrder = false;
      break;
    }
  }
  
  return inOrder;
}


int howManyBefore(int[] a, int i) {
  int rv = 0;
  for (int j = 0; j < i; j += 1) {
    rv += 1;
  }
  return rv;
}

int howManyAfter(int[] a, int i) {
  int rv = 0;
  for (int j = i + 1; j < a.length; j += 1) {
    rv += 1;
  }

  return rv;
}



void printA(int[] a) {
  print("\n");
  for (int i = 0; i < a.length; i += 1) {
    println("\t" + i + " = " + a[i]);
  }
  print("\nlen=" + a.length);
}

void setup() {
  noLoop();
  int[] b = new int[(int)random(20, 50)];
  for (int i = 0; i < b.length; i += 1) {
    b[i] = (int) (random(-100, 100));
  }
  printA(b);
  b = sortMe(b);
  printA(b);
}
void draw() {
}