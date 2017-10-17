import java.util.Comparator;
class Creature implements Comparable<Creature> {
  int x, y;
  float health;

  float[] inputs = new float[4];
  Brain brain;

  Creature(int x, int y) {
    brain = new Brain(5, 10, 10, 5);
    this.x = x;
    this.y = y;
  }

  void update() {
    float[] f = new float[5];
    f[0] = foodAt(x-1, y);
    f[1] = foodAt(x+1, y);
    f[2] = foodAt(x, y-1);
    f[3] = foodAt(x, y+1);
    f[4] = foodAt(x,y);
    brain.setInputs(f);
    brain.calc();

    float highest = -10;
    int highestIndex = -1;

    for (int i = 0; i < brain.out.values.length; i += 1) {
      if (brain.out.values[i] > highest ) {
        highest = brain.out.values[i];
        highestIndex = i;
      }
    }

    int xx = x;
    int yy = y;
    switch (highestIndex) {
    
    case 0:
      xx = x - 1;
      break;
    case 1:
      xx = x + 1;
      break;
    case 2:
      yy = y - 1;
      break;
    case 3:
      yy = y + 1;
      break;
    case 4:
      //nothing
      break;
    default:
    }

    if (!outOfBounds(xx, yy)) {
      x = xx;
      y = yy;
      float fa = food[x][y];
      health += fa/2;
      food[x][y] = fa/2;
    }
  }

  void draw() {

    pixels[x + y * width] = color(0,255,0);
  }
  
  int compareTo(Creature o ) {
    if (this.health > o.health) {
      return 1;
    } else if (this.health < o.health) {
      return -1;
    } else {
      return 0;
    }
  }
  

}
  public static Comparator<Creature> creatureCompare = new Comparator<Creature>() {
    public int compare(Creature o1, Creature o2) {
      return o1.compareTo(o2);
    }
    
  };