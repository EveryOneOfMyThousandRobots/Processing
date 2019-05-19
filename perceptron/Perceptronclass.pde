class Perceptron {
  float[] weights = new float[2];
  float totalError = 0;
  int lastGuess = 0;
  
  ///--------------------Constructor----------------------
  Perceptron() {
    //init weights
    for (int i = 0; i < weights.length; i += 1) {
      weights[i] = random(-1,1);
    }
    
    //
  }
  
  
  int guess(float[] inputs) {
    float sum = 0;
    for (int i = 0; i < weights.length; i += 1) {
      sum += inputs[i] * weights[i];
    }
    
    lastGuess = sign(sum);
    return lastGuess;
    
  }
  //activation function
  int sign(float s) {
    if (s >= 0) {
      return 1;
    } else {
      return -1;
    }
  }
  
  

  void train(float[] inputs, int target) {
    int g = guess(inputs);
    //println("in: (" + inputs[0] + "," + inputs[1] + ")\t=\t" + target + "\tg = " + g);
    float error =  target - g;
    totalError += error;
    for (int i = 0; i < weights.length; i += 1) {
      weights[i] += inputs[i] * error * LEARN_RATE;
    }
    
  }
}