PVector camPos = new PVector(0, 0);
float camAngle = 0;
float camPitch = 5.5;
float camZoom = 16;

PVector[] createCube(Cell cell, float angle, float pitch, float scale, PVector cameraPos) {

  PVector[] unitCube, rotCube, worldCube, projCube;

  unitCube = new PVector[8];

  unitCube[0] = new PVector(0, 0, 0);
  unitCube[1] = new PVector(scale, 0, 0);
  unitCube[2] = new PVector(scale, -scale, 0);
  unitCube[3] = new PVector(0, -scale, 0);
  unitCube[4] = new PVector(0, 0, scale);
  unitCube[5] = new PVector(scale, 0, scale);
  unitCube[6] = new PVector(scale, -scale, scale);
  unitCube[7] = new PVector(0, -scale, scale);


  for (int i = 0; i < 8; i += 1) {
    unitCube[i].x += cell.x * scale - cameraPos.x;
    unitCube[i].y += -cameraPos.y;
    unitCube[i].z += cell.y * scale - cameraPos.z;
  }

  //rotate
  float s = sin(angle);
  float c = cos(angle);
  rotCube = new PVector[8];
  for (int i = 0; i < 8; i += 1) {
    PVector a = new PVector();
    a.x = unitCube[i].x * c + unitCube[i].z * s;
    a.y = unitCube[i].y;
    a.z = unitCube[i].x * -s + unitCube[i].z * c;
    rotCube[i] = a;
  }


  //pitch
  s = sin(pitch);
  c = cos(pitch);
  worldCube = new PVector[8];
  for (int i = 0; i < 8; i += 1) {
    PVector a = new PVector();
    a.x = rotCube[i].x;
    a.y = rotCube[i].y * c - rotCube[i].z * s;
    a.z = rotCube[i].y * s + rotCube[i].z * c;
    worldCube[i] = a;
  }
  //project
  projCube = new PVector[8];
  for (int i = 0; i < 8; i += 1) {
    PVector a = new PVector();
    a.x = worldCube[i].x + (width * 0.5);
    a.y = worldCube[i].y + (height * 0.5);
    a.z = worldCube[i].z;
    projCube[i] = a;
  }




  return projCube;
}
