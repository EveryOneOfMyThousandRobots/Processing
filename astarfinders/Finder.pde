
final int DEFAULT_PICKLIST_LIMIT = 30;
class Finder {
  Node[][] nodes;
  float totalCost;
  ArrayList<Node> openSet, closedSet, path;
  //STATE state = STATE.IDLE;
  PVector pos, vel, acc;
  float maxSpeed;
  Node start, end;
  Grid grid;
  ArrayList<Cell> picklist = new ArrayList<Cell>();
  int ticketsCompleted = 0;
  int itemsPicked, framesTaken;
  int id = getNextId("FINDER");
  color c = color(random(128, 255), random(128, 255), random(128, 255));
  PVector newPos;
  int clipTimer = 0;

  String toString() {
    return id + " " + nf(maxSpeed, 1, 2) + " t:" + ticketsCompleted + " i:" + itemsPicked + " pl:" + picklist.size();
  }

  void applyForce(PVector force) {
    acc.add(force);
    acc.limit(maxSpeed);
  }

  Finder(Cell cell) {
    pos = cell.pos.copy();
    newPos = pos.copy();
    this.grid = cell.grid;
    maxSpeed = bellRandom(1, 5);

    nodes = new Node[grid.cols][grid.rows];

    for (int ix = 0; ix < grid.cells.length; ix += 1) {
      for (int iy = 0; iy < grid.cells[ix].length; iy += 1) {
        Node n = new Node(grid.cells[ix][iy]);
        nodes[ix][iy] = n;
        //println(n.id + " (" + n.ix + "," + n.iy + ")");
      }
    }

    for (int ix = 0; ix < nodes.length; ix += 1) {
      for (int iy = 0; iy < nodes[ix].length; iy += 1) {
        nodes[ix][iy].findNeighbours(nodes);
      }
    }

    openSet = new ArrayList<Node>();
    closedSet = new ArrayList<Node>();
    path = new ArrayList<Node>();


    //resetStart();
    //for ( ix = 0; ix < nodes.length; ix += 1) {
    //  for ( iy = 0; iy < nodes[ix].length; iy += 1) {
    //    Node n = nodes[ix][iy];

    //    if (n.type == CellType.DROPOFF) {
    //      end = n;
    //    }
    //  }
    //}
  }

  void makePicklist() {
    int upperLimit = DEFAULT_PICKLIST_LIMIT;
    if (grid.pickups.size() < upperLimit) {
      upperLimit = grid.pickups.size();
    }
    int r1 = floor(bellRandom(1, upperLimit));
    picklist.clear();

    while (picklist.size() < r1) {
      Cell c = grid.getRandomPickup();
      if (!picklist.contains(c)) {
        picklist.add(c);
      }
    }
    picklist.sort(ccomp);
    itemsPicked += picklist.size();
    ticketsCompleted += 1;
    picklist.add(0, grid.checkin);
    picklist.add(grid.getRandomDropOff());
  }

  void resetNodes() {
    for (int ix = 0; ix < nodes.length; ix += 1) {
      for (int iy = 0; iy < nodes[ix].length; iy += 1) {
        nodes[ix][iy].clear();
      }
    }
  }

  void resetStart() {
    openSet.clear();
    closedSet.clear();
    path.clear();

    if (picklist.isEmpty()) {
      makePicklist();
    }

    resetNodes();

    int ix = floor(pos.x / res);
    int iy = floor(pos.y / res);

    start = nodes[ix][iy];
    end = null;
    openSet.add(start);
    Cell d = picklist.get(0);
    picklist.remove(0);


    end = nodes[d.ix][d.iy];


    //println("\nstart: " + start + "\nend: " + end);
  }

