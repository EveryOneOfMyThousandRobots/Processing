PVector mouse;
PVector centre;
PVector[] corners;
PVector[] cornersSub;

void setup() {
  size(640, 360);
  centre = new PVector(width / 2, height / 2);
  mouse = new PVector(0, 0);
  corners = new PVector[4];
  cornersSub = new PVector[4];
  for (int yi = 0; yi < 2; yi++) {
    for (int xi = 0; xi < 2; xi++) {

      PVector c = new PVector(width * xi, height * yi);
      corners[xi + yi * 2] = c;
      print("(" + c.x + "," + c.y + ")");
    }
  }
}

void draw() {
  background(0);
  stroke(255);
  mouse.x = mouseX;
  mouse.y = mouseY;

  for (int i = 0; i < corners.length; i++) {
    PVector p = PVector.sub(mouse, corners[i]);
    cornersSub[i] = p;
  }

  for (int i = 0; i < corners.length; i++) {
    pushMatrix();
    translate(corners[i].x, corners[i].y);
    line(0, 0, cornersSub[i].x, cornersSub[i].y); 
    popMatrix();
  }

  mouse.sub(centre);
  pushMatrix();
  translate(width / 2, height / 2);
  line(0, 0, mouse.x, mouse.y);
  popMatrix();
}