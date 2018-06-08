Perceptron ptron;
Dataset data;

PVector lineFrom, lineTo, guessFrom, guessTo;
int trainingIdx = 0;
int totalIterations = 0;
void setup() {
  size(400, 400);
  ptron = new Perceptron(3);
  //noLoop();

  data = new Dataset(100);


  lineFrom = new PVector(data.mapX(-1), data.mapY(data.f(-1)));
  lineTo = new PVector(data.mapX(1), data.mapY(data.f(1)));
  
  guessFrom = new PVector(data.mapX(-1), 0);
  guessTo = new PVector(data.mapX(1), 0);
  


  
}


void draw() {
  background(255);
  
  stroke(0);
  line(width / 2, 0, width / 2, height);
  line(0, height / 2, width, height / 2);
  //draw line
  stroke(255,0,0);
   
  line(lineFrom.x, lineFrom.y, lineTo.x, lineTo.y);
  //draw guess
  guessFrom.y = data.mapY(ptron.guessY(-1));
  guessTo.y = data.mapY(ptron.guessY(1));
  stroke(255,255,0);
  line(guessFrom.x, guessFrom.y, guessTo.x, guessTo.y);
  fill(51);
  text(trainingIdx + ": " + ptron.weights[0] + "," + ptron.weights[1], 10, 10);


  //for (int i = 0; i < data.length(); i += 1) {
  ptron.train(data.getLabel(trainingIdx), data.get(trainingIdx).x, data.get(trainingIdx).y, data.get(trainingIdx).z);
  //}
  //trainingIdx = (trainingIdx + 1) % data.length();
  trainingIdx += 1;
  if (trainingIdx >= data.length()-1) {
    trainingIdx = 0;
    ptron.resetError();
  }

  noStroke();
  int correct = 0;
  for (int i = 0; i < data.length(); i += 1) {
    PVector p = data.get(i);
    int guess = ptron.guess(p.x, p.y, p.z);
    if (guess == data.getLabel(i)) {
      correct += 1;
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    ellipse(data.getX(i), data.getY(i), 8, 8);
  }

  data.draw();
  if (correct == data.length()) {
    stop();
    println("done after " + frameCount + " frames");
  }
}
