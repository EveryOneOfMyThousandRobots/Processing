class Wave {
  private float a ;
  private float r;
  private float i;
  private float ri;
  
  Wave(float a, float r, float i) {
    this.a = a;
    this.r = r;
    this.i = i;
    ri = radians(i);
  }
  
  float getAngle() {
    return a;
  }
  float getRadius() {
    return r;
  }
  
  void update() {
    a += ri;
    if (a >= TWO_PI) {
      a -= TWO_PI;
    }
      
  }
}

ArrayList<Wave> waves = new ArrayList<Wave>();

float lx, ly;
float x = 0;
float y = 0;


void setup() {
  size(400,400);
  background(255);
  lx = 0;
  ly = height / 2;
  
  waves.add(new Wave(0, width / 16, 2));
  waves.add(new Wave(0, width / 16, 12));
  waves.add(new Wave(0, width / 8, 15));
}



void draw() {
  noStroke();
  fill(255,255,255, 8);
  rect(0,0,width, height);

  
  x += 2;
  if (x >= width) {
    lx = 0;
    
    x = 0;
   // background(255);
  }
  y = (height / 2);
  int i = 0;
  for (Wave wave : waves) {
    
    wave.update();
    float wy = (height / 2) + (wave.getRadius()) * sin(wave.getAngle());
    stroke(255,(255 / waves.size()) * i,0);
    fill(255,(255 / waves.size()) * i,0);
    ellipse(x, wy, 2, 2);
    y += wave.getRadius() * sin(wave.getAngle());
    i += 1;
  }
  
  fill(0);
  stroke(0);
  strokeWeight(4);
  line(lx, ly, x,y);
  lx = x;
  ly = y;
  
  strokeWeight(1);
  line(0, height / 2, width, height / 2);
  
  
}