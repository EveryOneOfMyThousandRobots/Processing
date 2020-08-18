float[][] field;
final int RES = 25;
final int HALF_RES = RES / 2;
final float NOISE_RES = 0.1;
final float RES_HYP = sqrt((RES * RES) + (RES * RES));
int cols, rows;
float zoff = 0;

OpenSimplexNoise noise;

final int Ai = 0;
final int Bi = 1;
final int Ci = 2;
final int Di = 3;
final int ABi = 4;
final int BCi = 5;
final int CDi = 6;
final int DAi = 7;

PVector[][][] vecs;



void setup() {
  size(600, 400, P2D);
  cols = 1+  width / RES;
  rows = 1 + height / RES;
  noise = new OpenSimplexNoise(System.nanoTime());

  field = new float[cols][rows];
  vecs = new PVector[cols][rows][8];

  for (int x = 0; x < cols; x += 1) {
    for (int y = 0; y < rows; y += 1) {
      field[x][y] =0 ;
    }
  }

  for (int x = 0; x < cols; x += 1) {
    for (int y = 0; y < rows; y += 1) {
      float xp = x * RES;
      float yp = y * RES;


      PVector cA = new PVector(xp, yp);
      PVector cB = new PVector(xp+RES, yp);
      PVector cC = new PVector(xp+RES, yp+RES);
      PVector cD = new PVector(xp, yp+RES);

      setVec(x, y, Ai, cA);
      setVec(x, y, Bi, cB);
      setVec(x, y, Ci, cC);
      setVec(x, y, Di, cD);



      PVector pA = PVector.add(cA, PVector.sub(cB, cA).mult(0.5));
      PVector pB = PVector.add(cB, PVector.sub(cC, cB).mult(0.5));
      PVector pC = PVector.add(cC, PVector.sub(cD, cC).mult(0.5));
      PVector pD = PVector.add(cD, PVector.sub(cA, cD).mult(0.5));

      setVec(x, y, ABi, pA);
      setVec(x, y, BCi, pB);
      setVec(x, y, CDi, pC);
      setVec(x, y, DAi, pD);
    }
  }
}

void setVec(int x, int y, int i, PVector P) {
  if (!OOB(x, y)) {
    vecs[x][y][i] = P;
  }
}

void setVec(int x, int y, int i0, PVector P0, int i1, PVector P1) {
  if (!OOB(x, y)) {
    vecs[x][y][i0] = P0;
    vecs[x][y][i1] = P1;
  }
}

boolean OOB(int x, int y) {
  return (x < 0 || x > cols - 1 || y < 0 || y > rows - 1);
}


void draw() {
  zoff = (float)frameCount * 0.001;
  float xoff = 0;
  float yoff = 0;
  background(0);
  textAlign(CENTER, CENTER);
  strokeWeight(3);
  for (int x = 0; x < cols-1; x += 1) {
    xoff = (float) x * NOISE_RES;
    for (int y = 0; y < rows-1; y += 1) {
      yoff = (float) y * NOISE_RES;  
      field[x][y] = (float)noise.eval(xoff, yoff, zoff);
    }
  }

  for (int x = 0; x < cols-1; x += 1) {
    //xoff = (float) x * NOISE_RES;
    for (int y = 0; y < rows-1; y += 1) {
      //yoff = (float) y * NOISE_RES;


      float fa = field[x][y];
      float fb = field[x+1][y];
      float fc = field[x+1][y+1];
      float fd = field[x][y+1];

      float xp = x * RES;
      float yp = y * RES;

      int r = getState(x, y);

      //fill(255);
      //text(r, xp +HALF_RES, yp +HALF_RES);
      noStroke();
      fill(((1 + field[x][y]) / 2) * 255, 128);
      rect(xp, yp, RES, RES);
      int a = fToInt(x, y);
      stroke(((1 + field[x][y]) / 2) * 255, 128);
      // stroke(a * 255);
      strokeWeight(4);
      point(xp, yp);
      stroke(255);

      drawLine(x, y);
      //line a - d / 5 7 8 10

      //if (inList(r, 5, 7, 8, 10)) {
      //  drawLine(a, d);
      //}
      ////line c - d \ 1 14
      //if (inList(r, 1, 14)) {
      //  drawLine(c, d);
      //}      

      ////line b - c / 5 10 2 13
      //if (inList(r, 5, 10, 2, 13)) {
      //  drawLine(b, c);
      //}            

      ////line a - b \ 11 4
      //if (inList(r, 11, 4)) {
      //  drawLine(a, b);
      //}                  


      ////line a - c | 9 6
      //if (inList(r, 9, 6)) {
      //  drawLine(a, c);
      //}                        

      ////line b - d -- 3 12
      //if (inList(r, 3, 12)) {
      //  drawLine(b, d);
      //}
    }
  }
  strokeWeight(1);
}

