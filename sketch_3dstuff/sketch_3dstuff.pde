MyCube cube;
MyCube bigCube;
PVector grav = new PVector(0, 0.1, 0);
PVector angular;
void setup() {
  size(800, 800, P3D);

  bigCube = new MyCube(new PVector(0, 0, 0), new PVector(width, height, width), new PVector(0, 0, 0));

  PVector pos = new PVector(width / 2, height / 2, 1);
  PVector angle = new PVector(0, 0, 0);
  PVector size = new PVector(20, 20, 20);

  cube = new MyCube(pos, size, angle);
  float range = PI / 32;
  float xa = random(-range, range);
  float ya = random(-range, range);
  float za = random(-range, range);
  angular = new PVector(xa, ya, za);
  cube.applyAngularForce(angular);
}

void draw() {
  background(0);
  cube.applyForce(grav);

  cube.update();

  if (cube.pos.x <= bigCube.pos.x || cube.pos.x >= bigCube.pos.x + bigCube.size.x) {
    cube.vel.x *= -1;
    cube.vel.x *= 0.95;
  }
  if (cube.pos.y <= bigCube.pos.y || cube.pos.y >= bigCube.pos.y + bigCube.size.y) {
    cube.vel.y *= -1;
    cube.vel.y *= 0.95;
  }



  cube.draw();
}

void mouseClicked() {
  PVector v = new PVector(mouseX, mouseY);
  PVector nv = cube.pos.copy();
  nv.sub(v);
  float dist = nv.mag();
  nv.z = 0;
  nv.normalize();
  dist = map(dist, 0, width + height, 10, 0);
  nv.mult(dist);
  cube.applyForce(nv);
}