import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
float shapeError = 100;
float lerpFactor = 0.01;
class SuperShape {
  float m, n1, n2, n3;
  float a = 1, b = 1; 
  //float error = 0;

  SuperShape(float m, float n1, float n2, float n3) {
    this.m = m;
    this.n1 = n1;
    this.n2 = n2;
    this.n3 = n3;
  }

  SuperShape copy() {
    return new SuperShape(m, n1, n2, n3);
  }

  void shapelerp(SuperShape o) {
    m = lerp(m, o.m, lerpFactor);
    n1 = lerp(n1, o.n1, lerpFactor);
    n2 = lerp(n2, o.n2, lerpFactor);
    n3 = lerp(n3, o.n3, lerpFactor);

    shapeError = abs(m - o.m) + abs(n1 - o.n1) + abs(n2 - o.n2) + abs(n3 - o.n3);
  }
}



SuperShape s11 = new SuperShape(7, 0.2, 1.7, 1.7);
SuperShape s12 = new SuperShape(7, 0.2, 1.7, 1.7);
SuperShape s21 = new SuperShape(8, 60, 100, 30);
SuperShape s22 = new SuperShape(2, 10, 10, 10 );

SuperShape current1 = s11.copy();
SuperShape current2 = s12.copy();
SuperShape target1 = s21;
SuperShape target2 = s22;
SuperShape notTarget1 = s11;
SuperShape notTarget2 = s12;







PeasyCam cam;
PVector[][] globe;
int res = 75;
float radius = 200;

void setup() {
  size(600, 600, P3D);
  //noLoop();
  cam = new PeasyCam(this, 800);
  globe= new PVector[res+1][res+1];
  colorMode(HSB);


  for (int i = 0; i < globe.length; i += 1) {
    for (int j = 0; j < globe[i].length; j += 1) {
      globe[i][j] = new PVector(0, 0, 0);
    }
  }
}

float r2(float theta) {
  float r2 = superShape(theta, current2);
  
  return r2;
}

float r1(float theta) {
  float r2 = superShape(theta, current1);
  //current1.shapelerp(target1);
  return r2; 
 
}

float a = 1;
float b = 1;

float superShape(float theta, SuperShape s) {
  return superShape(theta, s.m, s.n1, s.n2, s.n3);
}
float superShape(float theta, float m, float n1, float n2, float n3) {
  //float r = 1;

  float t1 = abs((1 /a) * cos(m * theta / 4));
  t1 = pow(t1, n2);

  float t2 = abs(((1 / b) * sin( m * theta / 4)));
  t2 = pow(t2, n3);

  float t3 = t1 + t2;
  t3 = pow(t3, - 1 / n1);




  return t3;
}

void calc() {
  for (int i =0; i < res+1; i += 1) {
    float lat = map(i, 0, res, -HALF_PI, HALF_PI);
    float r2 = r2(lat); //superShape(lat, 7, 0.2, 1.7, 1.7);
    for (int j = 0; j < res+1; j += 1) {
      float lon = map(j, 0, res, -PI, PI);



      float r1 = r1(lon); //superShape(lon, 7, 0.2, 1.7, 1.7);
      float x = radius * r1 * r2 * cos(lon) * cos(lat);
      float y = radius * r1 * r2 * sin(lon) * cos(lat);
      float z = radius * r2 * sin(lat);


      globe[i][j].set(x, y, z);
    }
  }
  current1.shapelerp(target1);
  current2.shapelerp(target2);
}
float hue_offset = 0;
void draw() {
  hue_offset += 0.1;
  background(0);
  fill(255);
  lights();
  //translate(width / 2, height / 2);
  //stroke(255);
  noStroke();
  //fill(128);
  //noFill();
  //sphere(width / 4);
  calc();

  //int res = 100;

  for (int i = 0; i < res; i += 1) {
    //if (i % 2 == 0) {
    //  fill(255);
    //} else {
    //  fill(0);
    //}
    float hue = hue_offset + map(i, 0, res, 0, 1000.0);
    fill(hue % 255, 255, 255);
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < res+1; j += 1) {


      PVector p1 = globe[i][j];// = new PVector(x, y, z);
      PVector p2 = globe[i+1][j];

      vertex(p1.x, p1.y, p1.z);
      vertex(p2.x, p2.y, p2.z);
    }
    endShape();
  }
  
  if (shapeError < 0.1) {
    println(frameCount + " swapping");
    SuperShape hold1 = target1;
    SuperShape hold2 = target2;
    current1 = target1.copy();
    current2 = target2.copy();
    target1 = notTarget1;
    target2 = notTarget2;
    notTarget1 = hold1;
    notTarget2 = hold2;
  }
}