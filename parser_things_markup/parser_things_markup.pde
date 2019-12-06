HashMap<String, ArrayList<String>> markup = new HashMap<String, ArrayList<String>>();

void setup() {
  String[] lines = loadStrings("markup.txt");
  ArrayList<String> currentList = null;
  for (String s : lines) {
    if (s.startsWith("{")) {
      if (markup.containsKey(s)) {
        currentList = markup.get(s);
      } else {
        currentList = new ArrayList<String>();
        markup.put(s, currentList);
      }
    } else if (s.startsWith("::")) {
      if (currentList != null) {
        String ss = s.substring(2);
        if (!currentList.contains(ss)) {
          currentList.add(ss);
        }
      }
    }
  }

  for (String k : markup.keySet()) {
    ArrayList<String> list = markup.get(k);

    if (list != null) {
      for (String v : list) {
        //println(k + " : " + v);
      }
    }
  }


  println("output = " + parse("{name}"));

  noLoop();
  stop();
}

String getString(String s) {
  println("get string = [" + s + "]");
  if (s.startsWith("{")) {
    if (markup.containsKey(s)) {
      ArrayList<String> list = markup.get(s);
      String rv = list.get(floor(random(list.size())));
      return getString(rv);
    } else {
      return "[?]";
    }
  } else {
    return s;
  }
}

String parse(String s) {
  //int i = 0;
  while (s.contains("{")) {
    String first = between(s, "{", "}");
    //println(i + ": " + s);
    if (first != null) {
      first = getString(first);
      
      int pos1 = firstPos(s, "{");
      int pos2 = secondPos(s, "}", pos1);
      //println("pos1 : " + pos1 + ", pos2 : " + pos2);
      if (pos1 >= 0 && pos2 >= 0 && pos2 > pos1) {
        String ss = s;
        if (pos1 == 0) {
          ss = first + s.substring(pos2+1);
          //println("pos1 = 0 " + ss);
        } else {
          ss = s.substring(0,pos1) + first + s.substring(pos2+1);
          //println("pos1 != 0 " + ss);
        }
        s = ss;
        //rv = searchString.substring(pos1, pos2-pos1);
      }
    }
    //i += 1;
    //break;
  }


  return s;
}

int firstPos(String searchString, String start) {
  return searchString.indexOf(start);
}

int secondPos(String searchString, String end, int from) {
  return searchString.indexOf(end, from);
}

String between(String searchString, String start, String end) {
  String rv = null;
  
  int pos1 = firstPos(searchString, start);
  int pos2 = secondPos(searchString, end, pos1);
  
  if (pos1 >= 0 && pos2 >= 0 && pos2 > pos1) {
    rv = searchString.substring(pos1, pos2+1);
  }
  
  //println("between(" + searchString + "," + start + "," + end + ") = " + rv);
  
  
  return rv;
}


void draw() {
}
