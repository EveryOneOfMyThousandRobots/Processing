
// Rubiks Cube 1
// Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/142.1-rubiks-cube.html
// https://youtu.be/9PGfL4t-uqE

import peasy.*;

PeasyCam cam;

// UP, DOWN, RIGHT, LEFT, FRONT, BACK
final int UPP = 0;
final int DWN = 1;
final int RGT = 2;
final int LFT = 3;
final int FRT = 4;
final int BCK = 5;

color[] colors = {
  #FFFFFF, #FFFF00, 
  #FFA500, #FF0000, 
  #00FF00, #0000FF
};

final int DIM = 3;
final int TOTAL_CUBIES = (int)pow(DIM, 3);
final float CUBIE_SIDE_LENGTH = 50;
//Cubie[] cube = new Cubie[TOTAL_CUBIES];
Cube cube;

void setup() {
  size(600, 600, P3D); 
  cam = new PeasyCam(this, 400);
  cube = new Cube();
}


//int index =0;
void draw() {
  scale(50);
  background(51); 
  cube.update();
  cube.draw();

  //cube[index].highlight = true;
  //println(index);
  //index = (index + 1) % cube.length;
}


void keyPressed() {
  switch(key) {
  case '1':
    cube.turnZ(-1);
    break;
  case '2': 
    cube.turnZ(1);
  }
}
