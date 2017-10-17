Net net;
void setup() {
  size(800, 800);
  net = new Net();
}

void draw() {
  net.draw();
}


class Con {
  Neuron from, to;
  float weight;

  Con (Neuron from, Neuron to, float weight) {
    this.weight = weight;
    this.from = from;
    this.to = to;
  }
}

class Connections {
  private ArrayList<Con> connections = new ArrayList<Con>();

  void draw() {
    for (Con c : connections) {
      if (c.weight < 0) {
        stroke(255, 0, 0);
      } else {
        stroke(0, 0, 255);
      }

      float absw = abs(c.weight);
      strokeWeight(map(absw, 0, 1, 1, 5));
      line(c.from.pos.x, c.from.pos.y, c.to.pos.x, c.to.pos.y);
    }
  }


  public void add(Neuron from, Neuron to, float weight) {
    for (Con c : connections) {
      if (from.neuronId == c.from.neuronId && to.neuronId == c.to.neuronId) {
        return;
      }

      if (from.neuronId == c.to.neuronId && to.neuronId == c.from.neuronId) {
        return;
      }
    }
    connections.add(new Con(from, to, weight));
    println("Connection created from " + from.neuronId + " to " + to.neuronId);
  }
}

class Net {
  ArrayList<Neuron> neurons = new ArrayList<Neuron>();
  // ArrayList<Con> cons = new ArrayList<Con>();
  Connections connections = new Connections();


  void draw() {
    connections.draw();
    for (Neuron n : neurons) {
      n.draw();
    }
  }

  Net () {
    neurons.add( new Neuron(0));
    neurons.add( new Neuron(0));
    neurons.add(new Neuron(2));

    for (int i = 0; i < 10; i += 1) {
      neurons.add(new Neuron(1));
    }

    for (Neuron n : neurons) {
      if (n.type == "input") {
        for (int i = 0; i < neurons.size(); i += 1) {
          if (neurons.get(i).type != "hidden") {
            continue;
          }
          int r = (int) random(1, 100);
          if (r <= 25) {
            connections.add(n, neurons.get(i), random(-1, 1));
          }
        }
      }
    }

    for (int i = 0; i < neurons.size(); i += 1) {
      Neuron n = neurons.get(i);
      for (int  j = 0; j < neurons.size(); j += 1) {

        if (i == j) continue;

        Neuron o = neurons.get(j);

        if (n.type == "hidden" && (o.type == "hidden" || o.type == "output")) {
          connections.add(n, o, random(-1, 1));
        }
      }
    }
    int countHidden = 0;
    for (int i = 0; i < neurons.size(); i += 1) {
      if (neurons.get(i).type == "hidden") countHidden += 1;
    }

    float x = 0;
    float y = 0;
    float cx = width / 2;
    float cy = height / 2;
    float r = (width / 3) - 5;
    float a = 0;
    float ai = TWO_PI / countHidden;
    float i = 0;
    for (Neuron n : neurons) {
      if (n.type == "hidden") {
        a = ai * i;
        x = cx + r * cos(a);
        y = cy + r * sin(a);

        n.pos.x = x;
        n.pos.y = y;
        i += 1;
      }
    }
  }
}
int NEURON_ID = 0;

class Neuron {
  int neuronId;
  PVector pos;
  String type = "";
  Neuron (int type) {
    neuronId = ++NEURON_ID;
    float w4 = width / 4;


    float xpos = 0;
    float ypos = height / 2;

    if (type <= 0) {
      this.type = "input";
      xpos = width / 8;
    } else if (type == 1) {
      this.type = "hidden";
    } else {
      this.type = "output";
      xpos = width - (width / 8);
    }




    pos = new PVector(xpos, ypos);
  }

  void draw() {
    stroke(0);
    if (type == "input") {
      fill(0, 255, 0);
    } else if (type == "hidden") {
      fill(128);
    } else {
      fill(255, 0, 0);
    }
    stroke(0);
    strokeWeight(1);

    ellipse(pos.x, pos.y, 10, 10);
  }
}