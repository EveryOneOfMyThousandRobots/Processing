import java.util.Collections;

String printables;


Movie m;
PFont ibmFont;
final int TARGET_IMAGE_WIDTH = 640;
final int TARGET_IMAGE_HEIGHT = 360;

final int WINDOW_WIDTH = 640;
final int WINDOW_HEIGHT = 360;

void settings() {
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
  noSmooth();
}

PGraphics vignette;
void setup() {
  frameRate(10000);
  String temp = "abcdefghijklmnopqrstuv wxyz0123456789@!£$%^&*().><,?/\\_-+=";
  ArrayList<Character> characters = new ArrayList<Character>();
  for (char c : temp.toCharArray()) {
    characters.add(c);
  }
  Collections.shuffle(characters);
  printables = "";
  for (char c : characters) {
    String ss = str(c);
    if (printables.lastIndexOf(ss) == -1) {
      printables += ss;
    }
  }

  ibmFont = createFont("Nouveau Ibm", 20);

  dither_matrix_factors = new float[4][4];

  float n = 1.0 / 16.0;
  for (int x = 0; x < 4; x += 1) {
    for (int y = 0; y < 4; y += 1) {

      dither_matrix_factors[x][y] = dither_matrix[x][y] * n;
    }
  }

  NoiseManager nm = new NoiseManager();
  vignette = createGraphics(TARGET_IMAGE_WIDTH, TARGET_IMAGE_HEIGHT);

  vignette.beginDraw();
  float w = TARGET_IMAGE_WIDTH;
  float h = TARGET_IMAGE_HEIGHT;


  vignette.noStroke();
  vignette.fill(0, 0);
  vignette.rect(0, 0, vignette.width, vignette.height);
  for (int x = 0; x < w / 8; x += 1) {
    int x0 = x;
    int x1 = (int)w - x - 1;
    float a = map(x, 0, w / 8, 255, 0);
    vignette.stroke(0, a);
    vignette.line(x0, 0, x0, h);
    vignette.line(x1, 0, x1, h);
  }
  //pixelate(nm,vignette,"hello",1);
  dither(nm, vignette, "hello", 1);
  vignette.endDraw();


  m = new Movie(12, 20, TARGET_IMAGE_WIDTH, TARGET_IMAGE_HEIGHT, false);
  println(m.toString());
}

long getTime() {
  return System.nanoTime() / (long)1e6;
}



void draw() {
  background(0);

  

  m.update();
  m.draw();
  //switch (state) {
  //case "":
  //  nextState = "BUILD";
  //  break;
  //case "DISPLAY":
  //  PImage img = m.frames[f_index];
  //  image(img, 0, 0, width, height);
  //  fill(255);
  //  //text(f_index+"\n" + millis(), 10, 10);
  //  if (frame_timer > 1000.0 / fps) {
  //    f_index += 1;
  //    if (f_index > m.frames.length-1) {
  //      f_index = 0;
  //    }
  //    frame_timer = 0;
  //  }
  //  break;
  //case "BUILD":
  //  break;
  //}
}
