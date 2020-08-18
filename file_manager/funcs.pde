void createInputFile() {
  transmissionId += 1;
  int tid = transmissionId;

  BufferedOutputStream bos = (BufferedOutputStream)createOutput("/data/input/f" + tid + ".txt");

  try {
    int r = floor(random(50, 100));
    for (int i = 0; i < r; i += 1) {
      String out = getNoun() +"="+rlString() + "\r\n";
      bos.write(out.getBytes());
    }
    bos.close();
  } 
  catch (Exception e) {
    println("Exception " + e.getMessage());
  }
  
  
  //writer.close();
}
String alphabet = "abcdefghjklmpqrstwxyz-_";
String rlString() {
  return rString(floor(random(5, 20)));
}
String rString(int r) {
  String t = "";
  for (int i = 0; i < r; i += 1) {
    int c = floor(random(alphabet.length()));
    t += alphabet.substring(c,c+1);
  }

  return t;
}
