//brain has input, hidden and output layers
NeuralNetwork nn;
float[][] training = {{0, 1}, {1, 0}, {1, 1}, {0, 0}};
float[][] answers  = {{1}, {1}, {0}, {0}};
void setup() {
  size(400, 400);
  Matrix.init(this);

  nn = new NeuralNetwork(2, 4, 1);
  

  //for (int i = 0; i < training.length; i += 1) {
  //  nn.setInput(training[i]);
  //  println("\ninput: " + i );
  //  printArray(training[i]);
  //  printArray(nn.feedForward().toArray());
  //}
}

void draw() {
  background(0);
  nn.training(training,answers);
  text(nn.totalError, 10, 10);
}
