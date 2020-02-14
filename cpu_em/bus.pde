abstract class BUS {
}

class BUS8 extends BUS {
  char value = 0b00000000;
  BUS8() {
  }

  void set(int v) {
    value = (char) (v & 0xff);
  }
  
  char get() {
    return value;
  }
}

class BUS16 extends BUS {
  int value = 0;

  BUS16() {
  }

  void set(int v) {
    value = v & 0xffff;
  }
  
  int get() {
    return value;
  }
}
