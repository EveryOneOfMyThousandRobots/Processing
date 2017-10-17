int LAYER_ID = 0;

class Layer {
  int layerId;
  int numValues, numPrevious;
  float[][] weights;
  float[] values;
  int[] types;
  float[] typeMods;
  final int TYPE_ADD = 0;
  final int TYPE_SUB = 1;
  final int TYPE_MOD = 2;
  final int TYPE_MULT = 3;
  final int TYPE_ADD_CONST = 4;
  final int TYPE_SUB_CONST = 5;
  Genome genome = null;


  Layer(int numValues, int numPrevious, Genome genome) {
    LAYER_ID += 1;
    layerId = LAYER_ID;
    this.genome = genome;
    this.numValues = numValues;
    this.numPrevious = numPrevious;
    values = new float[numValues];
    weights = new float[numValues][numPrevious];
    types = new int[numValues];
    typeMods = new float[numValues];

    for (int i = 0; i < weights.length; i += 1) {
      for (int j = 0; j < weights[i].length; j += 1) {

        if (genome != null) {
          weights[i][j] = map(genome.get(layerId + ":weights:"+i+":"+j), 0, 999, -1, 1);
        } else {
          weights[i][j] = random(-1, 1);
        }
      }
    }

    for (int i = 0; i < types.length; i += 1) {
      if (genome != null ) {
        types[i] = floor(map(genome.get(layerId + ":types:" + i), 0, 999, 0, 6));
        typeMods[i] = floor(map(genome.get(layerId + ":typeMods:" + i), 0, 999, -100, 100));
      } else {
        types[i] = floor(random(0, 6));
        typeMods[i] = floor(random(-100, 100));
      }
    }
  }

  void mutate() {
    for (int i = 0; i < types.length; i += 1) {
      if (random(0, 100) <= 1) {
        types[i] = floor(random(0, 4));
      }
      if (random(0, 100) <= 1) {
        typeMods[i] += (random(-0.1, 0.1));
      }
    }
    for (int i = 0; i < weights.length; i += 1) {
      for (int j = 0; j < weights[i].length; j += 1) {
        if (random(0, 100) <= 2) {
          weights[i][j] += random(-0.01, 0.01);
        }
      }
    }
  }

  Layer copy() {
    Layer l = new Layer(numValues, numPrevious, genome);
    for (int i = 0; i < weights.length; i += 1) {
      for (int j = 0; j < weights[i].length; j += 1) {
        l.weights[i][j] = weights[i][j];
      }
    }

    for (int i = 0; i < types.length; i += 1) {
      l.types[i] = types[i];
      l.typeMods[i] = typeMods[i];
    }


    l.mutate();
    l.mutate();

    return l;
  }



  void calc(float[] prevLayer) {
    for (int i = 0; i < values.length; i += 1) {
      values[i] = 0;
      for (int j = 0; j < weights[i].length; j += 1) {
        switch (types[i]) {

        case TYPE_SUB:
          values[i] -= prevLayer[j] * weights[i][j];
          break;
        case TYPE_MOD:
          values[i] += (prevLayer[j] % typeMods[i]) * weights[i][j];
          break;
        case TYPE_MULT:
          values[i] += (prevLayer[j] * typeMods[i]) * weights[i][j];
          break;
        case TYPE_ADD_CONST:
          values[i] += (prevLayer[j] + typeMods[i]) * weights[i][j];
          break;
        case TYPE_SUB_CONST:
          values[i] += (prevLayer[j] - typeMods[i]) * weights[i][j];
          break;
        default: //ADD
          values[i] += prevLayer[j] * weights[i][j];
        }
      }
      values[i] = sigmoid(values[i]);
    }
  }
}