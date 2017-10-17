int NODE_ID = 0;
class Node {
  final int nodeId;
  float value = 0;
  ArrayList<Connection> cons = new ArrayList<Connection>();
  {
    NODE_ID += 1;
    nodeId = NODE_ID;
  }
}

class Connection {
  Node from, to;
  float weight;
}

class Layer {

  ArrayList<Node> nodes = new ArrayList<Node>();

  Layer to = null;
  Layer from = null;

  Layer (int numOfNodes) {

    for (int i = 0; i < numOfNodes; i += 1) {
      nodes.add(new Node());
    }
  }
  void Print() {
    println("\nprinting...");
    print("\n\tnodes: " + nodes.size() + "\tconnections: " + getNumConnections() + "\n");
    for (Node n : nodes) {
      for (Connection c : n.cons) {
        print(c.weight + " ");
      }
    }
  }

  int getNumConnections() {
    int num = 0;
    for (Node n : nodes) {
      num += n.cons.size();
    }

    return num;
  }

  void Connect() {
    if (to != null) {
      for (Node n : nodes) {
        for (Node nn : to.nodes) {
          Connection c = new Connection();
          c.from = n;
          c.to = nn;
          c.weight = random(-1, 1);
          n.cons.add(c);
        }
      }
    }
  }
}