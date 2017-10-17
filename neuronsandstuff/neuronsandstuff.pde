class Neuron {
  float input = 0;
  int type;

  ArrayList<Con> cons = new ArrayList<Con>();

  Neuron(int type) {
    this.type = type;
  }
}

final int  TYPE_INPUT = 0;
final int  TYPE_HIDDEN = 1;
final int  TYPE_OUTPUT = 2;


class Con {
  Neuron from = null, to = null;
  float weight = 0;

  Con (Neuron from, Neuron to) {
    weight = random(0, 1);
  }
}

class Brain {
  ArrayList<Neuron> input = new ArrayList<Neuron>();
  ArrayList<Neuron> output = new ArrayList<Neuron>();
  ArrayList<Neuron> hidden = new ArrayList<Neuron>();

  Brain(int[] inputData, int numHidden, int numOutput) {
    for (int i = 0; i < inputData.length; i += 1) {
      Neuron n = new Neuron(TYPE_INPUT);
      n.input = inputData[i];
      input.add(n);
    }

    for (int i = 0; i < numHidden; i += 1) {
      Neuron n = new Neuron(TYPE_HIDDEN);
      hidden.add(n);
    }

    for (int i = 0; i < numOutput; i += 1) {
      Neuron n = new Neuron(TYPE_OUTPUT);
      output.add(n);
    }
  }
}