ArrayList<PVector> points = new ArrayList<PVector>();
float cx, cy, r;
float numInside, numOutside, numThrows;
float myPI;
float error;
float lowestError = Float.MAX_VALUE;


void setup() {
  size(200, 200);

  cx = width / 2;
  cy = height / 2;
  r = width / 2;
  stroke(255);
  background(0);
  //myPIA = new float[1];
}



void draw() {

  for (int i = 0; i < 1000; i += 1) {
    float x = random(width);
    float y = random(height);
    numThrows += 1;
    float dist = dist(x, y, cx, cy);
    if (dist < r) {
      numInside += 1;
      stroke(255);
    } else {
      numOutside += 1;
      stroke(255, 0, 0);
    }

    point(x, y);
  }

  noStroke();
  fill(0);
  rect(0, 0, width, 30);
  fill(255);
  if (frameCount % 100 == 0) {
    myPI = (4.0) * (numInside / numThrows);
    error = (PI - myPI);
    if (abs(error) < lowestError) {
      lowestError = error;
    }
    
  }

  text(str(myPI), 20, 10);
  text(str(error) + " " + str(lowestError), 20, 20);
  
}
