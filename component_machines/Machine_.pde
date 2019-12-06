class Machine {
  Layer input, output;
  Layer[] layers;

  Machine(int numIn, int numLayers, int numPerLayer, int numOut) {
    input = new Layer(this, numIn);
    output = new Layer(this, numOut);
    layers = new Layer[numLayers];
    for (int i = 0; i < layers.length; i += 1) {
      layers[i] = new Layer(this, numPerLayer);
    }
    connect();
  }

  void setInput(float[] inputValues) {
    if (inputValues.length == input.comps.size() ) {

      for (int i = 0; i < inputValues.length; i += 1) {
        input.comps.get(i).value = inputValues[i];
      }
    }
  }

  void connect() {
    input.connect(layers[0]);
    for (int i = 0; i < layers.length-1; i += 1) {
      Layer ly = layers[i];
      Layer oly = layers[i + 1];
      ly.connect(oly);
      
    }
    
    layers[layers.length-1].connect(output);
  }

  void update() {
    for (Layer layer : layers) {
      layer.update();
    }

    output.update();
  }
  
  void draw() {
    
    float xStep = width / (layers.length + 3);
    input.draw(xStep/2);
    for (int i = 0; i < layers.length; i += 1) {
      Layer ll = layers[i];
      ll.draw((2 * xStep) + (xStep * i));
    }
    
    output.draw(width - (xStep/2));
    
  }
}

class Layer {
  ArrayList<Comp> comps = new ArrayList<Comp>();
  Machine machine;
  float bias;

  Layer(Machine machine, int num) {
    this.machine = machine;
    this.bias = random(-1, 1);
    for (int i = 0; i < num; i += 1) {
      comps.add(new Comp(machine, this));
    }
  }

  void connect(Layer layer) {
    for (Comp cmp : comps) {
      for (Comp o : layer.comps) {
        Conn conn = new Conn(cmp, o, random(-1, 1));
        cmp.outputs.add(conn);
        o.inputs.add(conn);
      }
    }
  }

  void update() {
    for (Comp cmp : comps) {
      cmp.update();
    }
  }
  
  void draw(float x) {
    
    float yStep = height / comps.size();
    
    for (int i = 0;i < comps.size(); i += 1) {
      Comp cmp = comps.get(i);
      
      stroke(255);
      fill(51);
      ellipse(x, (yStep/2) + (yStep * i), 30, 30);
      fill(255);
      text(cmp.type + "\n" + cmp.value, x, (yStep/2) + (yStep * i));
      
    }
    
  }
}
