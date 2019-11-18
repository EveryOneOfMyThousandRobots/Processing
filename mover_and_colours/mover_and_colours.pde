class Mover {

  float movement_angle = 0;
  float movement_angle_inc;
  float path_angle = 0;
  float path_angle_inc = 0;
  float cx, cy;
  float x, y, r ;
  boolean master = false;

  Mover(float cx, float cy, float r, float movement_angle) {
    this.cx = cx;
    this.cy = cy;
    this.r = r;
    path_angle_inc = radians(1);
    movement_angle_inc = 0;
    this.movement_angle = movement_angle;
  }

  void draw() {
    pushMatrix();
    translate(cx, cy);
    rotate(movement_angle);
    stroke(map(path_angle, 0, TWO_PI, 0,255), 255,255);
    fill(map(path_angle, 0, TWO_PI, 0,255), 255,255);
    ellipse(x, y, 20, 20);
    popMatrix();
  }

  void update() {
    path_angle += path_angle_inc;
    if (path_angle > TWO_PI) {
      if (master) {
        NUM_MOVERS += 1;
      }
      path_angle -= TWO_PI;
    }
    x = r * cos(path_angle + movement_angle);
    y = 0;// + r * sin(movement_angle);
    
  }
}
ArrayList<Mover> movers = new ArrayList<Mover>();
float NUM_MOVERS = 1;
void setup() {
  size(400, 400);
  colorMode(HSB);
 
  Mover m = new Mover(width/2, height/2, width/2, 0);
  m.master = true;
  movers.add(m);
  
  background(0);
}


void draw() {
  //background(0);
  fill(0,1);
  noStroke();
  rect(0,0,width,height);
  for (Mover mover : movers) {
    mover.update();
    mover.draw();
  }
  
  while (movers.size() < NUM_MOVERS) {
    movers.add(new Mover(width/2, height/2, width/2, TWO_PI / NUM_MOVERS));
  }
}
