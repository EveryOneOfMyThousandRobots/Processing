PShape skull;

void setup() {
  size(512, 512, P3D);
  skull = loadShape("skull.obj");
  skull.rotateX(HALF_PI);
  PVector vrtx = new PVector();
  for (int i = 0; i < skull.getVertexCount(); i += 1) {
    skull.getVertex(i,vrtx);
    
    vrtx.x *= random(-1,1);
    skull.setVertex(i,vrtx);
  }
}

void draw() {
  background(255);
  lightFalloff(1, 0, 0);
  lightSpecular(0, 0, 0);
  ambientLight(128, 128, 128);
  directionalLight(128, 128, 128, 0, 0, -1);
  camera(0, 0, 100, 
    0, 0, 0, 
    0, 1, 0);
  shape(skull);
  skull.rotateY(0.01);
}
