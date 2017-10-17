class Node {
  float x,y;
  
  float radius;
  float friction;
}

class Muscle {
  Node a,b;
  
    
}
class Life {
  float x,y;
  ArrayList<Node> nodes = new ArrayList<Node>();
  
  Life() {
    x = (width / 4 ) + random(width / 2);
    y= (height / 4) + random(height/ 2);
    
    int m = (int) random(1,5);
    for (int mm = 0; mm < m; mm += 1) {
      Node n = new Node();
      n.x  = random(x - 100, x + 50);
      n.y  = random(y - 50, y + 50)
      
    }
  }
}



class Floor {
  
}
ArrayList<Life> life = new ArrayList<Life>();

void setup() {
    
}

void draw() {
}

  