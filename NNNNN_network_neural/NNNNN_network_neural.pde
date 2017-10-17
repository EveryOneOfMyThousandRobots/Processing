Network network;
void setup() {
  size(700, 700);
  network = new Network(width / 2, height / 2);
  
  Layer input = new Layer(network);
  network.setInput(input);
  input.addNeuron(new Neuron(-250, -250));
  input.addNeuron(new Neuron(-250, -150));
  input.addNeuron(new Neuron(-250, 150));
  input.addNeuron(new Neuron(-250, 250));
  
  for (int i = 0; i < 3; i += 1) {
    Layer layer = new Layer(network);
    int count = floor(random(3,10));
    for (int j = 0; j < count; j += 1) {
      Neuron n = new Neuron(-150 + (100 * i), -200 + (50 * j));
      layer.addNeuron(n);
      
    }
    network.addLayer(layer);
  }
  
  input.connect(network.layers.get(0));
  
  for (int i = 0; i < network.layers.size()-1; i += 1) {
    Layer l1 = network.layers.get(i);
    Layer l2 = network.layers.get(i+1);
    l1.connect(l2);
  }
  
  
  
  Layer output = new Layer(network);
  network.setOutput(output);
  output.addNeuron(new Neuron(300,0));
  
  network.layers.get(network.layers.size()-1).connect(output);
  
  //Neuron a = new Neuron(-275, 0);
  //Neuron b = new Neuron(-150, 0);
  //Neuron c = new Neuron(0, 75);
  //Neuron d = new Neuron(0, -75);
  //Neuron e = new Neuron(150, 0);
  //Neuron f = new Neuron(275, 0);

  //// Connect them
  //network.connect(a, b, 1);
  //network.connect(b, c, random(1));
  //network.connect(b, d, random(1));
  //network.connect(c, e, random(1));
  //network.connect(d, e, random(1));
  //network.connect(e, f, 1);

  //// Add them to the Network
  //network.addNeuron(a);
  //network.addNeuron(b);
  //network.addNeuron(c);
  //network.addNeuron(d);
  //network.addNeuron(e);
  //network.addNeuron(f);

  println(network);
  //frameRate(1);
}

void draw() {
  background(255);
  network.update();
  network.draw();

  if (frameCount % 30 == 0) {
    //network.feedForward(random(1));
    network.feedForward();
    //println(network);
  }
}