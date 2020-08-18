class Quad {
  PVector[] points = new PVector[4];
  int textureId;
  
  Quad(PVector v1, PVector v2, PVector v3, PVector v4, int texId) {
    points[0] = v1;
    points[1] = v2;
    points[2] = v3;
    points[3] = v4;
    textureId = texId;
  }
}
