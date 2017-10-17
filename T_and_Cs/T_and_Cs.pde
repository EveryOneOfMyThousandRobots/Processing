class T {
  String name;
  int b;
  
  T() {
    name = (String.valueOf(floor(random(65,75))));
    b = floor(random(10,100));
  }
  
  T(String name) {
    this.name = name;
    this.b = floor(random(10,100));
  }
  
  T(String name, int b) {
    this.name = name;
    this.b = b;
  }
  
  T copy() {
    return new T(this.name, this.b);
  }
}

ArrayList<T> ts = new ArrayList<T>();

int cycles = 0;
void setup() {
  for (int i = 0 ; i < 20; i += 1) {
    ts.add(new T());
  }
  
}

void draw() {
  cycles += 1;
  
  
}