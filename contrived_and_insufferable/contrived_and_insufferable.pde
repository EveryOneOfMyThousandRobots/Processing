String title1 = "CONTRIVED";
String title2 = "AND";
String title3 = "INSUFFERABLE";
final int W = 40;

String ep = "011";
String guest1 = "Elena Kerrigan";
String guest2 = "Kathy Manson";
String guest3 = "Annie Harris";
final int SPC = 10;

color TL = color(255, 0, 0);
color BR = color(255, 255, 0);
PGraphics bg;

ArrayList<MP> clicks = new ArrayList<MP>();
PFont karmatic, highway, komodore, unscreen;
void setup() {
  size(800, 800);
  bg = createGraphics(width, height);
  //noLoop();

  karmatic  = createFont("karmatic arcade", 75);
  highway = createFont("electronic highway sign", 80);
  komodore = createFont("komodore normal", 60);
  unscreen = createFont("unscreen", 80);
  //drawBg();
  //noLoop();
}
void kText(String s, PFont f, int fSize, int x, int y, float kern) {
  float acc = 0;
  textFont(f, fSize);
  for (int i = 0; i < s.length(); i++) {
    text(s.charAt(i), x + acc * kern, y);
    acc += textWidth(s.charAt(i))* kern;
  }
}

void fadeRect(float x, float y, float w, float h) {
  color a = color(255, 128);
  color b = color(255, 0);
  for (float xx = x; xx < x + w; xx += W) {
    color c = lerpColor(a, b, map(xx, x, x + w, 0, 1));
    bg.noStroke();
    bg.fill(c);
    bg.rect(xx, y, W, h);
  }
}

void draw() {
  makeEpisodes();
  for (Episode e : episodes) {
    drawBg(e);
    image(bg, 0, 0);
    fillSaved();
    image(bg, 0, 0);
    saveFrame(e.ep + ".png");
  }
  noLoop();
}

void keyReleased() {
  //if (keyCode == 'R') {
  //  //drawBg();
  //}
  //if (keyCode == 'P') {
  //  for (MP m : clicks) {
  //    println(m.toString());
  //  }
  //}

  //if (keyCode == 'F') {
  //  fillSaved();
  //}
}

void fillSaved() {
  for (int[] a : savedClicks) {
    make();
    flood(a[0], a[1], color(255), bg);
  }
}

void mouseClicked() {
  make();
  int x = mouseX;
  int y = mouseY;
  if (flood(x, y, color(255), bg)) {
    clicks.add(new MP(x, y, 0));
  }

  //checkedPoints.clear();
  //color[][] p = makePixelMap();

  //p = fillMap(p, mouseX, mouseY);
  //bg.beginDraw();
  //bg.loadPixels();

  //for (int x = 0; x < p.length; x += 1) {
  //  for (int y = 0; y < p[x].length; y += 1) {
  //     bg.set(x,y,p[x][y]);
  //  }
  //}


  //bg.updatePixels();
  //bg.endDraw();



  //drawBg();
}

void drawBg(Episode e) {
  bg.beginDraw();

  bg.background(0);
  bg.noStroke();
  for (int x = 0; x < width; x += W) {
    for (int y = 0; y < height; y += W) {
      float r = 1 - (0.6 * pow(random(1), 4));
      float xy = ((float)x + y) / (height + width);

      if (xy > r && (y > height / 2 || x > width * 0.75)) {// && y > height / 2) {
        xy = random(1);
        //bg.fill(0);
      } else {
      }

      color c = lerpColor(TL, BR, xy);
      bg.fill(c);
      bg.rect(x, y, W, W);
      fill(255);
    }
  }
  //fadeRect(0, 0, width, height);
  //fadeRect(0, 0, width, height/2);
  bg.fill(0);
  bg.textFont(karmatic);
  //float k = 1.08;
  float y = 80;
  bg.text(title1, 10, y);
  y += 80;
  bg.text(title2, 10, y);
  y += 80;
  bg.text(title3, 10, y);
  //kText(title1, karmatic, 60, 10, 80, k);
  //kText(title2, karmatic, 60, 10, 80 + 70, k);
  //kText(title3, karmatic, 60, 10, 80 + 140, k);
  bg.textFont(highway);
  y += 90;
  bg.text(e.ep, 10, y);
  bg.textFont(unscreen);
  y += 70;
  for (String g : e.guests) {
    bg.text(g, 10, y);
    y += 70;
  }

  //bg.text(guest2, 10, y);
  //y += 50;
  //bg.text(guest3, 10, y);
  bg.endDraw();
}
