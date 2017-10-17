final int GUESS_MIN = 1;
final int GUESS_MAX = 9;
import java.util.TreeMap;
ArrayList<Guesser> guessers = new ArrayList<Guesser>();
TreeMap<Integer, Integer> scores = new TreeMap<Integer, Integer>();

void setup() {
  size(600,600);
  for (int i = 0; i < 100; i += 1) {
    guessers.add(new Guesser());
  }
  noLoop();
}

void draw() {
  background(0);
  for (int i = 0; i < 100; i += 1) {
    int answer = getNum();

    for (Guesser g : guessers) {
      g.test(answer);
    }
  }
  guessers.sort(gc);
  
  scores.clear();
  for (int i = 0; i < 20; i += 1) {
    scores.put(i, 0);
  }
  for (Guesser g : guessers) {
    if (!scores.containsKey(g.score)) {
      scores.put(g.score,1);
    } else {
      int count = scores.get(g.score) + 1;
      scores.put(g.score, count);
    }
  }
  
  float w = width / scores.size();
  int max = 0;
  for (Integer i : scores.keySet()) {
    if (scores.get(i) > max) {
      max = scores.get(i);
    }
  }
  int j = 0;
  for (Integer i : scores.keySet()) {
    int count = scores.get(i);
    float x = j * w;
    float y = map(count, 0, max, height, 0);
   
    rect(x,y , w, height);
    text(i + " " + count, x, y); 
    
    j += 1;
  }
}