void setup() {
  size(300, 300);

  int lrLengthx = 10;//(int)((xmax-xmin)/xres+1);//how many points in the x direction
  int lrLengthy = 10;//(int)((zmax-zmin)/zres+1);//how many points needed in z direction
  PVector[] points = new PVector[lrLengthx*lrLengthy];
  PVector[] uvs = new PVector[lrLengthx*lrLengthy];
  int[] triangles = new int[points.length*6];
  //generate triangles
  background(0);
  int index = 0;

  for (int y = 0; y<lrLengthy; y++) {
    for (int x = 0; x<lrLengthx; x++) {  
      points[y * lrLengthx + x] = new PVector(x * lrLengthx, y * lrLengthy);
    }
  }

  for (int y = 0; y<lrLengthy-1; y++) {
    for (int x = 0; x<lrLengthx-1; x++) {

      uvs[x+y*lrLengthx] = new PVector(x/(lrLengthx-1.0f), y/(lrLengthy-1.0f));
      triangles[index+2]   = x+y*lrLengthx;
      triangles[index+1] = x+1+y*lrLengthx;
      triangles[index+0] = x+y*lrLengthx+lrLengthx;

      triangles[index+3] = x+y*lrLengthx+lrLengthx;
      triangles[index+4] = x+1+y*lrLengthx+lrLengthx;
      triangles[index+5] = x+1+y*lrLengthx;
      index+=6;
    }
  }
  stroke(255);
  noFill();
  for (int i =0; i < triangles.length; i += 6) {
    beginShape();
    for (int j = 0; j < 6; j += 1) {
      PVector p = points[triangles[i +j]];
      vertex(width / 4 + p.x, height / 4 + p.y);
    }

    endShape();
  }

  noLoop();
}
