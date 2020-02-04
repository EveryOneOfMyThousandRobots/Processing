String toBin(int i, int l) {
  String c = Integer.toBinaryString(i);
  c = "00000000000000000000000000000000" + c;
  
  c = c.substring(c.length()-l);
  
  return c;
}
