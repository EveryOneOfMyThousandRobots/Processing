class NodeComparator implements Comparator<Node> {
  
  int compare(Node A, Node B) {
    return A.compareTo(B);
  }
}


class TupleComparator implements Comparator<Tuple> {
  
  int compare(Tuple A, Tuple B) {
    return A.compareTo(B);
  }
}
