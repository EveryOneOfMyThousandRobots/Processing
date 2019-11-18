PVector start, end;
ArrayList<Noise> nse = new ArrayList<Noise>();
void setup() {

  size(800, 800);
  start = new PVector(0, height/2);
  end = new PVector(width-1, height/2);
  background(0);


  for (int i = 0; i < floor(random(10, 20)); i += 1) {
    nse.add(new Noise());
  }

  float cx = width / 2;
  float cy = height / 2;
  float r = width / 4;
  float a = 0;
  float ai = TWO_PI / 360;

  for (a = 0; a < TWO_PI; a += ai) {
    float x = cx + r * cos(a);
    float y = cy + r * sin(a);
    path.add(new PVector(x, y));
  }
}
int noiseIndex = -1;

ArrayList<PVector> path = new ArrayList<PVector>();

float getNoise(int x) {
  return nse.get(x).update();
}
float getNextNoise() {

  noiseIndex += 1;
  if (noiseIndex > nse.size()-1) {
    noiseIndex = 0;
  }

  return nse.get(noiseIndex).update();
}

class Noise {

  float angle, angleInc;
  float x, y, z;
  float cx, cy;
  float r;
  Noise() {
    angle = random(TWO_PI);
    angleInc = radians(random(0.1, 1));
    z = random(-20, 20);
    cx = random(-20, 20);
    cy = random(-20, 20);
    r = random(1, 10);
  }

  float update() {
    angle += angleInc;
    if (angle > TWO_PI) {
      angle -= TWO_PI;
    }
    x = cx + r * cos(angle);
    y = cy + r * sin(angle);
    return noise(x, y, z);
  }
}
float t = 0;

float angle = random(TWO_PI);
float angle2 = random(TWO_PI);
float radiusAngle = 0;
float radiusAngle2 = 0;

void draw() {
  angle += radians(getNoise(0));
  angle2 += radians(getNoise(1)*2);
  radiusAngle += radians(getNoise(2)*10);
  radiusAngle2 += radians(getNoise(3)*2);
  int index = floor(map(t, 0, 1, 0, path.size()));

  PVector pos = path.get(index);

  int nextIndex = (index + 1) % path.size();
  PVector nextPos = path.get(nextIndex);
  PVector dir = PVector.sub(nextPos, pos).normalize();

  PVector dirRA = new PVector(-dir.y, dir.x);
  float n = sin(angle + angle2) + (cos(radiusAngle + radiusAngle2) * 30);
  dirRA.mult(n);
  dirRA.add(pos);
  stroke(255);
  fill(255);
  ellipse(pos.x, pos.y, 3, 3);
  ellipse(dirRA.x, dirRA.y, 4, 4);
  noStroke();







  //  float x = pos.x;// + (20 * abs(radiusAngle)) * cos(angle);
  //  float y = pos.y + ((height/4) * cos(radiusAngle)) * sin(angle);
  //  fill(255, 128);
  //  ellipse(x, y, 5, 5);

  //  float x2 = pos.x;// + (20 * abs(radiusAngle)) * cos(angle);
  //  float y2 = pos.y + ((height/4) * cos(radiusAngle2)) * sin(angle2);
  //  fill(255, 0, 0, 128);
  //  ellipse(x2, y2, 5, 5);

  //  float y3 = (y + y2) / 2f;
  //  fill(255, 255, 0, 128);
  //  ellipse(pos.x, y3, 6, 6);

  t += 1.0f / path.size();
  if (t >= 1) {
    t = 0;
  }
}
