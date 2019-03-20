int numAcross = 5;
int numDown = 5;

String shelves = "ABCDEFGHJKLMNPQRSTWXYZ";
String bins = "123456789ABCDEFGHJKLMNPQRSTWXYZ";
PFont fnt;

void setup() {
  fnt = createFont("Consolas Bold", 32);
  textFont(fnt);
  textAlign(CENTER, CENTER);
  String[] fontlist  = PFont.list();
  printArray(fontlist);
  size(800, 800);
  float cw = width / float(numAcross);
  float ch = height / float(numDown);
  background(255);
  stroke(0);
  for (int x = 0; x < width; x += cw) {
    line(x, 0, x, height);
  }
  for (int y = 0; y < height; y += ch) {
    line(0, y, width, y);
  }
  fill(0);
  //textAlign(CENTER);
  for (int x = 0; x < numAcross; x += 1) {
    float xp = (x * cw) + (cw / 2);
    for (int y = 0; y < numDown; y += 1){
      float yp = (y * ch) + (ch / 2);
      String binName = str(shelves.charAt(y)) + str(bins.charAt(x));
      text(binName, xp, yp);
      
      
      
    }
  }

  noLoop();
}

void draw() {
}
