import java.util.HashSet;
ArrayList<String> nameParts = new ArrayList<String>();
void addPart(String s ) {

  if (!nameParts.contains(s)) {
    nameParts.add(s);
  }
}

String getRandomName() {
  String output = "";
  int n = floor(random(2, 5));

  for (int i = 0; i < n; i += 1) {
    int r = floor(random(nameParts.size()));
    output += nameParts.get(r);
  }

  return output;
}

void printNames(int n) {
  for (int i = 0; i < n; i += 1) {
    println(getRandomName());
  }
  
}

void setup() {
  addPart("bla");
  addPart("kley");
  addPart("tri");
  addPart("brigh");
  addPart("breigh");
  addPart("kley");
  addPart("char");
  addPart("jo");
  addPart("rich");
  addPart("cha");
  
  printNames(10);
}

void draw() {
}
