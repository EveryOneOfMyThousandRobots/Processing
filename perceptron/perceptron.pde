

float LEARN_RATE = 0.01;
Perceptron brain;

void setup() {
  size(400, 400);
  brain = new Perceptron();
  //frameRate(2);

  initPoints();
  noLoop();
}

void iterateTraining() {
  for (Point p : points) {

    brain.train(p.inputs, p.label);
    if (brain.lastGuess == p.label) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    ellipse(p.x, p.y, 8, 8);
  }
}

void draw() {

  //println(frameCount + " " + brain.totalError);
  //printArray(brain.weights);
  //println("");

  background(255);
  brain.totalError = 0;
  noStroke();


  drawPoints();


  //if (frameCount % 20 == 0 ) {

  //}
}