  boolean findPath() {
    boolean found = false;
    totalCost = 0;
    while (!openSet.isEmpty()) {
      int winner = 0;
      for (int i = 0; i < openSet.size(); i += 1) {
        if (openSet.get(i).f < openSet.get(winner).f) {
          winner = i;
        }
      }

      Node current = openSet.get(winner);

      path.clear();

      Node temp = current;
      path.add(temp);
      totalCost += temp.f;
      while (temp.previous != null) {
        path.add(temp.previous);
        totalCost += temp.previous.f;
        temp = temp.previous;
      }

      if (current.id == end.id) {
        found = true;
        return true;
        //println("DONE");
        //println(path);
        //stop();
      } 
      openSet.remove(current);
      closedSet.add(current);
      ArrayList<Node> neighbours = current.neighbours;
      for (Node n : neighbours) {
        if (!closedSet.contains(n) && n.type != CellType.WALL) {
          float tempG = current.g + PVector.dist(current.pos, n.pos);
          boolean newPath = false;
          if (openSet.contains(n)) {
            if (tempG < n.g) {
              n.g = tempG;
              newPath = true;
            }
          } else {
            n.g = tempG;
            openSet.add(n);
            newPath = true;
          }

          if (newPath) {
            n.h = heuristic(n, end);
            n.f = n.g + n.h;
            n.previous =current;
          }
        }
      }
    }
    return found;
  }

  void update() {
    if (path.isEmpty()) {



      resetStart();
      findPath();
    } else {
      Node n = path.get(path.size()-1);
      PVector t = n.pos;
      vel = PVector.sub(t, pos);

      newPos.set(pos);
      newPos.add(vel);
      boolean clipped = false;
      //PVector clippedVector = null;

      for (Finder f : finders) {
        if (f.id == this.id) continue;

        if (PVector.dist(f.pos, this.newPos) <= float(res)) {
          //clippedVector = f.pos.copy();
          clipped = true;
          break;
        }
      }
      if (clipTimer > 0) {
        vel.setMag(maxSpeed / 4);
        clipped= false;
        clipTimer -= 1;
      }

      if (clipped) {
        clipTimer = 50;
        //vel = PVector.sub(pos, clippedVector);
        vel.setMag(maxSpeed / 4);
        pos.add(vel);
        openSet.clear();
        closedSet.clear();
        path.clear();
        Cell c = grid.getCellAtPos(pos);
        openSet.add(nodes[c.ix][c.iy]);
        start = nodes[c.ix][c.ix];
        resetNodes();
        findPath();
        println("finding new path");
      } else {
        if (clipTimer > 0) {
          vel.setMag(maxSpeed / 3);
        } else {
          vel.setMag(maxSpeed);
        }
        pos.add(vel);
        int ix = floor(pos.x / res);
        int iy = floor(pos.y / res);
        if (ix == n.ix && iy == n.iy) {
          n.cell.traffic += 0.1;
          path.remove(path.size()-1);
        }
      }
      framesTaken +=1;
    }
  }



  void draw(int debug) {
    stroke(0);
    fill(c);
    ellipse(pos.x, pos.y, res, res);


    if (debug >= 2) {
      fill(0, 255, 0);
      for (Node p : openSet) {
        ellipse(p.pos.x, p.pos.y, 5, 5);
      }
    }

    if (debug >= 3) {
      fill(0, 0, 255);
      for (Node p : closedSet) {
        ellipse(p.pos.x, p.pos.y, 5, 5);
      }
    }

    if (debug >= 1) {
      fill(255, 0, 0);
      for (Node p : path) {
        ellipse(p.pos.x, p.pos.y, 5, 5);
      }

      for (Cell cell : picklist) {
        stroke(c);
        noFill();
        rect(cell.pos.x + 2, cell.pos.y + 2, cell.size - 4, cell.size - 4);
      }
      stroke(0);

      if (start != null) {
        fill(c);
        ellipse(start.pos.x, start.pos.y, 10, 10);
      }

      if (end != null) {
        fill(c);
        ellipse(end.pos.x, end.pos.y, 10, 10);
      }
    }
  }
}