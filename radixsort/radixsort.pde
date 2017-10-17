ArrayList<String> nums = new ArrayList<String>();
import java.util.TreeMap;
long started;
int[] sortMe = new int[100000];

void setup() {
  for (int i = 0; i < sortMe.length; i += 1) {
    sortMe[i] = floor(random(1000000));
    String s = "0000000000" + sortMe[i];
    //println(s);
    s = s.substring(s.length()-7, s.length());
    //println(s + " " + s.length());
    nums.add(s);
  }
  //println(nums);
  started = millis();
  for (int i = 1; i <= nums.get(0).length(); i += 1) {

    nums = sort(nums, i);
  }
  //println(nums);

  sortMe = new int[nums.size()];
  for (int i = 0; i < nums.size(); i += 1) {
    sortMe[i] = int(nums.get(i));
  }
  //println(sortMe);
  println("sorted " + sortMe.length + " numbers in " + (millis() - started) + "ms");
}

ArrayList<String> sort(ArrayList<String> aa, int digit) {
  //ArrayList<ArrayList<String>> strings = new ArrayList<ArrayList<String>>();
  TreeMap<String, ArrayList<String>> strings = new TreeMap<String, ArrayList<String>>();
  //String[][] strings = new String[10][aa.size()];
  //int[] indices = new int[10];

  for (int i = 0; i < aa.size(); i += 1) {
    String s = aa.get(i);
    String d = str(int(s.substring(s.length()-digit, s.length() -(digit-1))));

    if (strings.containsKey(d)) {
      strings.get(d).add(s);
    } else {
      strings.put(d, new ArrayList<String>());
      strings.get(d).add(s);
    }
    //ArrayList<String> list = 
      //strings[d][indices[d]] = s;
      //indices[d] += 1;
  }

  aa.clear();

  for (String s : strings.keySet()) {
    ArrayList<String> s2 = strings.get(s);
    for (String ss : s2) {
      aa.add(ss);
    }
  }
  //for (int i = 0; i < strings.length; i += 1 ) {
  //  for (int j = 0; j < strings[i].length; j += 1) {
  //    String s = strings[i][j];
  //    if (s == null) break;
  //    aa.add(s);
  //  }
  //}    
  return aa;
}

void draw() {
}