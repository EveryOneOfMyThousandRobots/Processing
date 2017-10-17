int NEURON_ID = 0;
class Neuron {
  int NeuronId;
  String name = "";

  float input;
  float output;
  ArrayList<Connection> connections = new ArrayList<Connection>();

  Neuron () {
    NeuronId = ++NEURON_ID;
  }

  int HashCode() {
    return NEURON_ID;
  }

  boolean equals(Object o) {
    if (o instanceof Neuron) {
      if (this.hashCode() == o.hashCode()) {
        return true;
      }
    }

    return false;
  }
}

class InputNeuron extends Neuron {
  InputNeuron (String name) {
    super();
    this.name = name;
  }
}

class OutputNeuron extends Neuron {
  OutputNeuron (String name) {
    super();
    this.name = name;
  }
}

class HiddenNeuron extends Neuron {
}

class Connection {
  Neuron from, 
    to;

  float weight;

  Connection(Neuron from, Neuron to, float weight) {
    this.from = from;
    this.to = to;

    this.weight = weight;
  }
}