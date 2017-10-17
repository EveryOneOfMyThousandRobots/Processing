float learningRate = 0.05;
float mutationRate = 0.01;
class Layer {
  float values[];
  float weights[][];
  float holdInputs[];


  Layer(int numPrevLayer, int numThisLayer) {
    values = new float[numThisLayer+1];
    weights = new float[numPrevLayer+1][numThisLayer+1];

    for (int i = 0; i < weights.length; i += 1) {
      for (int j = 0; j < weights[i].length; j += 1) {
        weights[i][j] = random(-1, 1);
      }
    }
  }

  void draw(float sx, float sy) {
    for (int i = 0; i < weights.length; i += 1) {
      float xx = sx + i;
      for (int j = 0; j < weights[i].length; j += 1) {
        float yy = sy + j;

        color c = color(map(weights[i][j], -1, 1, 0, 255), 255, 255);
        stroke(c);
        point(xx, yy);
      }
    }
    for (int j = 0; j < values.length; j += 1) {
      color c = color(map(values[j], -1, 1, 0, 255), 255, 255);
      stroke(c);
      point(sx + weights.length, sy + j);
    }
    //String output = "";
    //for (int i = 0; i < values.length; i += 1) {

    //  output += "\n" + nf(weights[0][i], 3, 3) + " --> " + nf(values[i], 3, 3);
    //}
    //text(output, sx, sy);
  }

  float[] addBias(float[] biasMe) {

    biasMe = expand(biasMe, biasMe.length+1);
    biasMe[biasMe.length-1] = 1;

    return biasMe;
  }

  String toString() {
    String output = "";
    for (float f : values) {
      output += nf(f, 3, 3) + ",";
    }

    return output;
  }

  void copyInputs(float[] inputs) {
    holdInputs = new float[inputs.length];
    for (int i = 0; i < inputs.length; i += 1) {
      holdInputs[i] = inputs[i];
    }
  }

  void adjust(float error) {
    for (int i = 0; i < weights.length; i += 1) {
      for (int j = 0; j < weights[i].length; j += 1) {
        //weights[i][j] += holdInputs[i] * error * learningRate;
        //weights[i][j] += error * learningRate;
        if (random(1) < mutationRate) {
          weights[i][j] += (random(-1, 1) * learningRate);//(error * holdInputs[i] * learningRate);
        }
        //weights[i][j] = constrain(weights[i][j], -10, 10);
        //values[j] += weights[i][j] * inputs[i];
      }
    }
  }

  void calc(float... inputs) {
    inputs = addBias(inputs);

    copyInputs(inputs);


    for (int i = 0; i < values.length; i += 1) {
      values[i] = 0;
    }

    for (int i = 0; i < weights.length; i += 1) {
      for (int j = 0; j < weights[i].length; j += 1) {

        values[j] += weights[i][j] * inputs[i];
      }
    }

    float highest = -1000000;
    for (int i = 0; i < values.length; i += 1) {
      //if (values[i] < 0) {
      values[i] = hyperbol(values[i]);//hyperbol(values[i]);
      if (values[i] > highest) {
        highest = values[i];
      }
      //}
    }
    if (highest == 0) {
      highest = 1;
    }
    for (int i = 0; i < values.length; i += 1) {
      //if (values[i] < 0) {
      values[i] /= highest;
      values[i] = (values[i] + 1) / 2;
      //}
    }
  }
}