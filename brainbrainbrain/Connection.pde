class Connection extends hasId{
  Node from, to;
  Layer layerFrom, layerTo;
  float weight;
  
  Connection(Node from, Node to, Layer layerFrom, Layer layerTo) {
    this.from = from;
    this.to = to;
    this.layerFrom = layerFrom;
    this.layerTo = layerTo;
    weight = random(-1,1);
    
    layerFrom.connectionsFromMe.add(this);
    layerTo.connectionsToMe.add(this);
  }
  
  String toString() {
    return "\n\tConn("+ id +"): " + layerFrom.id + "." + from.id + " -> " + layerTo.id + "." + to.id + " w:" + weight;
  }
}

void connect(Layer a, Layer b) {
  for (int i = 0; i < a.nodes.length; i += 1) {
    Node na = a.nodes[i];
    for( int j = 0 ; j < b.nodes.length; j += 1) {
      Node nb = b.nodes[j];
      new Connection(na, nb, a, b);
      
    }
  }
}