String Hsh(String a) {
  String retVal = "";
  // int len = a.length();
  // int lena = int(a.length() / 12);
  ArrayList<String> chunks = new ArrayList<String>();
  ArrayList<ArrayList <Integer>> 
  int[] nums = {0, 17, 31, 99, 101, 45, 88,99,55,77,88,99};


  while (a.length() > 0) {
    if (a.length() < 15) {
      chunks.add(a);
      a = "";
    } else {
      chunks.add(a.substring(0, 15));
      a = a.substring(15, a.length());
    }
  }

  for (int i = 0; i < chunks.size(); i += 1) {
    String s = chunks.get(i);
    if (s.length() < 15) {
      String r = getRandom(15);
      s = (s + s.length() + r).substring(0, 15); 
      chunks.set(i, s);
    }
  }

  for (int i = 0; i < 20; i += 1) {
    String s = i + "" + (i * i) + getRandom(4) + (i * i * 31) + getRandom(10);
    s = s.substring(0, 12);
    //chunks.
  }

  //print("\n");
  //for (String s : chunks) {
  //  print(" " + s + " (" + s.length() + ")");
  //}



  for (int i = 0; i < 500; i += 1) {
    for (String s : chunks) {
      for (int j = 0; j < s.length(); j += 1) {
        int k = j % nums.length;
        nums[k] += (int) (s.charAt(j) * j * s.charAt(j));
        if ( nums[k] > 10000000) {
          nums[k] = nums[k] % 99999;
        }
        //nums[k] = //nums[k] % 100;
      }
    }
  }



  print("\n");
  for (int i : nums) {
   //   print(" " + i );
    retVal += trim(nfs((i%99)+1, 2));
  }

  return retVal.substring(12);
}

String getRandom(int len) {
  String retVal = "";
  for (int i = 0; i < len; i += 1) {
    char c = (char)( 120 - (i%63));
    retVal += c;
  }

  return retVal;
}

void setup() {

  //println("\n" + Hsh("abcdefghijklmnopqrstuvwxyz"));
  println(Hsh("1"));
  println(Hsh("2"));
  println(Hsh("3"));
  println(Hsh("4"));
  println(Hsh("5"));
  println(Hsh("6"));
  // println(Hsh("hello this is some data"));
  //println(Hsh("This is some really long data that definitely needs to be done correctly so do it right"));
}

void draw() {
}