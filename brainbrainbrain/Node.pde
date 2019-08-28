class Node extends hasId{
  Layer layer;
  float value;
  Node(Layer layer){
    this.layer = layer;
  }
  
  String toString() {
    return "\n\t\tNode (" + id + ") v: " + value;
  }
  
  
}