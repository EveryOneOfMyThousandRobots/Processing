HashMap<String, Word> words = new HashMap<String, Word>();
ArrayList<String> keys = new ArrayList<String>();
import java.util.Collections;

BufferedReader reader;
void setup() {
  size(400, 400);

  reader = createReader("ws.txt");
  Word prev = null;
  Word word = null;
  Word prevPunc = null;
  //for (int i = 0; i < 10000; i += 1) {
  int linesRead = 0;
  while (true) {
    try {
      String line = reader.readLine();
      linesRead += 1;
      if (line.length() == 0) continue;
      String[] wds = split(line, ' ');
      for (String w : wds) {
        String cleaned = clean(w);

        if (cleaned.length() < 2) continue;
        ArrayList<String>others = new ArrayList<String>();

        while (true) {


          char c = cleaned.charAt(cleaned.length()-1);
          if (punctuation(c)) {
            others.add(str(c));
            cleaned = cleaned.substring(0, cleaned.length()-1);
          } else {
            break;
          }
        }


        word = getWord(cleaned);

        if (prevPunc != null) {
          prevPunc.follow(word.word);
          prevPunc = null;
        }


        for (String o : others) {
          prevPunc = getWord(o);
          word.follow(o);
        }


        if (prev != null) {
          prev.follow(word.word);
        }


        prev = word;
      }
    } 
    catch (Exception e ) {
      println(e.getMessage());
      break;
    }
  }

  keys = new ArrayList<String>(words.keySet());

  String start = keys.get(floor(random(keys.size())));
  println("words: " + keys.size());
  println("lines read: " + linesRead); 
  String sentence = "";
  int i = 0;
  while (true) {
    //for (int i = 0; i < 20; i += 1) {
    if (sentence.length() == 0 || punctuation(start.charAt(0))) {
      sentence += start;
    } else {
      sentence += " " + start;
    }
    
    Word w = getWord(start);

    start = w.choose();
    i += 1;
    if (i > 20 && sentence.charAt(sentence.length()-1) == '.') {
      break;
    }
  }

  println(sentence);

  //for (String s : words.keySet()) {
  //println(words.get(s).toString());
  //}
}

void draw() {
  stop();
}

boolean punctuation(char w) {
  return (w == '?' || w == '\'' || w == '"' || w == ',' || w == '.');
}
boolean valid(char w) {
  return (punctuation(w) || (w >= 'A' && w <= 'Z'));
}

String clean(String s) {
  String returnString = "";
  s = s.toUpperCase();

  for (int i = 0; i < s.length(); i += 1) {
    char w = s.charAt(i);

    if (valid(w)) {
      returnString += str(w);
    }
  }


  return returnString;
}
