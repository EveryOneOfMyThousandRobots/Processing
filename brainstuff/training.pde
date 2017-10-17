float total, correct;
void train() {
  //boolean printOutput = (frameCount % 1000 == 0 );
  for (int k = 0; k < 100; k += 1) {
    for (int i = 0; i < training.length; i += 1) {
      total += 1;
      float in1 = training[i][0];
      float in2 = training[i][1];
      float expected = training[i][2];

      brain.calc(in1, in2);
      float guess = brain.output.outputs[0];

      brain.adjust(guess - expected);
      addResult(in1 + "," + in2 + " = " + expected + ", guess = " + guess);
      if ((abs(guess - expected)) < 0.01) {
        correct += 1;
      }
    }
  }
}

void addResult(String result) {
  results.add(result);
  if (results.size() > 10) {
    results.remove(0);
  }
}