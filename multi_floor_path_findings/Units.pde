import java.util.HashSet;
enum UNIT_STATE {
  IDLE, 
    MOVING, 
    CHECK_JOBS,
}

class UnitManager {
  HashMap<String, Integer> roles = new HashMap<String, Integer>();

  ArrayList<Unit> units = new ArrayList<Unit>();

  void UpdateAndDraw(float time_delta) {
    for (Unit unit : units) {
      unit.update(time_delta);
      unit.draw();
    }
  }
  
  
}

class Unit {
  Node nodePosition;
  Node nodeTarget;
  float t = 0;
  float speed = 0.7;
  Path path;
  UNIT_STATE state = UNIT_STATE.IDLE;
  UNIT_STATE newState = state;


  Unit(Node startNode) {
    this.nodePosition = startNode;
    println(this.nodePosition);
  }




  void update(float deltaTime) {
    switch (state) {
    case IDLE:
      if (random(1) < 0.01) {
        wander();
      }
      break;
    case CHECK_JOBS:
      {
      }

      break;
    case MOVING:
      if (path == null) {
        newState = UNIT_STATE.IDLE;
      } else {
        if (t >= 1) {

          nodePosition = nodeTarget;
          if (path.path.size() > 0) {
            nodeTarget = path.path.get(0);
            path.path.remove(0);
          }

          t = 0;
          if (path.path.size() == 0) {
            path = null;
            newState = UNIT_STATE.IDLE;
          }
        } else {
          t += speed * deltaTime;
        }
      }

      break;
    }
    state = newState;
  }

  void wander() {
    Node n = getRandomNode(nodePosition);

    if (n != null) {
      path = new Path(nodePosition, n);
      if (path.findPath()) {
        newState = UNIT_STATE.MOVING;
        nodeTarget = path.path.get(0);
        path.path.remove(0);
      } else {
        path = null;
      }
    }
  }



  void draw() {
    float x = nodePosition.pos.x;
    float y = nodePosition.pos.y;
    if (nodeTarget != null) {
      x = x + (t * (nodeTarget.pos.x - nodePosition.pos.x));
      y = y + (t * (nodeTarget.pos.y - nodePosition.pos.y));
    }
    stroke(255, 0, 0);
    fill(255);
    rect(x - playXOffset, y - playYOffset, 3, 3);
  }
}
