final int W = 400;
final int H = 400;
final int TS = 10;
final int TX = 40;
final int TZ = 40;
final int TH = 50;
int startY;

float[][] tH;
float[][] tX;
float[][] tY;
float[][] tZ;
float[][] tA;


void setup() {
  size(400, 400, P3D);
  startY = (int) (height * 0.8);
  tH = new float[TX][TZ];
  tA = new float[TX][TZ];
  tX = new float[TX][TZ];
  tY = new float[TX][TZ];
  tZ = new float[TX][TZ];

  for (int x = 0; x < TX; x += 1) {
    for (int z = 0; z < TZ; z += 1) {
      tH[x][z] = TH;
      tX[x][z] = x * TS;
      tY[x][z] = startY;
      tZ[x][z] = -300 + (z * TS);
      tA[x][z] = TWO_PI * ((float) (x + z) / (float)(TX+TZ) );
    }
  }
}


void draw() {
  background(0);
  pushMatrix();
  rotateX(-QUARTER_PI);
  rotateY(QUARTER_PI);
  
  translate(width/2, 0, 0);

  for (int x = 0; x < TX; x += 1) {
    for (int z = 0; z < TZ; z += 1) {
      tA[x][z] += radians(1);
      tH[x][z] = TH + ((TH/2) * sin(tA[x][z]));
      tY[x][z] = startY - (tH[x][z]/2);


      float xp = tX[x][z];
      float zp = tZ[x][z];
      float yp = tY[x][z];
      float h = tH[x][z];

      pushMatrix();
      translate(xp, yp, zp);

      box(TS, h, TS);
      popMatrix();
    }
  }
  popMatrix();
}
