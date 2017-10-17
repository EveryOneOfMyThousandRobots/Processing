class Brain {
  float[] inputs;
  Layer[] layers;
  Layer output;
  DNA dna;

  float getOutput(int i) {
    return output.values[i];
  }

  Brain(int numInputs, int numLayers, int numPerLayer, int numOutputs, DNA dna) {
    inputs = new float[numInputs];
    layers = new Layer[numLayers];
    this.dna = dna;

    for (int i = 0; i < numLayers; i += 1) {
      if (i == 0) {
        layers[i] = new Layer(numPerLayer, numInputs);
      } else {
        layers[i] = new Layer(numPerLayer, numPerLayer);
      }
    }
    output = new Layer(numOutputs, numPerLayer);
  }

  void calc() {

    layers[0].calc(inputs);
    for (int i = 1; i < layers.length; i += 1) {
      layers[i].calc(layers[i-1].values);
    }
    output.calc(layers[layers.length-1].values);
  }

  void setInputs(float... inputs) {
    this.inputs = inputs;
  }


  void setFromDNA() {
    for (int i = 0; i < layers.length; i += 1) {
      Layer l = layers[i];
      for (int x = 0; x < l.weights.length; x += 1) {
        l.types[x] = floor(dna.get("type_" + i + "[" + x + "]", 0, 5));
        l.typeMods[x] = dna.get("typeMod_" + i + "[" + x + "]", -100, 100);
        l.actTypes[x] = floor(dna.get("activation_" + i + "[" + x + "]", 0, 4));
        for (int y = 0; y < l.weights[x].length; y += 1) {
          l.weights[x][y] = dna.get("weight_" + i + "[" + x + "][" + y + "]");
        }
      }
    }

    Layer l = output;
    for (int x = 0; x < l.weights.length; x += 1) {
      l.types[x] = floor(dna.get("type_output[" + x + "]", 0, 5));
      l.typeMods[x] = dna.get("typeMod_output[" + x + "]", -100, 100);
      l.actTypes[x] = floor(dna.get("activation_output[" + x + "]", 0, 4));
      for (int y = 0; y < l.weights[x].length; y += 1) {
        l.weights[x][y] = dna.get("weight_output[" + x + "][" + y + "]");
      }
    }
  }
}

final int OUTTYPE_ADD = 0;
final int OUTTYPE_SUB = 1;
final int OUTTYPE_MULT = 2;
final int OUTTYPE_MOD = 3;

final int ACTTYPE_SIG = 0;
final int ACTTYPE_NORM1 = 1;
final int ACTTYPE_NORM2 = 2;
final int ACTTYPE_0_1 = 3;
class Layer {
  float[] values;
  float[][] weights;
  int[] types;
  int[] actTypes;
  float[] typeMods;

  Layer(int numValues, int numPrevious) {
    values = new float[numValues];
    weights = new float[numValues][numPrevious+1];
    types = new int[numValues];
    actTypes = new int[numValues];
    typeMods = new float[numValues];
  }

  float[] addBias(float[] hi) {
    float[] a = expand(hi, hi.length + 1);
    for (int i = 0; i < hi.length; i += 1) {
      a[i] = hi[i];
    }
    a[a.length-1] = 1;
    return a;
  }

  void calc(float[] inputs) {
    float[] a = addBias(inputs);
    for (int x = 0; x < values.length; x += 1) {
      values[x] = 0;
      int type = types[x];
      int activation = actTypes[x];
      float typeMod = typeMods[x];
      for (int y = 0; y < weights[x].length; y += 1) {
        switch(type) {
        default:
          values[x] += a[y] * weights[x][y];
          break;
        case OUTTYPE_SUB:
          values[x] -= a[y] * weights[x][y];
          break;
        case OUTTYPE_MULT:
          values[x] += (a[y] * typeMod)* weights[x][y];
          break;
        case OUTTYPE_MOD:
          values[x] += (a[y] % floor(abs(typeMod)))* weights[x][y];
          break;
        }
      }
      switch (activation) {
      case ACTTYPE_SIG:
        values[x] = sigmoid(values[x]);
        break;
      case ACTTYPE_NORM1:
      case ACTTYPE_NORM2:
        values[x] = normaliseRange(values[x]);
        break;
      case ACTTYPE_0_1:
        values[x] = normaliseRange(values[x]);
        if (values[x] >= 0) {
          values[x] = 1;
        } else {
          values[x] = -1;
        }
      }
    }
  }
}
float EXP1 = exp(1);
float sigmoid(float x) {

  return 1 / (1 + pow(EXP1, -x));
}

float normaliseRange(float x) {
  return (2 / (1 + pow(EXP1, - 2 * x) )) -1;
}