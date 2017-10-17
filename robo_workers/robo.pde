enum STATE {
  IDLE, WORKING, CARRYING;
}
int ROBO_ID = 0;
class Robo implements Comparable<Robo> {
  int id;
  ArrayList<Cell> closedSet = new ArrayList<Cell>();
  ArrayList<Cell> openSet = new ArrayList<Cell>();
  ArrayList<Cell> path = new ArrayList<Cell>();
  {
    ROBO_ID += 1;
    id = ROBO_ID;
  }
  PVector pos, vel, acc,newPos;
  float facing;
  STATE state;
  float maxSpeed;// = 2;
  float maxForce;// = 0.5;
  float rad = 5;
  float diam = rad*2;
  Job job = null;
  PVector start;
  int jobsCompleted = 0;
  int frameCounter = 0; 
  float fitness = 1;
  float avoidDist;
  Cell target = null;

  int compareTo(Robo o) {
    if (fitness > o.fitness) {
      return 1;
    } else return 0;
  }

  Robo(float x, float y) {
    pos = new PVector(x, y);
    newPos = new PVector();
    start = pos.copy();
    vel = new PVector();
    acc = new PVector();
    state = STATE.IDLE;
    maxSpeed = random(1, 4);
    maxForce = random(0.1, 1);
    avoidDist = diam*2;
  }

  void applyForce(PVector force) {
    acc.add(force);
    acc.limit(maxSpeed);
  }

  int hashCode() {
    return id;
  }

  String toString() {
    return id + " f:" + nf(fitness, 1, 2) + " t:" + frameCounter + " j:" + jobsCompleted + " s:" + state;
  }

  void setJob(Job job) {
    this.job = job;
    state = STATE.WORKING;
  }

  void findPath(Cell target) {
    this.target = target;
    openSet.clear();
    closedSet.clear();
    path.clear();
    openSet.add(grid.getAtPos(pos.x, pos.y).copy());
    float totalCost = 0;
    while (!openSet.isEmpty()) {
      int winner = 0;
      for (int i = 0; i < openSet.size(); i += 1) {
        if (openSet.get(i).f < openSet.get(winner).f) {

          winner = i;
        }
      }

      Cell current = openSet.get(winner);
      path.clear();
      Cell temp = current;
      path.add(temp);
      while (temp.previous != null) {
        path.add(temp.previous);
        totalCost += temp.previous.f;
        temp = temp.previous;
      }
      if (current.id == target.id) {
        println("done");
      } else {
        openSet.remove(current);
        closedSet.add(current);

        ArrayList<Cell> neighbours = current.neighbours;
        for (Cell n : neighbours) {
          float tempG = current.g + PVector.dist(current.pos, n.pos);
          boolean newPath = false;
          if (openSet.contains(n) && !n.wall) {
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
            n.h = heuristic(n, target);
            n.f = n.g + n.h;
            n.previous = current;
          }
        }
      }
    }
  }

  void update() {
    for (int i = 0; i < robos.size(); i += 1) {
      Robo o = robos.get(i);
      if (o.id != id) {
        float dist = PVector.dist(o.pos, pos);
        if (dist < avoidDist) {
          PVector p = PVector.sub(pos, o.pos).normalize();
          p.setMag(maxSpeed);
          PVector p2 = PVector.sub(o.pos, pos).normalize();
          p2.setMag(o.maxSpeed);
          applyForce(p);
          o.applyForce(p2);
        }
      }
    }
    
    
    
    

    vel.add(acc);
    vel.limit(maxSpeed);
    
    newPos.set(pos.x + vel.x, pos.y + vel.y);
    Cell cell = grid.getAtPos(newPos.x,newPos.y);
    if (cell.wall) {
      vel.mult(0);
    }
    pos.add(vel);
    acc.mult(0);
    facing = vel.heading();
    vel.mult(0.99);  

    if (state == STATE.IDLE) {
      if (jobs.size() > 0) {
        jobs.addBid(this);


        findPath(grid.getAtPos(start.x, start.y));
      }
    }

    if (job != null) {
      frameCounter += 1;
      PVector target = null;
      if (state == STATE.WORKING) {

        target = job.pickup.actionPos.copy();
      } else if (state == STATE.CARRYING) {
        target = job.dropoff.actionPos.copy();
      }

      if (target != null) {
        if (PVector.dist(pos, target) < diam) {
          if (state == STATE.WORKING) {
            state = STATE.CARRYING;
            job.pickup.waiting = false;
            jobsCompleted += 1;
            fitness = pow(2.0 + ( 1.0 / (float(frameCounter) / float(jobsCompleted))), 2);
          } else if (state == STATE.CARRYING) {
            state = STATE.IDLE;

            job = null;
          }
        } else {
          findPath(grid.getAtPos(target.x, target.y));
          if (path.size() > 0) {
            seek(path.get(0).pos);
            
          }
        }
      }
    }
  }



  void seek(PVector target) {
    PVector desired = PVector.sub(target, pos);
    //desired.normalize();
    float dist = desired.mag();
    if (dist < 100) {
      desired.setMag(map(dist, 0, diam*3, 0, maxSpeed));
    } else {
      desired.setMag(maxSpeed);
    }
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxForce);
    applyForce(steer);
  }



  void draw() {
    switch (state) {
    case IDLE:
      fill(0, 255, 255);
      break;
    case WORKING:
      fill(128, 255, 255);
      break;
    case CARRYING:
      fill(200, 255, 255);
      break;
    }
    //fill(255);
    stroke(0);    
    pushMatrix();
    rectMode(CENTER);
    translate(pos.x, pos.y);
    rotate(facing + PI/2);
    beginShape();
    vertex(0, -rad);
    vertex(rad, rad);
    vertex(-rad, rad);
    endShape(CLOSE);
    popMatrix();
  }
}