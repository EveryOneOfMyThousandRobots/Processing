class Agent {
  BlockingQueue<String> instructions = new LinkedBlockingQueue<String>();
  String current = null;
  String currentAction = null;

  int timer = 0;
  boolean acting = false;
  PVector pos;
  PVector target;
  float speed = 4;

  Agent(int x, int y) {
    Tile t = getTile(x, y);
    this.pos = new PVector(t.cx, t.cy);
    target = new PVector(0, 0);
  }

  void complete() {
    println("complete");
    current = null;
    acting = false;
  }
  void update() {
    if (current == null) {
      current = instructions.poll();
    } else {
      if (!acting) {
        parseInstruction();
      } else {
        switch(currentAction) {
        case "WAIT":
          timer -= time_delta;
          if (timer <= 0) {
            complete();
          }
          break;
        case "MOVE": 
          PVector p = PVector.sub(target, pos);
          if (p.mag() <= speed) {
            Tile t = getTileFromWorld(pos.x, pos.y);
            pos.set(t.cx, t.cy);
            complete();
          } else {
            p.normalize();
            p.mult(speed * deltaTime);
            pos.add(p);
          }
        }
      }
    }
  }

  void draw() {
    stroke(255, 128, 0);
    fill(255);
    ellipse(pos.x, pos.y, 5, 5);
  }

  void parseInstruction() {
    String[] currentAr = current.split(" ");
    currentAction = currentAr[0];
    println(currentAr.length);
    switch(currentAction) {
    case "MOVE":
      if (currentAr.length == 3) {
        int x = Integer.valueOf(currentAr[1]);
        int y = Integer.valueOf(currentAr[2]);
        Tile t = getTile(x, y);
        target.set(t.cx, t.cy);
        acting = true;
        println("MOVING TO " + x + "," + y);
      } else {
        println("\"" + current + "\" is invalid");
        current = null;
        currentAction = null;
      }
      break;
    case "WAIT":
      acting = true;
      timer = Integer.valueOf(currentAr[1]);
      println("WAITING FOR " + timer);
      break;
    default:
      acting = false;
      current = null;
      currentAction = null;
      println("INVALID INPUT");
    }
  }
}
