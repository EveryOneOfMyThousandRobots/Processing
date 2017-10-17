

float sq_TWO_PI = sqrt(TWO_PI);
float e = exp(1);

float f(float x, float mu, float delta) {
  float answer = 0;
  
  float expp = -(pow((x - mu),2))/(2 * delta * delta);
  answer = (1 / sqrt(TWO_PI * delta)) * pow(e,expp);
  
  return answer;
}

float mu(float x) {
  float a = 0;
  
  a = (1 / sq_TWO_PI) * (pow(e, -(0.5 * (x*x))));
  
  return a;
}

float gm(float x, float scale, float deviation) {
  float d = sqrt(deviation);
  float answer = mu((x - scale) / d) * (1 / d);
  
  
  
  
  
  
  return answer;
}


void setup() {
  size(500,500);
 // noLoop();
  // frameRate(2);
}

float delta = 0.1;
void draw() {
  delta += 0.1;
  
  //println(mu(-1));
  //println(mu(0));
  //println(mu(1));
  //println(mu(0.5));
  //background(0);
  //stroke(255);
  //for (float x = 0; x < width; x += 1) {
  // // float xx = map(x, 0, width, -2,2);
  //  float y = f(x, width/2, width / 4);
  //  float yy = map(y, 0, 0.07, height / 2, 0);
    
  //  point(x, yy);
  //}
  background(0);
  loadPixels();
  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      float xx = f(x, width / 2, delta);
      float yy = f(y, width / 2, delta);
      pixels[x + y * width] = color(map(xx+yy, 0, 2, 0, 255));
    }
  }
  updatePixels();
  fill(255);
  text(delta, 10,10);
}