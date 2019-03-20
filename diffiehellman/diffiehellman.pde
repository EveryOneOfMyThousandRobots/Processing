import java.math.*;
import java.util.Random;


void setup() {

  BigInteger n = BigInteger.valueOf(593441861l);


  BigInteger g = BigInteger.valueOf(2);
  
  BigInteger Xa = getRandom(n);
  BigInteger Xb = getRandom(n);
  
  println("Xa = " + Xa);
  println("Xb = " + Xb);

  BigInteger Ya = g.modPow(Xa,n); 
  BigInteger Yb = g.modPow(Xb,n);

  BigInteger Yab = Ya.modPow(Yb, n);
  BigInteger Yba = Yb.modPow(Ya, n);//(long) pow(Ya, Yb) % n;

  println("Xa = " + Xa);
  println("Xb = " + Xb);
  println("Ya = " + Ya);
  println("Yb = " + Yb);
  println("Yab = " + Yab);
  println("Yba = " + Yba);
}

void draw() {
  noLoop();
}




BigInteger getRandom(BigInteger limit) {
  Random r = new Random();
  BigInteger randomNumber;
  do {
    randomNumber = new BigInteger(limit.bitLength(), r);
  } while (randomNumber.compareTo(limit) >= 0);

  return randomNumber;
}
