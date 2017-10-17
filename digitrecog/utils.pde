float exp1 = exp(1);
float sigmoid(float x) {

  return 1.0 / (1.0 + exp(-x));
}

float logistics(float x) {
  return (2 / (1 + pow(exp1, -1 * (x)))) - 1;
}

float[] resetErrors(float[] errors) {
  for (int i = 0; i < errors.length; i += 1) {
    errors[i] = 0;
  }
  
  return errors;
}

float reLU(float x) {
  if (x < 0) {
    return 0;
  } else {

    return x;//constrain(x, 0, 1);
  }
}

float hyperbol(float x) {
  return atan(x);
  //x = constrain(x, -1, 1);
  //float ex = pow(exp1,x);
  //float enx = pow(exp1,-x);

  //return (ex - enx) / (ex + enx);
}

float loopTraining(boolean adjustments, boolean print) {
  float totalError = 0;
  //for (int k = 0; k < 1000; k += 1) {

  for (int i = 0; i < numImages /2; i += 1) {
    loadImageA(i);
    float[] image = getImageArray(loadedImage);
    //float in1 = training[i][0];
    //float in2 = training[i][1];
    //float expectedOutput = training[i][2];


    brain.calc(image);

    float highest = -10000000;
    int highestIndex = -1;
    for (int j = 0; j < brain.output.values.length-1; j += 1) {
      if (brain.output.values[j] > highest) {
        highest = brain.output.values[j];
        highestIndex = j;
      }
    }
    float error = 0; //(expectedOutput - output);
    error =  (highestIndex - currentLabel);


    //println("guess: " + highestIndex + " actual: " + currentLabel);


    if (print) {
      println("guess: " + highestIndex + " actual: " + currentLabel);
      //println("input: " + in1 + "," + in2 + " guess : " + output + " actual : " + expectedOutput + " error: " + error);
    }
    if (adjustments) brain.adjust(error);
    //println(error);

    totalError += error;
  }
  //}
  return totalError / 1000;
}