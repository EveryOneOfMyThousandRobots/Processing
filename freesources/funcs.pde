String[] commonVowels = {"e", "e", "e", "a", "a", "e", "i", "o", "u"};
String[] vowels = {"e", "e", "e", "e", "a", "e", "i", "o", "u", "ea", "ai", "ou", "oa", "y", "ee"};
String[] cons = {"pl", "b", "b","b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "n", "s", "r", "t","p", "qu", "r", "rh", "s", "t", "v", "w", "z"};
String[] midCons = {"lm","ll", "ss", "st", "str", "gh", "zz", "mm", "ck", "rs", "rst", "nt", "ls", "ns"};
String[] endCons = {"lm","ns", "nt", "l", "ll", "s", "stry", "try", "rsty", "n", "b", "t", "tt", "p", "er", "ar", "en"};
ArrayList<String> usedNames = new ArrayList<String>();
String getVowel() {
  if (random(1) < 0.2) {
    return vowels[floor(random(vowels.length))];
  }
  return commonVowels[floor(random(commonVowels.length))];
  
}
TreeMap<String, Integer> ids = new TreeMap<String, Integer>();
int getNextId(String name) {
  int id = 0;
  name = name.toUpperCase();
  if (ids.containsKey(name)) {
    id = ids.get(name) + 1;
    ids.put(name, id);
    
  } else {
    id = 1;
    ids.put(name,id);
  }
  
  return id;
  
}

String getConsonant(int part) {
  if (part == 0) {
    return cons[floor(random(cons.length))];
  } 
  if (part == 2) { //end
    return endCons[floor(random(endCons.length))];
  } else {

    if (random(1) < 0.2) {
      return midCons[floor(random(midCons.length))];
    } else {
      return cons[floor(random(cons.length))];
    }
  }
}
String getName() {

  String name = "";
  int len = 0;
  while (true) {
    len = floor(random(3, 8));
    //boolean start = true;
    int part = 0;
    for (int i = 0; i < len; i += 1) {


      if (i % 2 != 0) {
        name += getVowel();
        if (part == 2) {
          name += getConsonant(2);
        }
      } else {

        name += getConsonant(part);
      }
      
      if (part == 0) {
        part = 1;
      } else if (i == len - 2) {
        part = 2;
      }
    }


    name = str(name.charAt(0)).toUpperCase() + name.substring(1, name.length());

    if (!usedNames.contains(name)) {
      usedNames.add(name);
      break;
    } else {
      name = "";
      continue;
    }
  }
  return name;
}
