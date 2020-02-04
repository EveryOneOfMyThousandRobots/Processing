class RAM {
   char[] data;
   RAM(int size) {
     data = new char[size];
   }
   
   char read(int a) {
     return data[a];
   }
}

class ROM extends RAM {
  ROM(int size) {
    super(size);
  }
  
}
