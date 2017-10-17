int stuff[][][][][] = new int[2][2][3][4][5];

void setup() {
  size(400,400);
  smooth();
  noLoop();
}

void draw() {
  background(255);
  //ellipse(width / 2, height / 2, width / 4, width / 4);
  stroke(0);
  
  for (int loc = 0; loc < stuff.length; loc += 1) {
    float locw = width / stuff.length;
    float locx = 10 + (loc * locw);
    float locy = 10;
    float loch = height - 20;
    
    rect(locx, locy, locw, loch);
    for (int row = 0; row < stuff[loc].length; row += 1) {
      for (int bay = 0; bay < stuff[loc][row].length; bay += 1) {
        for (int shelf = 0; shelf < stuff[loc][row][bay].length; shelf += 1) {
          for (int bin = 0; bin < stuff[loc][row][bay][shelf].length; bin += 1) {
            println(loc + ":" + row + ":" + bay + ":" + shelf + ":" + bin);
            
            
          }
        }
      }
    }
    
  }
  
  
}