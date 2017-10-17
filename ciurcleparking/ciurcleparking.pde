ArrayList<Circle> circles = new ArrayList<Circle>(100);
ArrayList<PVector> points = new ArrayList<PVector>();

PImage img;

void setup () {

  //size(640, 480);
  img.loadPixels();
  
  
  for (int x = 0; x < img.width; x += 1) {
    for (int y = 0; y < img.height; y += 1) {
      int i = img.get(x,y) & 0xffffff;
      if (i > 0) {
        points.add(new PVector(x,y));
      }
    }
  }
  colorMode(HSB);

  Circle c = findEmptySpace();
  if (c != null) {
    circles.add(c);
  }
  //frameRate(3);
}

void settings() {
  img = loadImage("lozzy.png");
  size(img.width, img.height);
  
}

Circle findEmptySpace() {

  int r = floor(random(points.size()));
  PVector p = points.get(r);
  
  float x = p.x;
  float y = p.y;
  PVector newPos = new PVector(x, y);
  boolean valid = true;
  for (Circle circle : circles) {
    float dist = PVector.dist(circle.pos, newPos);
    if (dist < circle.r) {
      valid = false;
      
      break;
    }
  }
  points.remove(r);
  if (valid) {
    return new Circle(x, y);
  } else {
    return null;
  }
}

void draw() {
  background(0);

  for (Circle circle : circles) {
    if (circle.growing && circle.touchedAnything()) {
      circle.growing = false;
    }
    if (circle.growing) {
      circle.grow();
    }
    circle.draw();
  }
  int total = 20;
  int count = 0;
  int attempts = 0;
  while (count < total) {
    Circle c = findEmptySpace();
    if (c != null) {
      circles.add(c);
      count += 1;
    }
    attempts += 1;
    if (attempts > 1000 || points.size() == 0) {
      noLoop();
      println("finished");
      break;
    }
  }
  fill(255);
  text(points.size(), 10, 10);
  
  
}