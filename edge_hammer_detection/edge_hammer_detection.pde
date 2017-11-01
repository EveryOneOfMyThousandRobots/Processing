ArrayList<PImage> images = new ArrayList<PImage>();

PImage process (PImage imgInput, float[][] filter) {
  PImage out = createImage(imgInput.width-2, imgInput.height-2, RGB);

  imgInput.loadPixels();
  out.loadPixels();
  for (int x = 1; x < imgInput.width-1; x += 1) {
    for (int y = 1; y < imgInput.height-1; y += 1) {
      float sum = 0;
      for (int i = 0; i < 3; i += 1) {
        int xi = x + (i-1);

        for (int j = 0; j < 3; j += 1) {
          int yj = y + (j-1);
          sum += brightness(imgInput.get(xi, yj)) * filter[i][j];
        }
      }
      sum /= 9;
      sum = map(sum, -128, 128, 0, 255);
      out.set(x-1, y-1, color(sum));
    }
  }

  out.updatePixels();

  return out;
}

PImage combine(PImage imgX, PImage imgY) {

  imgX.loadPixels();
  imgY.loadPixels();
  PImage out = createImage(imgX.width, imgX.height, RGB);
  out.loadPixels();

  for (int x = 0; x < imgX.width; x += 1) {
    for (int y = 0; y < imgX.height; y += 1) {
      float xc = brightness(imgX.get(x, y));
      float yc = brightness(imgY.get(x, y));
      float b = sqrt((xc * xc) + (yc * yc));
      //println(x + "," + y + " xc:" + xc + " yc:" + yc + " = " + b);
      out.set(x, y, color(b));
    }
  }
  out.updatePixels();

  return out;
}
//-1 | 0 | 1
//-2 | 0 | 2
//-1 | 0 | 1

//
float[][] yfilter = {{-1, 0, 1}, {-2, 0, 2}, {-1, 0, 1}};
float[][] xfilter = {{-1, -2, -1}, {0, 0, 0}, {1, 2, 1}};


PImage test, outX, outY, both;

float[][] getRandomFilter() {
  float[][] out = new float[3][3];

  

  return out;
}

int across, down;
void setup () {
  size(600, 600);
  test = loadImage("0.png");
  //outX = process(test, xfilter);
  //outY = process(test, yfilter);
  //both = combine(outX, outY);
  PImage a = process(test, xfilter);
  PImage b = process(test, yfilter);
  images.add(a);
  images.add(b);
  PImage c = combine(a, b);
  images.add(c);
  across = width / 26;
  down = height / 26;

  for (int i = 0; i < 3; i += 1) {

    a = process(c, xfilter);
    b = process(c, yfilter);
    images.add(a);
    images.add(b);
    c = combine(a,b);
    images.add(c);
  }




  noLoop();
}

void draw() {
  background(0);
  image(test, 0, 0);
  int index = -1;

  for (int row = 1; row < down; row += 1) {
    for (int col = 0; col < across; col += 1) {
      index += 1;
      if (index < images.size()) {
        image(images.get(index), col * 26, row * 26);
      } else {
        break;
      }
    }
  }
  //stroke(255);
  //noFill();
  //rect(test.width, 0, outX.width+1, outX.height+1);
  //image(outX, test.width, 0);
  //rect(test.width*2, 0, outX.width+1, outX.height+1);
  //image(outY, test.width*2, 0);

  //rect(0, test.height + 10, both.width+1, both.height+1);
  //image(both, 0, test.height + 10);
}