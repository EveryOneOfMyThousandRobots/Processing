class Layer extends hasId{
  Node[] nodes;
  int numNodes;
  ArrayList<Connection> connectionsToMe = new ArrayList<Connection>();
  ArrayList<Connection> connectionsFromMe = new ArrayList<Connection>();
  float bias = 1;
  
  Layer(int numNodes) {
    this.numNodes = numNodes;
    nodes = new Node[numNodes];
    fillNodes();
  }
  
  void calc(Layer prev) {
    for (Node n : nodes) {
      if (prev == null) {
        n.value = 0;
      } else {
        n.value = prev.bias;
      }
      for (Connection c : connectionsToMe) {
        if (c.to.id == n.id) { //this is for me
          n.value += c.from.value * c.weight;
        }
      }
    }
  }
  
  String toString() {
    String output = "layer (" + id + ")\nNodes:\n";
    
    for (Node n : nodes) {
      output += n.toString();
    }
    
    output += "\nConnection From Me\n";
    for (Connection con : connectionsFromMe) {
      output += con.toString();
    }
    output += "\nConnection To Me\n";
        for (Connection con : connectionsToMe) {
      output += con.toString();
    }
    
    return output;
  }
  
  void fillNodes() {
    for (int i = 0; i < nodes.length; i += 1) {
      nodes[i] = new Node(this);
    }
  }
}