enum ROBO_STATE {
  RESET, IDLE, GET_TICKET, GET_NEXT_TICKET_LINE, GOTO_DEST, GOTO_BAY, PICK_FROM_BAY, GOTO_DROPOFF, DROPOFF, FIND_PATH;
}

class Robot {
  ROBO_STATE state = ROBO_STATE.IDLE;
  ROBO_STATE newState = ROBO_STATE.IDLE;
  ROBO_STATE newStateWhenMoved = null;
  int x, y;
  float speed = 2;
  String prog = "";
  PVector pos, vel, acc;
  PVector mPos;
  Path path = null;
  Node currentTarget = null;
  Ticket ticket = null;
  TicketItem currentTicketItem = null;
  Node currentDestination = null;
  int ticketLineIndex = 0;
  HashMap<Item, Integer> inventory = new HashMap<Item, Integer>();
  Robot(int x, int y) {
    this.x = x;
    this.y = y;

    pos = new PVector(x * NODE_SIZE, y * NODE_SIZE);
    vel = new PVector();
    acc = new PVector();
    mPos = pos.copy();
    mPos.x += (NODE_SIZE/2);
    mPos.y += (NODE_SIZE/2);
  }

  void applyForce(PVector f) {
    acc.add(f);
  }

  void updatePos() {
    //pos.set(x*NODE_SIZE, y*NODE_SIZE);
    x = floor(pos.x / NODE_SIZE);
    y = floor(pos.y / NODE_SIZE);
    mPos.set(pos.x + (NODE_SIZE/2), pos.y + (NODE_SIZE/2));
  }
  void update(float deltaTime) {



    switch(state) {
    case RESET:
      path = null;
      ticket = null;
      currentDestination = null;
      currentTarget = null;
      newStateWhenMoved = null;
      newState = ROBO_STATE.IDLE;
      break;
    case IDLE:
      newState = ROBO_STATE.GET_TICKET;
      break;
    case GET_TICKET:
      ticket = manager.getTicket();
      if (ticket != null) {
        newState = ROBO_STATE.GET_NEXT_TICKET_LINE;
        ticketLineIndex = -1;
      }
      break;
    case FIND_PATH:
      if (currentDestination != null) {
        path = new Path(getNode(x, y), currentDestination);
        if (path.findPath()) {
          newState = ROBO_STATE.GOTO_DEST;
        }
      }
      break;
    case GOTO_DEST:
      if (currentDestination != null && path != null) {

        if (currentTarget == null) {
          if (path.path.isEmpty()) {
            path = null;
            newState = newStateWhenMoved;
          } else {

            currentTarget = path.path.get(0);

            path.path.remove(0);
          }
        } else {
          applyForce(PVector.sub(currentTarget.mPos, mPos).setMag(speed*deltaTime));
          vel.add(acc);
          vel.limit(speed);
          pos.add(vel);
          acc.mult(0);
          if (PVector.dist(mPos, currentTarget.mPos) <= speed) {
            pos.set(currentTarget.pos);
            currentTarget = null;
            vel.mult(0);
          }
          updatePos();
        }
      }
      break;

    case GET_NEXT_TICKET_LINE:
      ticketLineIndex += 1;
      if (ticketLineIndex > ticket.pickList.size()-1) {
        newState = ROBO_STATE.GOTO_DROPOFF;
      } else {
        currentTicketItem = ticket.pickList.get(ticketLineIndex);
        newState = ROBO_STATE.GOTO_BAY;
      }

      break;
    case  GOTO_BAY:
      currentDestination = currentTicketItem.bay.node;
      newState = ROBO_STATE.FIND_PATH;
      newStateWhenMoved = ROBO_STATE.PICK_FROM_BAY;
      break;
    case  PICK_FROM_BAY:
      int qty = currentTicketItem.bay.removeQty(currentTicketItem.item, currentTicketItem.qtyLeftToPick);
      if (qty > 0) {
        currentTicketItem.qtyLeftToPick -= qty;
        currentTicketItem.bay.deAllocated(currentTicketItem.item, qty);
      } else {
      }
      newState = ROBO_STATE.GET_NEXT_TICKET_LINE;
      break;
    case  GOTO_DROPOFF:
      currentDestination = dropoff;
      newState = ROBO_STATE.FIND_PATH;
      newStateWhenMoved = ROBO_STATE.DROPOFF;    
      break;
    case  DROPOFF:
      manager.complete(ticket);
      newState = ROBO_STATE.RESET;
      break;
    }
    state = newState;

    /*
    if (ticket == null) {
     }
     
     if (path == null) {
     path = new Path(getNode(x, y), getRandomNode());
     path.findPath();
     } else {
     
     
     if (currentTarget == null) {
     if (path.path.isEmpty()) {
     path = null;
     } else {
     
     currentTarget = path.path.get(0);
     
     path.path.remove(0);
     }
     } else {
     applyForce(PVector.sub(currentTarget.mPos, mPos).setMag(speed*deltaTime));
     vel.add(acc);
     vel.limit(speed);
     pos.add(vel);
     acc.mult(0);
     if (PVector.dist(mPos, currentTarget.mPos) <= speed) {
     pos.set(currentTarget.pos);
     currentTarget = null;
     vel.mult(0);
     }
     updatePos();
     }
     }
     */
  }

  void draw() {
    stroke(255);
    fill(255, 128, 60);
    rect(pos.x, pos.y, NODE_SIZE, NODE_SIZE);
    //if (path != null) {
    //  stroke(0, 0, 255, 128);
    //  fill(0, 0, 128, 128);
    //  for (Node n : path.path) {
    //    ellipse(n.mPos.x, n.mPos.y, 5, 5);
    //  }
    //}
  }
}

void mouseClicked() {
  robots.get(0).path = null;
}
