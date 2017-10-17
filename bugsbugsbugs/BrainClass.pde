class Brain {


  ArrayList<Neuron> input = new ArrayList<Neuron>();
  ArrayList<Neuron> hidden = new ArrayList<Neuron>();
  ArrayList<Neuron> output = new ArrayList<Neuron>();
  ArrayList<Connection> connections = new ArrayList<Connection>();
  

  Brain () {
    setupInput();
    setupOutput();
  }

  void setupInput() {
    input.add(new InputNeuron(""));
    
    for (Neuron n : input) {
      n.input = random(0,1);
    }
  }
  
  void setupHidden() {
    int numHidden = (int) random(3, 10);
    for (int i = 0; i < numHidden; i+= 1) {
      HiddenNeuron n = new HiddenNeuron();
      hidden.add(n);
    }
    
    
    for (int i = 0; i < hidden.size(); i += 1) {
      HiddenNeuron hn = (HiddenNeuron) hidden.get(i);
      for (int j = 0; j < hidden.size(); j += 1) {
        HiddenNeuron on = (HiddenNeuron) hidden.get(j);
        int r = (int)random(1,100);
        if (hn.NeuronId != on.NeuronId) {
          if (r < 4 ) {
            if (connections.indexOf()
            hn.connections.add(hn, on);
          }
        }
        
      }
    
      
    }
  }
  
  void setupOutput() {
    output.add(new OutputNeuron(""));
    
    for (Neuron n : output) {
      
    }
  }
}