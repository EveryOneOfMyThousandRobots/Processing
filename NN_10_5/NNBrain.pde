class NeuralNetwork {
  final int numInputs, numHidden, numOutputs;
  Matrix input;
  Matrix hidden, hiddenWeights, hiddenBias;
  Matrix output, outputWeights, outputBias;
  float learningRate;

  NeuralNetwork(int numInputs, int numHidden, int numOutputs) {
    this.numInputs = numInputs;
    this.numHidden = numHidden;
    this.numOutputs = numOutputs;

    input = new Matrix(numInputs, 1);

    hiddenWeights = new Matrix(numHidden, numInputs);
    outputWeights = new Matrix(numOutputs, numHidden);
    hiddenWeights.randomise(-1, 1);
    outputWeights.randomise(-1, 1);
    
    hiddenBias = new Matrix(numHidden, 1);
    outputBias = new Matrix(numOutputs, 1);
    hiddenBias.randomise(-1,1);
    outputBias.randomise(-1,1);
    
    learningRate = 0.1;
  }

  Matrix feedForward() {
    

    hidden = Matrix.matrixProduct(hiddenWeights,input);
    hidden.add(hiddenBias);
    hidden.setSigmoid();
    
    output = Matrix.matrixProduct(outputWeights,hidden);
    output.add(outputBias);
    output.setSigmoid();



    return output;
  }

  void setInput(float... inputs) {
    if (inputs.length == numInputs) {


      input.clear();
      for (int i = 0; i < inputs.length; i += 1) {
        input.set(i, 0, inputs[i]);
      }
    } else {
      println("size mismatch");
    }
  }
  
  void training(float[][] trainingData, float[][] targets) {
    for (int i = 0; i < trainingData.length; i += 1) {
      setInput(trainingData[i]);
      Matrix outputs = feedForward();
      
      
      Matrix targetMx = Matrix.fromArray(targets[i]);
      //
      Matrix errorMx = Matrix.sub(targetMx, outputs);
      println("\ninput");
      input.display();
      println("\nerror");
      errorMx.display();
    }
    
  }


}
