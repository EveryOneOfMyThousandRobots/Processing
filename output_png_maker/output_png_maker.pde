String  output = "t:\\images\\icons\\out16.png";
String inputDir = "T:\\images\\icons\\cc\\black\\16";
final int SIZE=16;
final int SPRITES_PER_ROW = 20;
final int SHEET_SIZE=SIZE*SPRITES_PER_ROW;
void settings() {
  size(SHEET_SIZE, SHEET_SIZE);
}
int counter = 0;
void setup() {

  File input = new File(inputDir);
  if (input.isDirectory()) {
    String[] names = input.list();
    int xx = 0;
    int yy = 0;
    background(255);


    PGraphics g = null;
    int xi = 1;
    int yi = 0;
    for (String name : names) {

      println(name);
      if (g == null) {
        g = createGraphics(SHEET_SIZE, SHEET_SIZE);
        g.beginDraw();
        g.background(255);
        g.endDraw();
        xi = 1;
        yi = 0;
      }
      //print(" " + name);
      PImage img = loadImage(inputDir + "\\" + name);

      g.beginDraw();
      g.image(img, SIZE * xi, SIZE * yi);
      g.endDraw();
      xi += 1;
      if (xi >= SPRITES_PER_ROW) {
        xi = 0;
        yi += 1;
        if (yi >= SPRITES_PER_ROW) {
          yi = 0;
          counter += 1;
          g.save("T:\\images\\icons\\" + counter + ".png");
          g = null;
        }
      }
    }
    if (g != null) {
      counter += 1;
      g.save("T:\\images\\icons\\" + counter + ".png");
    }
  }
  noLoop();
  saveFrame(output);
}

void draw() {
  exit();
}
