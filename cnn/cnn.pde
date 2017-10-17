class CNN {
  float[][] rightFilter = {{-1, 0, 1}, {-2, 0, 2}, {-1, 0, 1}};
  float[][] downFilter = {{-1, -2, -1}, {0, 0, 0}, {1, 2, 1}};
  
  PImage rightImg;
  PImage topImg;
  PImage bothImg;
  PImage work;

  CNN(PImage work) {


    this.work = work;

    rightImg = createImage(work.width, work.height, RGB);
    topImg = createImage(work.width, work.height, RGB);
    bothImg =createImage(work.width, work.height, RGB);

    this.work.loadPixels();
    rightImg.loadPixels();
    topImg.loadPixels();
  }

  void process() {

    for (int x = 0; x < work.width; x += 1) {
      for (int y = 0; y < work.height; y += 1) {
        float[][] rightset = new float[3][3];
        float[][] topset = new float[3][3];
        int workcount = 0;
        for (int i = -1; i <= 1; i += 1) {
          for (int j = -1; j <= 1; j += 1) {

            if (x + i >= 0 && x + i < work.width && y + j >= 0 && y + j < work.height) {
              workcount += 1;
              rightset[i+1][j+1] = brightness(work.get(x+i, y+j)) * rightFilter[i+1][j+1];
              topset[i+1][j+1] = brightness(work.get(x+i, y+j)) * downFilter[i+1][j+1];
            }
          }
        }
        float rightTotal = 0;
        float topTotal  = 0;
        //println("right");
        //printArray(rightset[0]);
        //printArray(rightset[1]);
        //printArray(rightset[2]);
        //println("top");
        //printArray(topset[0]);
        //printArray(topset[1]);
        //printArray(topset[2]);
        
        
        for (int i = 0; i < rightset.length; i += 1) {
          for (int j = 0; j <rightset[i].length; j += 1) {
            rightTotal += rightset[i][j];
            topTotal += topset[i][j];
          }
        }
        rightTotal /= workcount;
        rightTotal += 128;
        topTotal /= workcount;
        topTotal += 128;
        //println(total);
        rightImg.set(x, y, color(rightTotal));
        topImg.set(x, y, color(topTotal));
        bothImg.set(x,y, color(sqrt(sq(rightTotal)+sq(topTotal))));
        
        
      }
    }
    rightImg.updatePixels();
    topImg.updatePixels();
  }
}
CNN c;
PImage img;
void setup() {

  c = new CNN(img);
  noLoop();
  c.process();
}

void settings() {
  img = loadImage("flower1.jpg");
  size(img.width * 3, img.height*2);
}

void draw() {
  image(img, 0, 0);
  image(c.rightImg, img.width, 0);
  image(c.topImg, img.width*2, 0);
  image(c.bothImg, img.width, img.height);
}