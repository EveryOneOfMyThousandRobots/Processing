String a12x9x1 =  "123456789" +
  "ABCDEFGHI" + 
  "A1B2C3D4E" + 
  "123456789" + 
  "123456789" + 
  "123456789" + 
  "123456789" + 
  "123456789" + 
  "123456789" + 
  "123456789" + 
  "123456789" + 
  "12345678Z";
  
  
String a32 = "123456789ABCDEFGHJKLMNPQRSTVWXYZ";
String a32x32x1 = "";



String get12x9x1(int i, int j) {

  return a12x9x1.substring( i * 9 + j, i * 9 + j + 1);
}
void setup()
{
  noLoop();
  for (int i = 0; i < 32; i += 1) {
    a32x32x1 += a32;
  }
}

void draw() {
  println(a32x32x1.length());
  println(a32x32x1);
  println(get12x9x1(11, 8));
}