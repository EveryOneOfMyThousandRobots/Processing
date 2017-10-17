class Network {
  ArrayList<Layer> layers;
  ArrayList<Neuron> neurons;
  ArrayList<Connection> connections;
  private Layer inputLayer;
  private Layer outputLayer;

  PVector pos;

  void setInput(Layer layer) {
    inputLayer = layer;
    //addLayer(layer);
  }

  void setOutput(Layer layer) {
    outputLayer = layer;
    //addLayer(layer);
  }

  void addLayer(Layer layer) {
    layers.add(layer);
  }

  Network (float x, float y) {
    pos = new PVector(x, y);
    neurons = new ArrayList<Neuron>();
    connections = new ArrayList<Connection>();
    layers = new ArrayList<Layer>();
  }

  void addNeuron(Neuron n) {
    neurons.add(n);
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    for (Neuron n : neurons) {
      n.draw();
    }

    for (Connection c : connections) {
      c.draw();
    }
    popMatrix();
  }

  void connect(Neuron from, Neuron to, float weight) {
    Connection c = new Connection(from, to, weight);
    from.addConnection(c);
    connections.add(c);
  }

  String toString() {
    String output = "\n";
    output += inputLayer;
    for (Layer l : layers) {
      output += "\n\t" + l.toString();
    }
    output += outputLayer;
    return output;
  }

  void connect(int from, int to, float weight) {
    if (from >= 0 && from < neurons.size() && to >= 0 && to < neurons.size()) {
      Neuron a = neurons.get(from);
      Neuron b = neurons.get(to);
      connect(a, b, weight);
    }
  }
  
  void feedForward( ) {
       for (Neuron n : inputLayer.neurons) {
      //Neuron start = neurons.get(0);
      //start.feedForward(input);
      n.feedForward(random(0.5));
    }
  }

  void feedForward(float input) {
    for (Neuron n : inputLayer.neurons) {
      //Neuron start = neurons.get(0);
      //start.feedForward(input);
      n.feedForward(input);
    }
  }

  void update() {
    for (Connection c : connections) {
      c.update();
    }
    //for (Neuron n : neurons) {
    //  n.update();
    //  //for (Connection c : n.connections) {
    //  //  c.update();
    //  //}
    //}
  }
}