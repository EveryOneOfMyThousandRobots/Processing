String getId() {
  String id = get1(null, 1);

  while (id.length() < 8) {
    id += get1(id, 2);
  }

  return id;
}

String get1(String existingString, int characterchoice) {
  String rtn = "";

  String alpha = "ABCDEFGHJKLMPQRSTVWXYZ";
  String alphanum = "0123456789ABCDEFGHJKLMPQRSTVWXYZ";
  String toUse = null;
  int len = 0;
  if (characterchoice == 1) {
    len = alpha.length();
    toUse = alpha;
  } else {
    len = alphanum.length();
    toUse = alphanum;
  }
  while (true) {
    int i = (int) random(0, len);

    rtn = toUse.substring(i, i+1);
    if (existingString != null) {
      String t0 = rtn;
      String t1 = existingString.substring(existingString.length()-1,existingString.length());
     // println(existingString + " " + t0 + " " + t1);
      if (t0.equalsIgnoreCase(t1)) {
        continue;
      } else {
        break;
      }
    } else{
      break;
    }
  }
  return rtn;
}

void setup () {
  size(500, 500);
  stroke(255);
  fill(255);
}


void draw() {
  println("hello");
  background(0);
  for (int y = 20; y < height - 20; y += 11) {
    String id = getId();
   // println(id);
    text(id, width / 2, y);
  }
  noLoop();
}