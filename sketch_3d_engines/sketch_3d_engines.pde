class Triangle {
  PVector[] p = new PVector[3];
  Triangle (float x0, float y0, float z0, float x1, float y1, float z1, float x2, float y2, float z2) {

    p[0] = new PVector(x0, y0, z0);
    p[1] = new PVector(x1, y1, z1);
    p[2] = new PVector(x2, y2, z2);
  }
  Triangle() {
    this(0, 0, 0, 0, 0, 0, 0, 0, 0);
  }
}

class Mesh {
  ArrayList<Triangle> tris = new ArrayList<Triangle>();
}

class M4x4 {
  float[][] m = new float[4][4];
}

Mesh meshCube;
M4x4 matProj = new M4x4();
float theta = 0;
PVector camera = new PVector();
void setup() {
  meshCube = new Mesh();
  size(640, 360);
  setupTris();
  matProj = new M4x4();
  // Projection Matrix
  float fNear = 0.1f;
  float fFar = 1000.0f;
  float fFov = 90.0f;
  float fAspectRatio = (float)height / (float)width;
  float fFovRad = 1.0f / tan(fFov * 0.5f / 180.0f * PI);

  matProj.m[0][0] = fAspectRatio * fFovRad;
  matProj.m[1][1] = fFovRad;
  matProj.m[2][2] = fFar / (fFar - fNear);
  matProj.m[3][2] = (-fFar * fNear) / (fFar - fNear);
  matProj.m[2][3] = 1.0f;
  matProj.m[3][3] = 0.0f;
}


void draw() {
  theta += 0.01;
  background(0);

  M4x4 matRotZ = new M4x4();
  M4x4 matRotX = new M4x4();

  // Rotation Z
  matRotZ.m[0][0] = cos(theta);
  matRotZ.m[0][1] = sin(theta);
  matRotZ.m[1][0] = -sin(theta);
  matRotZ.m[1][1] = cos(theta);
  matRotZ.m[2][2] = 1;
  matRotZ.m[3][3] = 1;

  // Rotation X
  matRotX.m[0][0] = 1;
  matRotX.m[1][1] = cos(theta * 0.5f);
  matRotX.m[1][2] = sin(theta * 0.5f);
  matRotX.m[2][1] = -sin(theta * 0.5f);
  matRotX.m[2][2] = cos(theta * 0.5f);
  matRotX.m[3][3] = 1;

  ArrayList<Triangle> toRaster = new ArrayList<Triangle>();


  // Draw Triangles
  for (Triangle tri : meshCube.tris)
  {
    Triangle triProjected = new Triangle();
    Triangle triTranslated= new Triangle();
    Triangle triRotatedZ= new Triangle();
    Triangle triRotatedZX= new Triangle();

    // Rotate in Z-Axis
    MultiplyMatrixVector(tri.p[0], triRotatedZ.p[0], matRotZ);
    MultiplyMatrixVector(tri.p[1], triRotatedZ.p[1], matRotZ);
    MultiplyMatrixVector(tri.p[2], triRotatedZ.p[2], matRotZ);

    // Rotate in X-Axis
    MultiplyMatrixVector(triRotatedZ.p[0], triRotatedZX.p[0], matRotX);
    MultiplyMatrixVector(triRotatedZ.p[1], triRotatedZX.p[1], matRotX);
    MultiplyMatrixVector(triRotatedZ.p[2], triRotatedZX.p[2], matRotX);

    // Offset into the screen
    triTranslated = triRotatedZX;
    triTranslated.p[0].z = triRotatedZX.p[0].z + 3.0f;
    triTranslated.p[1].z = triRotatedZX.p[1].z + 3.0f;
    triTranslated.p[2].z = triRotatedZX.p[2].z + 3.0f;

    // Use Cross-Product to get surface normal
    PVector normal = new PVector();
    PVector line1 = new PVector();
    PVector line2 = new PVector();

    line1.x = triTranslated.p[1].x - triTranslated.p[0].x;
    line1.y = triTranslated.p[1].y - triTranslated.p[0].y;
    line1.z = triTranslated.p[1].z - triTranslated.p[0].z;

    line2.x = triTranslated.p[2].x - triTranslated.p[0].x;
    line2.y = triTranslated.p[2].y - triTranslated.p[0].y;
    line2.z = triTranslated.p[2].z - triTranslated.p[0].z;

    normal.x = line1.y * line2.z - line1.z * line2.y;
    normal.y = line1.z * line2.x - line1.x * line2.z;
    normal.z = line1.x * line2.y - line1.y * line2.x;

    // It's normally normal to normalise the normal
    float l = sqrt(normal.x*normal.x + normal.y*normal.y + normal.z*normal.z);
    normal.x /= l; 
    normal.y /= l; 
    normal.z /= l;

    // Project triangles from 3D --> 2D
    MultiplyMatrixVector(triTranslated.p[0], triProjected.p[0], matProj);
    MultiplyMatrixVector(triTranslated.p[1], triProjected.p[1], matProj);
    MultiplyMatrixVector(triTranslated.p[2], triProjected.p[2], matProj);

    // Scale into view
    triProjected.p[0].x += 1.0f; 
    triProjected.p[0].y += 1.0f;
    triProjected.p[1].x += 1.0f; 
    triProjected.p[1].y += 1.0f;
    triProjected.p[2].x += 1.0f; 
    triProjected.p[2].y += 1.0f;
    triProjected.p[0].x *= 0.5f * (float)width;
    triProjected.p[0].y *= 0.5f * (float)height;
    triProjected.p[1].x *= 0.5f * (float)width;
    triProjected.p[1].y *= 0.5f * (float)height;
    triProjected.p[2].x *= 0.5f * (float)width;
    triProjected.p[2].y *= 0.5f * (float)height;

    // Rasterize triangle
    fill(255, 128);
    stroke(255, 0, 0);
    beginShape();
    vertex(triProjected.p[0].x, triProjected.p[0].y);
    vertex(triProjected.p[1].x, triProjected.p[1].y);
    vertex(triProjected.p[2].x, triProjected.p[2].y);
    endShape(CLOSE);
  }
}
