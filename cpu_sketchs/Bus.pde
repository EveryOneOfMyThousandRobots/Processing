class BUS {
  boolean[] data;
  
  BUS (int w) {
    data = new boolean[w];
  }
  
  void write(int d) {
    
    for (int i = data.length-1; i >= 0; i -= 1) {
      data[i] = (d & (1 << i)) != 0 ? true : false;
      
    }
    
  }
  
  
  int read() {
    int c = 0;
    
    for (int i = data.length-1; i >= 0; i -= 1) {
      if (data[i]) {
        c += (1 << i);
      }
      
    }
    
    
    return c;
  }
  
  String toString() {
    int c = read();
    return "[" + c + "] [" + toBin(c,data.length) + "]";
  }
}
