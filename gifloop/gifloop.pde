int totalFrames = 120;
int counter = 0;
float percent = 0;
boolean record = false;
color start;// = color(128,128,128);
color end;// = color(128,128,128);
void setup() {

  size(400, 400);
  colorMode(HSB);

}

void draw() {


  percent = ((float)counter) / ((float)totalFrames);

  render(percent);
  if (record) {
    counter += 1;
  } else {

    counter = frameCount % totalFrames;
  }
  if (record) {
    saveFrame("output/gif"+nf(counter, 3)+".png");
    if (counter > totalFrames) {
      noLoop();
    }
  }
  //fill(255);
  //text(counter + " " + nfc(percent, 2), 10, 10);
}


void render(float p) {
  float angle = p * TWO_PI;
  color c = color(map(sin(angle), -1, 1, 0, 128), 255, 255);
  float xpos = map(sin(angle), -1, 1, 0, width);
  float ypos = map(cos(angle*2), -1, 1, -5, 5);
  
  background(0);
  fill(c);
  circle(p * width, height / 2, 4);
  square(xpos, height/4 + ypos,4);
  noFill();
  stroke(c);
  pushMatrix();
  translate(width / 2, height / 2);
  rectMode(CENTER);
  strokeWeight(2);
  rotate(angle);
  square(0, 0, 50);
  popMatrix();
}
