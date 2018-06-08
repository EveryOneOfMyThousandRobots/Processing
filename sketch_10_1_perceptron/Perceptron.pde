class Perceptron {
  float totalError = 0;
  float[] weights;// = new float[3];

  Perceptron (int numInputs) {
    weights = new float[numInputs];
    for (int i = 0; i < weights.length; i += 1) {
      weights[i] = random(-1, 1);
    }
  }
  
  void resetError() {
    totalError = 0;
  }

  int guess(float... inputs) {

    float sum = 0;
    for (int i = 0; i < weights.length; i += 1) {
      sum += inputs[i] * weights[i];
    }

    return sign(sum);
  }


  void train(int target, float... inputs) {
    int guess = guess(inputs);
    float error = target - guess;
    totalError += error;
    for (int i = 0; i < weights.length; i += 1) {
      weights[i] += error * inputs[i] * learningRate;
    }
  }
  
  float guessY(float x) {
    float w0 = weights[0];
    float w1 = weights[1];
    float w2 = weights[2];
    
    return -(w2/w1) - (w0/w1) * x;
    
    
  }
}
