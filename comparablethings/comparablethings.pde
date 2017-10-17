import java.util.*;

void setup() {

  TreeMap<Thing, Integer> things = new TreeMap<Thing, Integer>();

  for (int  i = 0; i < 100; i += 1) {
    things.put(new Thing(), i);
  }

  int i = 0;
  for (Map.Entry<Thing, Integer> entry : things.entrySet()) {
    i += 1;
    println(i + "\t\t" + entry.getKey().val +  " " + entry.getValue() );
  }

  noLoop();
}

void draw() {
}

class Thing implements Comparable<Thing> {
  float val = (int)random(0, 10);

  int compareTo(Thing o) {
    if (this.val > o.val) {
      return 1;
    } else if (this.val < o.val) {
      return -1;
    } else {
      return 0;
    }
  }
}