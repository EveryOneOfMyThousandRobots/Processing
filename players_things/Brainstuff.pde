class Brain {
  ArrayList<Axon> axons = new ArrayList<Axon>();
  ArrayList<Input> inputs = new ArrayList<Input>();
  ArrayList<Middle> middle = new ArrayList<Middle>();
  ArrayList<Output> output = new ArrayList<Output>();
  Brain() {

    inputs.add(new Input("in:ball.x"));
    inputs.add(new Input("in:ball.y"));
    inputs.add(new Input("in:my.x"));
    inputs.add(new Input("in:my.y"));

    int neurons = (int) random(5, 20);
    for (int n = 0; n < neurons; n += 1) {
      middle.add(new Middle());
    }

    output.add(new Output("out:my.x+"));
    output.add(new Output("out:my.x-"));
    output.add(new Output("out:my.y+"));
    output.add(new Output("out:my.y-"));   

    for (int n = 0; n < inputs.size(); n += 1) {
      for (int nn = 0; nn < middle.size(); nn += 1) {
        axons.add(new Axon(inputs.get(n), middle.get(nn)));
      }
    }

    for (int n = 0; n < middle.size(); n += 1) {
      for (int nn = 0; nn < output.size(); nn += 1) {
        axons.add(new Axon(middle.get(n), output.get(nn)));
      }
    }
    
    for (int n = 0; n < axons.size(); n += 1) {
      println(n + ": " + axons.get(n).toString());
    }
  }
  
  void update() {
    
  }
}
int NEURON_ID = 0;
class Neuron {
  final int neuronId;
  float val = random(0, 1);
  float output;
  String name;
  public int hashCode() {
    return neuronId * 17;
  }
  
  Neuron () {
    NEURON_ID += 1;

    neuronId = NEURON_ID;
  }
  Neuron(String name) {
    this();
    this.name = name;
  }
  String toString() {
    return name + " ("+ neuronId + ")";
  }
}

class Axon {
  Neuron from, to;
  Axon(Neuron from, Neuron to) {
    this.from = from;
    this.to = to;
  }
  String toString() {
    return from.toString() + " ===> " + to.toString();
  }
}
class Input extends Neuron {
  Input(String name) {
    super(name);
  }
}

class Middle extends Neuron {
  Middle() {
    super();
    this.name = "Middle (" + neuronId + ")";
  }
  
  int equals(Object o ) {
  }
}

class Output extends Neuron {
  Output(String name) {
    super(name);
  }
}