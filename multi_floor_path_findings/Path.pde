

import java.util.PriorityQueue;
import java.util.Collections;
import java.util.Queue;
import java.util.LinkedList;


void testPath() {
  //path = null;
  //pathStart = getRandomNode(null);
  //if (pathStart !=null) {
  //  pathEnd = getRandomNode(pathStart);
  //  if (pathEnd != null) {
  //    path = new Path(pathStart, pathEnd);
  //    if (path.findPath()) {
  //      println("found path in " + nfc(path.time_taken, 6) + " sec");
  //    } else {
  //      println("could not find path!");
  //    }
  //  }
  //}
}

class PathNode implements Comparable<PathNode>{
  Node node;
  float g,f,h;
  
  PathNode(Node node) {
    g = Float.MAX_VALUE;
    f = Float.MAX_VALUE;
    h = Float.MAX_VALUE;
    this.node = node;
  }
  
   @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        
        return node.equals(o);
               
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(node.id);
    }

    @Override
    public String toString() {
        return node.toString();
    }

    // Compare two employee objects by their salary
    @Override
    public int compareTo(PathNode e) {
        if(f > e.f) {
            return 1;
        } else if (f < e.f) {
            return -1;
        } else {
            return 0;
        }
    }
}

class Path {
  PathNode start, end;
  ArrayList<Node> path = new ArrayList<Node>();
  PriorityQueue<PathNode> open = new PriorityQueue<PathNode>();
  HashMap<PathNode, PathNode> cameFrom = new HashMap<PathNode, PathNode>();
  HashMap<Node, PathNode> nodeMap = new HashMap<Node, PathNode>();
  long time_started, time_finished;
  float time_taken;
  
  
  PathNode getPathNode(Node n) {
    if (nodeMap.containsKey(n)) {
      return nodeMap.get(n);
      
    } else {
      PathNode pn = new PathNode(n);
      nodeMap.put(n,pn);
      return pn;
    }
  }
  

  Path(Node start, Node end) {
    this.start = getPathNode(start);
    this.start.g = 0;
    this.start.f = 0;
    this.end = getPathNode(end);
    open.add(this.start);

  }
  void reconstruct(PathNode current) {
    path.clear();
    while (cameFrom.containsKey(current)) {
      current = cameFrom.get(current);
      path.add(current.node);
    }
    Collections.reverse(path);
  }
  boolean findPath() {
    time_started = System.nanoTime();
    while (!open.isEmpty()) {
       PathNode current = open.remove(); 
       
       if (current.equals(end)) {
         time_finished = System.nanoTime();
         time_taken = (time_finished - time_started) / 10e6;
         time_taken /= 1000.0f;
         reconstruct(current);
         return true;
       }
       
       for (Node n : current.node.neighbours) {
         PathNode pn = getPathNode(n);
         
         float tg = current.g + PVector.dist(current.node.pos, n.pos);
         
         if (tg < pn.g) {
           cameFrom.put(pn, current);
           pn.g = tg;
           pn.h = H(pn.node); 
           pn.f = pn.g + pn.h;
           if (!open.contains(pn)) {
             open.add(pn);
           }
         }
       }
       
    }




    return false;
  }


  float H(Node a) {
    return PVector.dist(end.node.pos, a.pos);
  }

  //float H(Node a, Node b) {
  //  return PVector.dist(a.pos, b.pos);
  //}

  //float G(Node n) {
  //  if (G.containsKey(n)) {
  //    return G.get(n);
  //  } else {
  //    return Float.MAX_VALUE;
  //  }
  //}

  //float F(Node n) {
  //  if (F.containsKey(n)) {
  //    return F.get(n);
  //  } else {
  //    return Float.MAX_VALUE;
  //  }
  //}
}
