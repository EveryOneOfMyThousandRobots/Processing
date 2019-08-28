// Rubiks Cube 1
// Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/142.1-rubiks-cube.html
// https://youtu.be/9PGfL4t-uqE


class Cubie {
  PMatrix3D matrix;
  final float len;
  boolean highlight = false;
  int x, y, z;

  Cubie(PMatrix3D pos, int x, int y, int z) {
    this.matrix = pos;
    len = CUBIE_SIDE_LENGTH;
    this.x = x;
    this.y = y;
    this.z = z;
  }

  void update(float nx, float ny, float nz) {
    matrix.reset();
    matrix.translate(round(nx), round(ny), round(nz));
    this.x = round(nx);
    this.y = round(ny);
    this.z = round(nz);
  }

  void draw() {
    if (highlight) {
      fill(255, 0, 0, 128);
    } else {
      fill(255, 128);
    }
    stroke(0);
    strokeWeight(0.1);
    pushMatrix(); 
    applyMatrix(matrix);

    box(1);


    //box(len);
    popMatrix();
  }
}
