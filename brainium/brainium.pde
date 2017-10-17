class Node {
  float input;
  float output;
}

class Connection {
  Node from, to;
  float weight;
  
  void connectRandom(ArrayList<Node> fromList, ArrayList<Node> toList) {
    //int f = (int) random(0, fromList.size());
    //int t = (int) random(0, toList.size());
    this.from = getRandom(fromList);
    this.to = getRandom(toList);
   }
   
   Node getRandom(ArrayList<Node> list) {
     return list.get((int)random(0, list.size()));
   }
}


  


class Layer {
  int type;
  
  ArrayList<Node> nodes = new ArrayList<Node>();
  
  Layer(int type, int nodes) {
    if (type > 0 && type <= 2) {
      
      this.type = type;
    } else {
      
    }
    
    
    for (int i = 0; i < nodes; i += 1) {
      Node n = new Node();
      
      this.nodes.add(n);
    }
    
  }
  
  int size() {
    return nodes.size();
  }
 
 
}

class Brain {
  Layer input = new Layer(0, 1);
  Layer brain = new Layer(1, 4);
  Layer output = new Layer(2, 1);
  
  Brain() {
    for (int i = 0; i < input.size(); i += 1) {
      
    }
  }
  
  
}