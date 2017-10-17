color randCol() {
  return color(random(255), 255, 255);
}
import java.util.Comparator;
class RoboComparator implements Comparator<Robo> {
  
  int compare(Robo r1, Robo r2) {
    return r1.compareTo(r2);
  }
}

class RoboComparatorDesc implements Comparator<Robo> {
  
  int compare(Robo r1, Robo r2) {
    return r1.compareTo(r2) * -1;
  }
}

class RoboComparatorRandom implements Comparator<Robo> {
  
  int compare(Robo r1, Robo r2) {
    if (random(1) < 0.5) {
      return 1;
    } else {
      return -1;
    }
  }
}

float heuristic(Cell a, Cell b) {
  //return abs(a.x - b.x) + abs(a.y - b.y) + pow(1 + a.cost, 5);
  //crow
  return PVector.dist(a.pos, b.pos) + pow(1 + a.cost, 2);
}