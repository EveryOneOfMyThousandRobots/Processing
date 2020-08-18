int CELL_ID = 0;
import java.util.HashSet;
import java.util.Set;
class Cell {
  final int id;
  final int id_hash;
  {
    CELL_ID += 1;
    id = CELL_ID;
    id_hash = Integer.hashCode(id);
  }


  float material_flow = 0.08;
  float pressure = 0;
  float newPressure = 0;
  int turn = -100;
  float fx, fy;
  final int x, y;
  final float xp, yp;
  boolean inert = false;
  float countNeighbours = 0;

  Set<Cell> neighbours = new HashSet<Cell>();

  Cell( int x, int y, boolean inert) {
    this.x = x;
    this.y = y;
    this.xp = x * CELL_SIZE;
    this.yp = y * CELL_SIZE;

    fx = (float) x * 0.1;
    fy = (float) y * 0.1;
    this.inert = inert;

    //pressure = newPressure = random(100);//noise(fx, fy, 20) * 100;
    pressure = newPressure = noise(fx, fy, fz) * 100;
    //material_flow = noise(fx, fy, 30);
  }

  void draw() {
    float cc = map(pressure, 0, 100, 0, 255); 
    fill(cc, 128, 255);

    noStroke();
    rect(xp, yp, CELL_SIZE, CELL_SIZE);
    //fill(0);
    //text((int)pressure + " " + ((int)newPressure) + "\n" + turn + "\n(" + x + "," + y + ")", xp, yp+HALF_CELL_SIZE);
    //stroke(255, 64);
    //if (x % 3 == 0 && y % 3 == 0) {
    //  for (Cell n : neighbours) {
    //    line(xp + HALF_CELL_SIZE, yp + HALF_CELL_SIZE, n.xp + HALF_CELL_SIZE, n.yp + HALF_CELL_SIZE);
    //  }
    //}
  }

  void updateNewPressure() {
    newPressure += (noise(fx,fy,fz) - 0.5) * 0.01;
  }

  void update() {
    // println("\nstart update: (" + x + "," + y + ")");
    float cf = countNeighbours * random(1, 3);
    if (turn != global_turn) {
      turn = global_turn;
      //println("\tupdate");
      updateNewPressure();
      pressure = newPressure;
    }

    for (Cell n : neighbours) {
      //  println("\nstart neighbour " + n);
      if (n.inert) {
        //print("\tskip");
        continue;
      } else {
        // print("\ttry");
        if (n.turn != global_turn) {
          // print("\tprocess");
          n.turn = global_turn;
          n.updateNewPressure();
          n.pressure = n.newPressure;
        }

        float dpress = pressure - n.pressure;
        float nFlow = material_flow * dpress;
        //nFlow = constrain(nFlow, -n.pressure / 16.0, pressure / 16.0 );
        newPressure -= nFlow/cf; //constrain(nFlow,0,pressure / 16.0);
        newPressure = constrain(newPressure, 0, 100);
        n.newPressure += nFlow/cf; //constrain(nFlow, - n.pressure/16,n.pressure/16.0);
        n.newPressure = constrain(n.newPressure, 0, 100);
      }
    }
  }

  void addNeighbour(int px, int py) {
    if (!OOB(px, py)) {
      neighbours.add(cells[px][py]);
    }
  }
  @Override
    String toString() {
    return "(" + x + "," + y + ") n(" + neighbours.size() + ")";
  }

  void findNeighbours() {
    addNeighbour(x, y-1);
    addNeighbour(x-1, y);
    addNeighbour(x+1, y);
    addNeighbour(x, y+1);



    //println(this);
    countNeighbours = neighbours.size();

    //for (int ix = -1; ix < 2; ix += 1) {
    //  for (int iy = -1; iy < 2; iy += 1) {
    //    if (ix == 0 && iy == 0) continue;
    //    addNeighbour(x + ix, y + iy);
    //  }
    //}
  }

  @Override 
    int hashCode() {
    return id_hash;
  }

  @Override
    boolean equals(Object o) {
    if (o instanceof Cell) {
      if (((Cell)o).id == id) {
        return true;
      }
    }
    return false;
  }
}
