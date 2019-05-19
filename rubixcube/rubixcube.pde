import peasy.*;
PeasyCam cam;
final int dim = 3;
Cubie[][][] cube = new Cubie[dim][dim][dim];


//up, down, right, left, front, back;

color[] colours = {
  #ffffff, #ffff00,
  #ffa500, #ff0000,
  #00ff00, #0000ff};
  
final int UPP = 0;
final int DWN = 1;
final int RGT = 2;
final int LFT = 3;
final int FRN = 4;
final int BCK = 5;



void setup() {
  
  size(400, 400, P3D);
  cam = new PeasyCam(this,400);
  float offset = -((SIDE_LENGTH * dim) / 2) + (SIDE_LENGTH / 2);
  for (int i = 0; i < dim; i += 1) {
    float x = i * SIDE_LENGTH;
    for (int j = 0; j < dim; j += 1) {
      float y = j * SIDE_LENGTH;
      for (int k = 0; k < dim; k += 1) {
        
        
        float z = k * SIDE_LENGTH;
        cube[i][j][k] = new Cubie(x+offset,y+offset,z+offset);
      }
    }
  }
}





void draw() {
  background(51);
  for (Cubie[][] cuu : cube) {
    for (Cubie[] cu : cuu) {
      for (Cubie c : cu) {
        c.draw();
      }
    }
  }
}
