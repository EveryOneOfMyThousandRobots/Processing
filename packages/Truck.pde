
enum TRUCKSTATE {
  WAITING, MOVING, PICKUP_DROP, RETURN_TO_START;
}
class Truck {
  int carryLimit = 6;
  Node A, B;
  PVector pos, vel;
  PVector startPos;
  float facing;
  final int id;
  TRUCKSTATE state = TRUCKSTATE.WAITING;
  float speed;
  Node goingTo = null;
  Node takingTo = null;
  int timer = 0;
  float rotA = 0, rotAi = radians(3);
  ArrayList<Carton> cartons = new ArrayList<Carton>();

  boolean overCarryLimit() {
    return (cartons.size() >= carryLimit);
  }

  {
    TRUCK_ID += 1;
    id = TRUCK_ID;
  }

  Truck(Node A, Node B) {
    this.A = A;
    this.B = B;
    pos = PVector.sub(B.pos, A.pos).div(2).add(A.pos);
    startPos = pos.copy();
    vel = new PVector();
    speed=  random(1, 3);
  }

  int hashCode() {
    return id * 13;
  }

  boolean equals(Truck o) {
    return (o.id == id);
  }

  void update() {
    if (vel.mag() == 0) {
      facing = PVector.sub(A.pos, B.pos).heading() + HALF_PI;
    } else {
      facing = vel.heading() + HALF_PI;
    }

    if (timer > 0) {
      timer -= 1;
    }

    switch(state) {
    case RETURN_TO_START:
      vel = PVector.sub(startPos, pos );
      vel.normalize();
      vel.mult(speed);
      pos.add(vel);
      if (PVector.dist(pos, startPos) < speed) {
        state = TRUCKSTATE.WAITING;
        timer = TRUCK_WAIT_TIMER;
      }
      break;
    case WAITING:

      if (timer == 0) {
        if (!overCarryLimit() && checkNode(A, B)) {
          goingTo = A;
          takingTo = B;
          state = TRUCKSTATE.MOVING;
        } else if (!overCarryLimit() && checkNode(B, A)) {
          goingTo = B;
          takingTo = A;
          state = TRUCKSTATE.MOVING;
        } else if (anythingGoingTo(A)) {
          goingTo = A;
          takingTo = B;
          state = TRUCKSTATE.MOVING;
        } else if (anythingGoingTo(B)) {
          goingTo = B;
          takingTo = A;
          state = TRUCKSTATE.MOVING;
        }
      }
      break;
    case MOVING:
      if (goingTo != null) {
        vel = PVector.sub(goingTo.pos, pos );
        vel.normalize();
        vel.mult(speed);
        pos.add(vel);
        if (PVector.dist(pos, goingTo.pos) < 2) {
          pos.set(goingTo.pos);
          state = TRUCKSTATE.PICKUP_DROP;
          timer = TRUCK_PICKUP_WAIT;
        }
      }
      break;
    case PICKUP_DROP:
      if (timer != 0) return;
      if (goingTo != null) {
        //anything to deliver?
        for (int i = cartons.size() - 1; i >= 0; i -= 1) {
          Carton c = cartons.get(i);

          if (c.next.equals(goingTo)) {
            goingTo.cartons.add(c);
            c.truck = null;
            c.pathIndex += 1;
            cartons.remove(i);
          }
        }
        //anything to pickup?
        boolean nothing = true;
        for (int i = goingTo.cartons.size() - 1; i >= 0; i -= 1) {
          Carton c = goingTo.cartons.get(i);
          if (c.next.equals(takingTo)) {
            nothing =false;
            c.pickup(this);
            cartons.add(c);
            goingTo.cartons.remove(i);
            if (overCarryLimit()) {
              state = TRUCKSTATE.RETURN_TO_START;
              break;
            } else {
              break;
            }
          }
        }

        if (nothing) {
          state = TRUCKSTATE.RETURN_TO_START;
        }
      }
      break;
    }



    //if (state == TRUCKSTATE.WAITING) {
    //  //check points
    //  goingTo = null;
    //  takingTo = null;

    //  if (checkNode(A, B)) {
    //    goingTo = A;
    //    takingTo = B;
    //  } else if (checkNode(B, A)) {
    //    goingTo = B;
    //    takingTo = A;

    //  }

    //  if (goingTo != null) {
    //    vel = PVector.sub(pos, goingTo.pos);
    //    vel.normalize();
    //    vel.mult(speed);
    //    state = TRUCKSTATE.MOVING;    
    //  }

    //} else if (state == TRUCKSTATE.MOVING) {
    //  pos.add(vel);
    //  if (PVector.dist(pos, goingTo.pos) < 3) {
    //    pos.set(goingTo.pos);

    //    for (int i = goingTo.cartons.size() - 1; i >= 0; i -= 1) {
    //      Carton c = goingTo.cartons.get(i);

    //      if (c.next.equals(takingTo)) {
    //        c.pickup(this);
    //        cartons.add(c);

    //      }
    //    }

    //  }

    //}
  }

  boolean  anythingGoingTo(Node checking) {
    boolean worthGoing = false;
    for (Carton c : cartons) {
      if (c.next.equals(checking)) {
        worthGoing = true;
        break;
      }
    }

    return worthGoing;
  }

  boolean checkNode(Node checking, Node taking) {
    boolean worthGoing = false;
    for (Carton c : checking.cartons) {
      if (c.next.equals(taking)) {
        worthGoing = true;
        break;
      }
    }

    return worthGoing;
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(facing);
    rectMode(CENTER);
    noStroke();
    fill(255, 0, 128);
    rect(0, 0, 5, 10);

    popMatrix();

    float r = CARTON_ORBIT_RADIUS;

    rotA += rotAi;


    float cs = cartons.size();

    if (cs > 0 ) {

      float ai = TWO_PI / cs;
      float a = rotA;
      for (int i = 0; i < cs; i += 1) {
        Carton c = cartons.get(i);
        c.draw(pos.x, pos.y, r, a);

        a += ai;
      }
    }
  }
}

class ConnPair {
  Node A, B;
  ConnPair(Node A, Node B) {
    this.A = A;
    this.B = B;
  }
}

void makeTrucks() {
  Map<String, ConnPair> pairs = new TreeMap<String, ConnPair>(); 
  for (Conn c : connections) {
    String s = min(c.from.id, c.to.id) + "_" + max(c.from.id, c.to.id);

    pairs.put(s, new ConnPair(c.from, c.to));
  }

  for (String k : pairs.keySet()) {
    ConnPair cp = pairs.get(k);
    println(k + " " + cp.A + " " + cp.B);
    Truck t = new Truck(cp.A, cp.B);
    trucks.add(t);
  }
}
