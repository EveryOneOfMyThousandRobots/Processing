PImage bg;


void settings() {
  bg = loadImage("stripes.jpg");
  size(bg.width, bg.height);
}

void setup() {
  //size(800,600);


  noLoop();
}

PImage grindle(PImage p) {
  Delay red   = new Delay(floor(random(50, 500)), random(0.1), true, false, false);
  //red.randomRange = 2;
  Delay green = new Delay(floor(random(50, 500)), random(0.1), false, true, false);
  //green.randomRange = 2;
  Delay blue  = new Delay(floor(random(50, 500)), random(0.1), false, false, true);
  //blue.randomRange = 2;

  //d.output = i
  red.process(p);
  green.process(red.output);
  blue.process(green.output);
  
  return blue.output;
}



void draw() {
  background(0);
  Delay d = new Delay(random(100), random(0.4));
  d.procReverse(grindle(bg));
  
  //PImage a = (grindle(bg));
  
  image(d.output, 0, 0);
  
}
