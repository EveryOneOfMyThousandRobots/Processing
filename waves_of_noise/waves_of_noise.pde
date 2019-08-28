float x= 0;
float y = 0;
float px, py;
int steps = 10;
int res;

float nx, ny, nz;
float na, nai, nr;

float z_mid, z_range, z_angle, z_angle_inc;
void setup() {
  frameRate(1000);
  size(900,400);
  res = height / steps;
  randomSeed(1);
  nx = random(100);
  ny = random(100);
  z_mid = random(100);
  z_range = random(10);
  z_angle = 0;
  z_angle_inc = radians(1);
  nai = TWO_PI / width;
  na = 0;
  nr = random(1,5);
  px = 0;
  py = height / 2;
  background(0);
  stroke(255);
  for(int yy = 0; yy < height; yy += res) {
    line(0,yy,width,yy);
  }
}


void draw() {
  //background(0);
  na += nai;
  if (na > TWO_PI) {
    na -= TWO_PI;
    z_angle += z_angle_inc;
    z_angle %= TWO_PI;
    
  }
  
  nz = z_mid + (z_range * sin(z_angle));
  
  float nnx = nx + nr * cos(na);
  float nny = ny + nr * sin(na);
  
  y = noise(nnx,nny,nz);
  y = map(y, 0,1,0,height);
  x += 0.5;
  if (x > width-1){
    x = 0;
    //background(0);
    px = 0;
  }
  stroke(255,128);
  line(px,py,x,y);
  px = x;
  py = y;
  
  
}
