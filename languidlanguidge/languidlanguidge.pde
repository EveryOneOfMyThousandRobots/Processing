String[] consonants = {"b", "p", "k", "t", "m", "n", "j", "zh"};
String[] nasals = {"m", "n"};
String[] vowels = {"a", "e", "o"};
String[] dipthongs = {"ae", "oe"};



boolean chance(float n) {
  return random(1) < (n/ 100.0);
}

enum POSITION {
  FIRST, MIDDLE, LAST;
}

String getSyllable(POSITION pos) {
  String s = "";

  s = getConsonant();

  boolean d = chance(15);

  if (pos != POSITION.LAST && d) {
    s += getDipthong();
  } else {
    s += getVowel();
  }
  if (!d && pos != POSITION.LAST && chance(10)) {
    s += getNasal();
  }


  return s;
}
String getWord() {

  String word = "";
  int syllables = floor(random(1, 5));
  POSITION pos = POSITION.FIRST;
  for (int i = 0; i < syllables; i += 1) {
    if (i == 0) {
      pos = POSITION.FIRST;
    } else {
      pos = POSITION.MIDDLE;
    }

    if (i == syllables-1) { // catch for syllables = 1
      pos = POSITION.LAST;
    }
    String s = getSyllable(pos);

    if (!word.equals("")) {
      while (true) {
        String sf = str(s.charAt(0));
        String wl = str(word.charAt(word.length()-1));
        if (sf.equals(wl)) {
          s = getSyllable(pos);
        } else {
          break;
        }
      }
    }


    word += s;
  }

  return word;
}


String getConsonant() {
  return consonants[floor(random(consonants.length))];
}

String getVowel() {
  return vowels[floor(random(vowels.length))];
}

String getNasal() {
  return nasals[floor(random(nasals.length))];
}

String getDipthong() {
  return dipthongs[floor(random(dipthongs.length))];
}


void setup() {
  size(800, 800);
  int numC = consonants.length;
  int numN = nasals.length;
  int numV = vowels.length;
  int numD = dipthongs.length;
  int total = (numC * numD) + (numC * numV) + numV + ((numC + numN) * numC);
  println("total = " + total);
  //noLoop();
  //for (int i = 0; i < 50; i += 1) {
  //  println(getWord());
  //}
  //noLoop();
  background(0);
}
float rmin = Float.MAX_VALUE, rmax = Float.MIN_VALUE;
HashMap<Integer, Integer> points = new HashMap<Integer, Integer>();
void draw() {
  background(0);
  for (int i=0; i < 100; i += 1) {
      float r = randomBell(0,5);
    if (r > rmax) {
      rmax = r;
    } 
    
    if (r < rmin) {
      rmin = r;
    }
    int x = floor(map(r, rmin, rmax, 0, width));
    //print(nfc(r,2) + " "); 
    if (points.containsKey(x)) {
      points.put(x, points.get(x)+1);
    } else {
      points.put(x, 1);
    }
  }

  stroke(255);
  int max = 0;
  for (int x = 0; x < width; x += 1) {
    if (points.containsKey(x)) {
      if (points.get(x) > max) {
        max = points.get(x);
      }
    }
  }
  for (int x = 0; x < width; x += 1) {
    if (points.containsKey(x)) {
      line(x, height, x, map(points.get(x), 0, max, height, 0));
    }
  }
  
  fill(0);
  rect(0,0,width, 50);
  fill(255);
  text("min = " + nfc(rmin,2) + " max = " + nfc(rmax,2),10,10);
  
}


float sqrt_TWO_PI = sqrt(TWO_PI);
float one_over_sqrt_TWO_PI = 1.0 / sqrt_TWO_PI;


float random3(float x, float mu, float sig) {
  float f = 0;
  
  f = (1.0 / (sqrt(TWO_PI * sig))) * exp( - ( pow(x-mu,2) / (2 * sig)));
  
  return f;
}
float random2 (float x) {
  
  float f = 0;
  
  f = (one_over_sqrt_TWO_PI) * exp(-0.5 * (pow(x,2)));
  
  return f;
}
//static Random r = new Random();
float randomBell(float mu, float sig) {
  float u, v, x, y, q;
  do
  {
    u = random(1);
    v = 1.7156 * (random(1) - 0.5);
    x = u - 0.449871;
    y = abs(v) + 0.386595;
    q = sqrt(x) + y * (0.19600 * y - 0.25472 * x);
  } 
  while (q > 0.27597 && (q > 0.27846 || sqrt(v) > -4.0 * log(u) * sqrt(u)));
  return mu + sig * v / u;
}
