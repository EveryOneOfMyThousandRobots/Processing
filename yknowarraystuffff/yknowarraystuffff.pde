


String makeArray(int x, int y, String c) {
  String alpha = "123456789ABCDEFGHIJKLMNPQRSTVWXYZ";
  String a = "";
  if (c == null) {
  } else {
  }
  for (int xi = 0; xi < x; xi += 1) {
    for (int yi = 0; yi < y; yi += 1) {
      int r = (int) random(0, alpha.length());
      if (c == null) {

        a += alpha.substring(r, r+1);
      } else {
        a += c.substring(0, 1);
      }
    }
  }
  return a;
}

String getXxY(String a, int xi, int yi, int s) {
  int i = (xi * s) + yi;
  return a.substring(i, i+1);
}

String setXxY(String a, int xi, int yi, int s, String val) {
  int i = (xi * s) + yi;
  return a.substring(0, i) + val.substring(0,1) + a.substring(i + 1, a.length());
}

String setXxYxZ(String a, int xi, int yi, int len, int s, String val) {
  int i = (xi * s) + yi;
  return a.substring(0, i) + val.substring(0,len) + a.substring(i + 1, a.length());
}

final String a32_0s = "00000000000000000000000000000000";
String a9x12_to_a32x32(String b9x12) {
  String returnVal = makeArray(32,32,"0");
  
  
  //String returnVal = "";
  for (int i = 0; i < 12; i += 1) {
    String aa = b9x12.substring(9 * i, (9 * i) + 8) + a32_0s.substring(0, 32 - 9);
    returnVal = setXxYxZ(returnVal, i, 0, 9, 32, aa);
  }
  
  return returnVal;
}

void setup() {
  noLoop();
  String a12x9 = makeArray(12, 9, null);
  String a32x32 = makeArray(32, 32, "0");
  String b[] = new String[12];
  for (int i = 0; i < 12; i += 1) {
    b[i] = a12x9.substring(9 * i, (9 * i) + 8);
  }
  println("12x9: " + a12x9 + "\nlen:" + a12x9.length());
  int x = 0;
  for (int y = 0; y < 9; y += 1) {
    println("get " + x + "," + y + " : " + getXxY(a12x9, x, y, 9));
  }
  a12x9 = setXxY(a12x9, 1, 0, 9, "a");
  println("12x9: " + a12x9 + "\nlen:" + a12x9.length());
  println("32x32: " + a32x32 + "\nlen:" + a32x32.length());
 // printArray(b);
  
  String bbbb = a9x12_to_a32x32(a12x9);
  println(bbbb + "\n\tlen: " + bbbb.length());
}

void printArray(String[] p) {
  print("\n");
  for (int i = 0; i < p.length; i += 1) {
    if (i > 0) {
      print(", ");
    }
    print(i + ": \"" + p[i] + "\"");
  }
}

void draw() {
}