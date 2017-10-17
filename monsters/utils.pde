String getNewName(int howMany) {
  String name = "";
  //int len = (int) random(1, 3);

  for (int i = 0; i < howMany; i += 1) {
    int idx = (int)random(0, names.length);

    if (name.length() == 0) {
      name = names[idx];
    } else {
      name += "-"+names[idx];
    }
  }

  return name;
}

boolean outOfBounds(float x,float y) {
  boolean answer = true;
  
  if (x >= boundaryTopLeft.x && x < boundaryBottomRight.x && y >= boundaryTopLeft.y && y < boundaryBottomRight.y) {
    answer = false;
  }
  
  return answer;
}

String[] nameParts = {
  "ma", "me", "mo", "mu", 
  "la", "le", "lo", "lu", 
  "ka", "ke", "ko", "ku", 
  "da", "de", "do", "du", 
  "ta", "te", "to", "tu", 
  "ra", "re", "ro", "ru", 
  "pa", "pe", "po", "pu", 
  "lan", "man", "pan", "dan", 
  "ken", "ren", "pen", 
  "kang", "rang", "pang", 
  "mar", "lar", "kar", 
  "sen", "san", "son"};