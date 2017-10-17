import java.util.Stack;
import java.util.Queue;
import java.util.concurrent.ArrayBlockingQueue;

int WORKER_ID = 0;
class Worker {
  int carrying = 0;
  PVector pos;
  float speed;
  float facing;
  WorkTile target = null;
  Instruction current = null;
  int currentIndex = -1;
  int numInstructions = 1;
  private boolean getNext =false;
  int id;
  int waitingCount = 0;
  int patience;

  ArrayList<Instruction> todo = new ArrayList<Instruction>();


  Worker() {
    pos = new PVector(random(width), random(height));
    speed = 4;
    WORKER_ID += 1;
    id = WORKER_ID;
    patience = floor(random(100,1000));
  }

  String toString() {
    return ""+ id;
  }

  void getInstructions() {
    carrying = 0;
    todo.clear();
    println(id + ": getting instructions");
    for (int i = 0; i < numInstructions; i += 1) {
      todo.add(new Instruction());
    }
    reset();
  }

  void reset() {
    if (todo.size() == 0) {
      getInstructions();
    } else {
      if (getNext) {
        getNext = false;
        currentIndex += 1;
        if (currentIndex > todo.size()-1) {
          reset();
        } else {
          current = todo.get(currentIndex);
          current.reset();
        }
      } else {
        currentIndex = 0;
        current = todo.get(currentIndex);
        current.reset();
      }
    }
  }



  void update() {
    int action = ACTION_NONE;
    if (current == null ) {
      reset();
    } else {
      if (current.failed) {
        todo.remove(currentIndex);
        current = null;
        getNext = true;
      } else if (current.success) {
        getNext = true;
        current = null;
      } else {
        if (!current.pickedup) {
          target = current.pickup;
          action = ACTION_PICKUP;
        } else {
          target = current.dropoff;
          action = ACTION_DROP;
        }
        PVector targetV = PVector.sub(target.pos, pos).normalize();
        targetV.mult(speed);
        float dist = PVector.dist(target.pos, pos);
        facing = targetV.heading();
        if (dist < tileSize) {
          //do something
          if (action == ACTION_PICKUP) {
            if (target.heldProduce >= 1) {
              //println(id + ": waiting for resource");
              carrying = target.produces;
              current.pickedup = true;
              target.heldProduce -= 1;
              waitingCount = 0;
              println(id + ": picking up " + getResourceName(target.produces));
            } else {
              println(id + ": waiting for " + getResourceName(target.produces));
              waitingCount += 1;
              if (waitingCount > patience) {
                current.failed = true;
                
              }
            }
          } else if (action == ACTION_DROP) {
            if (carrying == target.consumes) {
              target.heldConsumable += 1;
              carrying = 0;
              current.success = true;
              successes += 1;
            } else {
              current.failed = true;
              carrying = 0;
            }
          }
        } else {
          //move
          pos.add(targetV);
        }
      }
    }
  }
  void draw() {
    stroke(255);
    fill(128, 255, 255);
    float r = tileSize*2;
    ellipse(pos.x, pos.y, tileSize, tileSize);
    float x = pos.x + r * cos(facing);
    float y = pos.y + r * sin(facing);

    line(pos.x, pos.y, x, y);
  }
}


int INSTRUCTION_ID = 0;
class Instruction {
  WorkTile pickup = null; 
  WorkTile dropoff = null; 
  boolean pickedup = false;
  boolean success = false;
  boolean failed = false;
  void reset() {
    pickedup = false;
    success = false;
    failed = false;
  }
  final int id;

  //int action;
  int hashCode() {
    return id *31;
  }

  Instruction () { // 0 = pickup, 1 = drop
    INSTRUCTION_ID += 1;
    id = INSTRUCTION_ID;
    boolean found = false; 
    while (!found) {
      int r1 = floor(random(workTiles.size())); 
      int r2 = floor(random(workTiles.size()));

      if (r1 == r2) continue;

      pickup = workTiles.get(r1);

      dropoff = workTiles.get(r2);
      if (dropoff.consumes == 0) {
      } else {
        found = true;
      }
    }
  }
}



class WorkTile {
  Tile tile; 
  color col; 
  final int produces; 
  final int consumes; 
  final int requiredConsumable;
  int heldProduce;
  int heldConsumable;
  int timer; 
  int interval;
  final float x;
  final float y;
  final PVector pos;
  int producedSomethingCounter = 0;
  color leftColour;
  color rightColour;

  WorkTile (Tile t) {
    requiredConsumable = floor(random(1, 5));
    this.tile = t; 
    col = color(random(255), random(255), 255); 
    produces = floor(random(RESOURCE_LOWEST_NUM, RESOURCE_HIGHEST_NUM+1));
    rightColour = getResourceColour(produces);
    if (random(1) < 0.25) {
      consumes = floor(random(RESOURCE_HIGHEST_NUM+1));
      leftColour = getResourceColour(consumes);
    } else {
      consumes = 0;
      leftColour = color(0);
    }

    this.x = tile.pos.x;
    this.y = tile.pos.y;
    pos = new PVector(x, y);
    interval = floor(random(100, 500));
    println("tile consumes " + consumes + " " + getResourceName(consumes) + " " + 
      " produces " + produces + " " + getResourceName(produces));
  }

  void update() {
    timer += 1;
    if (timer >= interval) {
      if (consumes > 0 ) {
        if (heldConsumable >= requiredConsumable) {
          timer = 0;
          heldConsumable -= requiredConsumable;
          heldProduce += 1;
          producedSomethingCounter = 25;
        }
      } else {
        heldProduce += 1;
        producedSomethingCounter = 25;
        timer = 0;
      }
    }
  }

  void draw() {
    fill(leftColour); 
    stroke(255); 
    rect(tile.pos.x, tile.pos.y, tileSize / 2, tileSize);
    fill(rightColour);
    rect(tile.pos.x + (tileSize / 2), tile.pos.y, tileSize / 2, tileSize);
    if (producedSomethingCounter > 0) {
      ellipse(tile.pos.x, tile.pos.y, tileSize*3, tileSize*3);
      producedSomethingCounter -= 1;
    }
  }
}