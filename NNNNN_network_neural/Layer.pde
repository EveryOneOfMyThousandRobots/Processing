int LAYER_ID = 0;
class Layer {
  int id;
  ArrayList<Neuron> neurons = new ArrayList<Neuron>();
  ArrayList<Connection> connections = new ArrayList<Connection>();
  Network network;
  Layer (Network network) {
    this.network = network;
    LAYER_ID += 1;
    id = LAYER_ID;
  }

  void addNeuron(Neuron n) {
    network.addNeuron(n);
    neurons.add(n);
  }

  String toString() {
    String output = "\nLayer" + id + "\n";
    for (Neuron n : neurons) {
      output += "\n\t" + n.toString();
    }
    return output;
  }

  void connect(Layer o) {
    for (Neuron n : neurons) {
      for (Neuron on : o.neurons) {
        network.connect(n, on, random(1));
      }
    }
  }
}