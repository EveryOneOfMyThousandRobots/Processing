class SQ {
  int[][] a = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}};

  SQ () {
    for (int[] l1 : a) {
      for (int i = 0; i < l1.length; i += 1) {
        l1[i] = (int) random(1, 99);
      }
    }
  }
  void draw() {
    float tw = width / 3;
    float th = height / 3;
    for (int i = 0; i < a.length; i++) {

      for (int j = 0; j < a[i].length; j += 1) {
        float x = (tw * j) + (tw / 2);
        float y = (th * i) + (th / 2);
        text(a[i][j], x, y);
      }
    }
  }

  boolean isPerfect() {
    boolean returnValue = true;

    int [] sum = new int[8];

    for (int i = 0; i < a.length; i += 1) {
      for (int j = 0; j < a[i].length; j += 1) {
        sum[i] += a[i][j];
      }
      sum[i + 3] = a[0][i] + a[1][i] + a[2][i];
    }

    sum[sum.length - 2] = a[0][0] + a[1][1] + a[2][2];
    sum[sum.length - 1] = a[2][0] + a[1][1] + a[0][2];
    //println();
    //for (int i : sum) {
    //  print("\t" + i);
    //}

    for (int i = 1; i < sum.length; i += 1) {
      if (sum[i] != sum[i - 1]) {
        returnValue = false;
      }
    }
    return returnValue;
  }
}

SQ sq;
long frames = 0;
void setup() {
  size(500, 500);
  //int maxAttempts = 1000000;
  //int i = 0;
  //while (true) {
  //  if (i % 10000 == 0) {
  //    println(i);
  //  }
  //  sq = new SQ();

  //  if (sq.isPerfect()) {
  //    sq.draw();
  //    println();
  //    break;
  //  }
  //}
}

void draw() {

  sq = new SQ();

  if (sq.isPerfect()) {
    background(0);
    sq.draw();
    text(frameCount, 10, 10);
    println("done!");
    stop();
  } else {

    if (frameCount % 25 == 0) {
      frames = frameCount;

      background(0);
      sq.draw();
      text(frames, 10, 10);
    }
  }
}