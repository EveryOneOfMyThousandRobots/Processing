ArrayList<int[]> table = new ArrayList<int[]>();



void setup() {
  ArrayList<Integer> ints = new ArrayList<Integer>();
  for (int f = 0; f < 3; f += 1) {
    
    for (int s = 0; s < 3; s += 1) {
      
      for (int l = 0; l < 3; l += 1) {
        
        for (int p = 0; p < 3; p += 1) {
          
          ints.add(f);
          ints.add(s);
          ints.add(l);
          ints.add(p);
          
          ints.add(0);
        }
      }
    }
  }
  int[] ar = new int[ints.size()];
  printArray(ar);
  
  
  
  
  exit();
}
