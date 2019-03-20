boolean record = false;
float counter = 0;
final float TOTAL_FRAMES = 120;
float percent = 0;


final float P0 = 0;
final float P1 = 0.1;
final float P2 = 0.2;
final float P3 = 0.3;
final float P4 = 0.4;
final float P5 = 0.5;
final float P6 = 0.6;
final float P7 = 0.7;
final float P8 = 0.8;
final float P9 = 0.9;


void setup() {
  size(400, 400, P3D);
  background(0);
  noiseSeed(1);
}

void draw() {



  percent = counter / TOTAL_FRAMES;

  render();
  if (record) {
    counter += 1;
  } else {
    counter = floor(frameCount % TOTAL_FRAMES);
  }


  if (record) {
    if (counter > TOTAL_FRAMES) {
      exit();
    } else {
      saveFrame("output/f###.png");
    }
  }
}
float gx, gy, gz;
float r = width / 2;

void render() {

  noStroke();
  fill(0, 10);
  rect(0, 0, width, height);
  float angleTheta = TWO_PI * percent;
  //float angleDelta = TWO_PI * percent;
  translate(width / 2, height / 2, 100);
  gx = cos(angleTheta);
  gy = sin(angleTheta);
  for (float angleDelta = 0; angleDelta < TWO_PI; angleDelta += radians(5)) {
    pushMatrix();


    float px = r * sin(angleTheta) * cos(angleDelta);
    float py = r * sin(angleTheta) * sin(angleDelta);
    float pz = r * cos(angleTheta);

    stroke(255);
    //px += noise(gx, gy, P0) * 0.5;
    //py += noise(gx, gy, P1) * 0.5;
    //pz += noise(gx, gy, P2) * 0.5;
    translate(px, py, pz);
    box(2);

    popMatrix();
  }
}
