final float C = 30;
final float G = 1;
PGraphics particleGraphics;

ArrayList<Photon> particles = new ArrayList<Photon>();
int targetPhotons = 0;
BlackHole m87;
float start_height, end_height;
void setup() {
  size(800, 800);

  ellipseMode(RADIUS);
  m87 = new BlackHole(width /2, height / 2, 2500);
  println(m87);

  start_height = height;
  end_height = 0 ;//height / 2- (m87.rs * 2.6);


  

  particleGraphics = createGraphics(width, height);
  particleGraphics.beginDraw();
  particleGraphics.colorMode(HSB);
  colorMode(HSB);
  particleGraphics.background(255);
  

  for (float y = end_height; y < start_height; y += 2) {
    particles.add(new Photon(1, y, C));
    particles.add(new Photon(width-1, y+1, -C));
  }
  targetPhotons = particles.size();
  particleGraphics.endDraw();
}

float timeNow, timeLast, deltaTime;
float delta = 0;
final float dt = 1.0 / 30.0;


void draw() {
  timeNow = millis();
  deltaTime = timeNow - timeLast;
  timeLast = timeNow;
  delta = (deltaTime/1000.0) / dt;

  background(255);

  particleGraphics.beginDraw();
  for (Photon p : particles) {
    m87.attract(p);
    p.update();
    p.draw();
  }

  //particleGraphics.fill(255, 0, 255, 10);
  //particleGraphics.noStroke();
  //particleGraphics.rect(0, 0, width, height);

  particleGraphics.endDraw();

  for (int i = particles.size() -1; i >= 0; i -= 1) {
    Photon p = particles.get(i);
    if (p.dead) {
      particles.remove(i);
    }
  }

  //while (particles.size() < targetPhotons) {
  //  particles.add(new Photon(width - 20, random(0, height)));
  //}
  image(particleGraphics, 0, 0);
  m87.draw();
  stroke(0);
  text(deltaTime + "\n" + delta, 10, 10);
}
