void getFaceQuads(int x, int y, float fAngle, float fPitch, float fScale, PVector vCamera, ArrayList<Quad> render)
{

  Cell cell = world.getCell(x, y); 
  PVector[] projCube = createCube(cell, fAngle, fPitch, fScale, vCamera);





  if (!cell.wall)
  {
    if (cell.visible[FACE_FLOOR]) makeFace(4, 0, 1, 5, FACE_FLOOR, render, projCube, cell);
  } else
  {
    if (cell.visible[FACE_SOUTH]) makeFace(3, 0, 1, 2, FACE_SOUTH, render, projCube, cell);
    if (cell.visible[FACE_NORTH]) makeFace(6, 5, 4, 7, FACE_NORTH, render, projCube, cell);
    if (cell.visible[FACE_EAST])makeFace(7, 4, 0, 3, FACE_EAST, render, projCube, cell);
    if (cell.visible[FACE_WEST]) makeFace(2, 1, 5, 6, FACE_WEST, render, projCube, cell);
    if (cell.visible[FACE_TOP]) makeFace(7, 3, 2, 6, FACE_TOP, render, projCube, cell);
  }
}

void makeFace(int v1, int v2, int v3, int v4, int f, ArrayList<Quad> render, PVector[] projCube, Cell cell) {
  Quad quad =  new Quad(projCube[v1], projCube[v2], projCube[v3], projCube[v4], cell.faces[f]);
  render.add(quad);
}


void takeInput() {
  //println(keyPressed);
  if (keyPressed) {
    //println(key);
    if (key == 'w' || key == 'W') {
      camPitch += 1*dt;
    }
    if (key == 's'|| key == 'S') {
      camPitch -= 1*dt;
    }

    if (key == 'd'|| key == 'D') {
      camAngle += 1*dt;
    }
    if (key == 'a'|| key == 'A') {
      camAngle -= 1*dt;
    }

    if (key == 'q'|| key == 'Q') {
      camZoom += 5*dt;
    }
    if (key == 'z'|| key == 'Z') {
      camZoom -= 5*dt;
    }
  }
}
