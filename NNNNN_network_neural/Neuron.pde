int NEURON_ID = 0;
class Neuron {
  int id;
  PVector pos;
  float sum = 0;
  ArrayList<Connection> connections = new ArrayList<Connection>();
  float radius = 32;
  Neuron(float x, float y) {
    NEURON_ID += 1;
    id = NEURON_ID;
    pos = new PVector(x, y);
  }


  String toString() {
    String output = hashCode() + ":" + id + " pos:" + pos + " sum: " + sum + " radius: " + radius;
    for (Connection c : connections) {
      output += "\n\t\t" + c;
    }
    
    return output;
  }

  void feedForward(float input) {
    //println("neuron " + id + " feed forward " + input);
    sum += input;
    if (sum > 1) {
      fire();
      sum = 0;
    }
  }

  void update() {
  }

  int hashCode() {
    return 100000 + (id * 101);
  }

  void fire() {
    //println("neuron " + id + " fire");
    radius = 64;
    for (Connection c : connections) {
      c.feedForward(sum);
    }
  }

  void addConnection(Connection con) {
    connections.add(con);
  }

  void draw() {
    stroke(0);
    float fll = map(sum, 0, 1, 255, 0);
    fill(fll);
    strokeWeight(1);
    ellipse(pos.x, pos.y, radius, radius);
    fill(0);
    text(sum, pos.x + 20, pos.y);
    //for(Connection c : connections) {
    //  c.draw();
    //}
    radius = lerp(radius, 32, 0.1);
  }
}