void drawLine(int x, int y) {
  float fa = field[x][y];
  float fb = field[x+1][y];
  float fc = field[x+1][y+1];
  float fd = field[x][y+1];

  float xp = x * RES;
  float yp = y * RES;
  //PVector a = new PVector(xp + HALF_RES, yp);
  //PVector b = new PVector(xp + RES, yp + HALF_RES);
  //PVector c = new PVector(xp + HALF_RES, yp + RES);
  //PVector d = new PVector(xp, yp + HALF_RES);

  int r = getState(x, y);
  PVector s0 = null, e0 = null, s1 = null, e1 = null;
  ArrayList<PVector> pnts0 = new ArrayList<PVector>();
  ArrayList<Float> flts0 = new ArrayList<Float>(); 
  ArrayList<PVector> pnts1 = new ArrayList<PVector>();
  ArrayList<Float> flts1 = new ArrayList<Float>();

  switch(r) {
  case 15:
  case 0:

    break;
  case 1:
    s0 = vecs[x][y][DAi];
    e0 = vecs[x][y][CDi];
    pnts0.add(vecs[x][y][Di]);
    flts0.add(fd);
    break;
  case 2:
    s0 = vecs[x][y][BCi];
    e0 = vecs[x][y][CDi];
    pnts0.add(vecs[x][y][Ci]);
    flts0.add(fc);
    break;
  case 3:
    s0 = vecs[x][y][BCi];
    e0 = vecs[x][y][DAi];
    pnts0.add(vecs[x][y][Ci]);
    flts0.add(fc);
    pnts0.add(vecs[x][y][Di]);
    flts0.add(fd);
    break;
  case 4:
    s0 = vecs[x][y][ABi];
    e0 = vecs[x][y][BCi];
    pnts0.add(vecs[x][y][Bi]);
    flts0.add(fb);
    break;
  case 5:
    s0 = vecs[x][y][ABi];
    e0 = vecs[x][y][DAi];
    pnts0.add(vecs[x][y][Ci]);
    pnts0.add(vecs[x][y][Di]);
    flts0.add(fc);
    flts0.add(fd);
    break;
  case 6:
    s0 = vecs[x][y][ABi];
    e0 = vecs[x][y][CDi];
    pnts0.add(vecs[x][y][Bi]);
    pnts0.add(vecs[x][y][Ci]);
    flts0.add(fb);
    flts0.add(fc);
    break;
  case 7:
    s0 = vecs[x][y][ABi];
    e0 = vecs[x][y][DAi];
    pnts0.add(vecs[x][y][Bi]);
    pnts0.add(vecs[x][y][Ci]);
    pnts0.add(vecs[x][y][Di]);
    flts0.add(fb);
    flts0.add(fc);
    flts0.add(fd);
    break;
  case 8:
    s0 = vecs[x][y][ABi];
    e0 = vecs[x][y][DAi];
    pnts0.add(vecs[x][y][Ai]);
    flts0.add(fa);

    break;
  case 9:
    s0 = vecs[x][y][ABi];
    e0 = vecs[x][y][CDi];
    pnts0.add(vecs[x][y][Ai]);
    pnts0.add(vecs[x][y][Di]);
    flts0.add(fa);
    flts0.add(fd);
    break;
  case 10:
    break;
  case 11:
    break;
  case 12:
    break;
  case 13:
    break;
  case 14:
    break;
  }

  if (s0 != null && e0 != null) {


    PVector A = s0.copy();
    PVector B = e0.copy();


    for (int i = 0; i < pnts0.size(); i += 1) {
      PVector p = pnts0.get(i);
      float f = constrain(flts0.get(i), 0, 1);



      float distA = PVector.dist(s0, p);
      distA *= distA;
      distA = sqrt(distA) / RES_HYP;
      float distB = PVector.dist(e0, p);
      distB *= distB;
      distB = sqrt(distB) / RES_HYP;

      PVector A0 = p.copy().normalize().mult(1 - f).mult(distA);
      PVector B0 = p.copy().normalize().mult(1 - f).mult(distB);
      A.sub(A0);
      B.sub(B0);
    }

    strokeWeight(1);
    stroke(255);
    line(A.x, A.y, B.x, B.y);
  }

  if (s1 != null && e1 != null) {
    strokeWeight(1);
    stroke(255);
    line(s1.x, s1.y, e1.x, e1.y);
  }
}

void drawLine(PVector A, PVector B) {
  line(A.x, A.y, B.x, B.y);
}

boolean inList(int a, int... list) {
  for (int i = 0; i < list.length; i += 1) {
    if (a == list[i]) {
      return true;
    }
  }
  return false;
}

int fToInt(int x, int y) {
  float f = field[x][y];
  if (f < 0) {
    return 0;
  } else {
    return 1;
  }
}

int getState(int x, int y) {
  int a = fToInt(x, y);
  int b = fToInt(x+1, y);
  int c = fToInt(x+1, y+1);
  int d = fToInt(x, y+1);

  int r = (a << 3) + (b << 2) + (c << 1) + (d << 0);

  return r;
}
