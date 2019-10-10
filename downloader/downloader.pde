import java.util.HashSet;






BufferedReader reader;
ArrayList<String> wordSet = new ArrayList<String>();
HashMap<String,Word> wordMap = new HashMap<String,Word>();

Word getWord(String s) {
  if (!wordSet.contains(s)) {
    wordSet.add(s);
  }
  
  if (wordMap.containsKey(s)) {
    return wordMap.get(s);
  } else {
    Word w = new Word(s);
    wordMap.put(s,w);
    return w;
  }
}

String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}
void setup() {
  
  String[] files = listFileNames(sketchPath() + "/data/");
  
  for (String file : files) {
    Word prev = null;
    reader = createReader(file);
    while (true) {
      
      try {
        String line = reader.readLine();

        String[] words = split(line, ' ');

        for (String s : words) {
          if (s.length() < 2) continue;
          
          ArrayList<String> others = new ArrayList<String>();
          String ss = s.toLowerCase();
          while(true) {
            if (punc(ss.charAt(ss.length()-1))) {
              others.add(str(ss.charAt(ss.length()-1)));
              
              ss = ss.substring(0,ss.length()-1);
              
            } else {
              break;
            }
          }
          
          String cs = clean(ss);
          Word w = getWord(cs);
          
          if (prev != null) {
            prev.follow(cs);
          }
          for (String so : others) {
            Word w2 = getWord(so);
            w.follow(so);
            w = w2;
            
          }
          
          prev = w;
        }
      } 
      catch (Exception e) {
        break;
      }
    }

    println(wordSet.size());
  }
  int k = 0;
  for (String s : wordMap.keySet()) {
    println(wordMap.get(s));
    k += 1;
    if (k > 10) break;
  }
  
  String start = wordSet.get(floor(random(wordSet.size())));
  String line = "";
  int i = 0;
  while(true) {
    
    line += " " + start;
    Word w = getWord(start);
    
    
    
    if (i > 20) {
      if (start.charAt(start.length()-1) == '.') {
        break;
      }
    }
    i += 1;
    start = w.choose();
  }
  
  println(line);
  
  
}


String clean(String s) {
  String o = "";

  for (int i = 0; i < s.length(); i += 1) {
    char c = s.charAt(i);

    if (valid(c)) {
      o += str(c);
    }
  }

  return o;
}
boolean punc(char c) {
  return (c == ',' || c == '"' || c == '\'' || c == '!' || c == '?' || c == '.');
}

boolean valid(char c) {
  return punc(c) || (c >= 'a' || c <= 'z');
}


void draw() {
}
