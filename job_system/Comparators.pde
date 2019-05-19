class RandomComparator implements Comparator {
  int compare(Object a, Object b) {
    return floor(random(-1,2));
  }
}

RandomComparator rc = new RandomComparator();

class RandomNodeComparator implements Comparator<Node> {
  int compare(Node a, Node b) {
    return floor(random(-1,2));
  }
}

class RandomRobotComparator implements Comparator<Robot> {
  int compare(Robot a, Robot b) {
    return floor(random(-1,2));
  }
}
RandomRobotComparator rrc = new RandomRobotComparator();


RandomNodeComparator rnc = new RandomNodeComparator();
