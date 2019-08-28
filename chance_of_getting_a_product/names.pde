String[] consonants = {"b", "d", "k", "f", "s", "t", "n", "z", "r"};
String[] vowels = {"a", "e", "i", "o", "é"};
String[] dipthongs = {"ae", "ai", "oo", "ee"};

String getName() {
  String name = "";

  int parts = floor(random(2, 6));

  for (int i = 0; i < parts; i += 1) {
    name += consonants[floor(random(consonants.length))];
    if (random(1) < 0.05) {
      name += dipthongs[floor(random(dipthongs.length))];
    } else {
      name += vowels[floor(random(vowels.length))];
    }
  }
  if (random(1) < 0.3) {
    name += consonants[floor(random(consonants.length))];
  }


  return name;
}


String padString(int colWidth, String... parts) {



  String output = "";
  for (String p : parts) {
    String pp = p;
    if (pp.length() > colWidth) {
      pp = pp.substring(0, colWidth);
    } else {
      while (pp.length() < colWidth) {
        pp += " ";
      }
    }
    output += pp;
  }




  return output;
}
