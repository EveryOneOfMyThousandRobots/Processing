String getRndChar() {
  int r = floor(random(alphabet.length()));
  
  return str(alphabet.charAt(r));
}