String base32Alphabet = "0123456789abcdefghjkmpqrstvwxyz_";
String intToBase32(int n) {
  int on = n;
  int prev = 0;
  int digit = 0;
  String r = "";
  while (n > 0) {
    prev = n;
    n = n / 32;
    digit = prev - n * 32;
    //println("\tinput = " + on + "\n\tn=" + n + "\tp=" + prev + "\td="+digit); 
    r = base32Alphabet.substring(digit,digit+1) + r;
  }
  //WHILE @intin > 0 BEGIN
  //  SET @prev = @intin  

  //  SET @intin = CAST(@intin / 32 AS UNSIGNED INT)
  //  SET @dig = @prev - @intin * 32

  //  SET @ReturnValue = subString(@alphabet, @dig+1,1)||COALESCE(@ReturnValue, '')

  //END
  if (r.length() == 0) {
    r = "0";
  }
  return r;
}
void setup() {
  println(base32Alphabet.length());
  for (int i = 0; i < 1000000000; i += floor(random(100000))) {
    //int f = floor(random(pow(2,i)));
    String j = intToBase32(i);
    println(i + "\t\t:\t\t" + j);
  }
  
  for (int i = 0; i < 20; i += 1) {
    int k = floor(random(pow(2,31)));
    String j = intToBase32(k);
    println(k + "\t\t:\t\t" + j);
  }
  
 
  
}
