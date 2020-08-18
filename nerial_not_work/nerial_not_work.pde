float[][] testInput = {{0, 0, 0}, {0, 1, 1}, {1, 0, 1}, {1, 1, 0} };


class Layer {
  float nodes[];
  float weights[];
  float deltas[];

  Layer(int numNodes, int prevLayerNodes) {
    nodes = new float[numNodes+1];
    weights = new float[prevLayerNodes+1];
    deltas = new float[numNodes+1];

    for (int i = 0; i < weights.length; i += 1) {
      weights[i] = random(-1, 1);
    }

    nodes[nodes.length-1] = 1;
  }
}



Layer input;
Layer[] layers;
Layer output;


void setup() {
  size(600, 600);
  input = new Layer(2, 0);
  output = new Layer(1, 5);

  layers = new Layer[2 + 5];

  layers[0] = input;
  int prevLayer = 2;
  for (int i = 1; i < layers.length-1; i += 1) {
    layers[i] = new Layer(5, prevLayer);
    prevLayer = 5;
  }




  layers[layers.length - 1] = output;
}


void draw() {
  background(0);
  float xStep = width / (layers.length+1);
  Layer prev = null;
  for (int i = 0; i < layers.length; i += 1) {
    Layer layer = layers[i];

    float yStep = height / (layer.nodes.length+1);


    float pyStep = 0;
    if (prev != null) {
      pyStep = height / (prev.nodes.length+1);
    }

    for (int j = 0; j < layer.nodes.length; j += 1) {
      float xx = xStep + (xStep * i);
      float yy = yStep + (yStep * j);
      fill(255);
      stroke(255);
      ellipse(xx, yy, 5, 5);

      if (prev != null) {
        float px = xStep + (xStep * (i-1));
        for (int k = 0; k < prev.nodes.length; k += 1) {
          float py = pyStep + (pyStep * k);
          //int m = layer.weights.length;
          stroke(255, map(layer.weights[k], -1, 1, 64, 255));
          line(xx, yy, px, py);
        }
      }
    }
    prev = layer;
  }
  if (inputIndex >= 0) {
    fill(255);
    text("input " + testInput[inputIndex][0]+ " " + testInput[inputIndex][1] + " = " + testInput[inputIndex][2] + " (" + output.nodes[0] + ")", 10, 10);
  }
}

void mouseReleased() {
  inputIndex += 1;

  if (inputIndex > testInput.length-1) {
    inputIndex = 0;
  }


  step();
}



int inputIndex = -1;

void backpropogate() {
  float out = output.nodes[0];
  float expected = testInput[inputIndex][2];
  float error = (expected - out) * td(out);
  
  for (int i = layers.length - 1; i >= 0; i -= 1) {
    Layer layer = layers[i];
    ArrayList<Float> errors = new ArrayList<Float>();
    if (i != layers.length-1) {
      for (int j = 0; j < layer.nodes.length; j += 1) {
        float locError = 0;
        Layer prev = layers[i + 1];
        for (int k = 0; k < prev.nodes.length; k += 1) {
          locError += prev.weights[j] * prev.deltas[k];
        }
        errors.add(locError);  
      }
    } else {
      for (int j = 0; j < layer.nodes.length; j += 1) {
        errors.add(
      }
      
    }
  }
}
void step() {
  for (int i = 0; i < 2; i += 1) {
    input.nodes[i] = testInput[inputIndex][i];
  }

  Layer prev = input;
  for (int i = 1; i < layers.length; i += 1) {
    Layer layer = layers[i];

    for (int j = 0; j < layer.nodes.length-1; j += 1) {
      layer.nodes[j] = 0;
      for (int k = 0; k < layer.weights.length; k += 1) {
        layer.nodes[j] += prev.nodes[k] * layer.weights[k];
      }
      layer.nodes[j] = sig(layer.nodes[j]);
    }


    prev = layer;
  }

  //for (int i = 0; i < output.nodes.length; i += 1) {
  //  output.nodes[i] = sig(output.nodes[i]);
  //}
}
