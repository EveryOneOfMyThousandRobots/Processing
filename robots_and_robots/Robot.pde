//enum ROBOT_STATE {
//  IDLE, CHECKING_ITEM, FETCHING_COMPONENT, DELIVERING_COMPONENT, RETURNING_COMPONENT, 
//    FETCHING_ITEM, DELIVERING_ITEM;

//  //String toString() {
//  //  return this.name;
//  //}
//}
final float MIN_DIST = 20;

boolean deliveringItemTo(Tbl bin ) {
  for (Robot robot : robots) {
    if (robot.deliveringItemTo(bin)) {
      return true;
    }
  }
  return false;
}
class Robot {
  float maxSpeed = 5;
  float maxForce = 0.2;
  final float radius = MIN_DIST/2; 
  InstructionList tasks = null;
  Instruction currentTask = null;
  PVector pos, vel, acc;
  PVector startingPos;

  float facing = 0;
  //holding
  boolean holding = false;
  Component holdingComponent = null;
  int holdingComponentQty = 0;
  Item holdingItem = null;

  color c;


  Robot (float x, float y, color c) {
    pos = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();
    this.c = c;
    startingPos = pos.copy();
  }

  void update() {
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
    
    vel.mult(0.95);
    if (vel.mag() < 0.1) {
      vel.set(0,0);
      facing = lerp(facing, 0, 0.01);
    } else {
      facing = vel.heading() + HALF_PI;
    }

  }

  boolean deliveringItemTo(Tbl bin) {
    if (currentTask != null) {
      if (currentTask.item != null && currentTask.bin.equals(bin)) {
        return true;
      } else {
        for (Instruction task : tasks.list) {
          if (task.item != null && task.bin.equals(bin)) {
            return true;
          }
        }
      }
    }

    return false;
  }

  void pickup() {
    if (currentTask.item != null && currentTask.bin.item.equals(currentTask.item)) {
      holdingItem = currentTask.item;
      currentTask.bin.item = null;
      if (currentTask.bin.assigned) {
        currentTask.bin.assigned = false;
      }
    } else if (currentTask.component != null && currentTask.bin.component.equals(currentTask.component)) {
      holdingComponent = currentTask.component;
      holdingComponentQty = 1;
    }
  }

  void deliver() {
    if (holdingItem != null) {
      currentTask.bin.item = holdingItem;
      holdingItem = null;
      currentTask.bin.assigned = false;
    } else if (holdingComponent != null) {
      if (currentTask.bin.item != null) {
        currentTask.bin.item.addComponent(holdingComponent, 1);
      }
      //currentTask.bin.component = holdingComponent;
      holdingComponent = null;
    }
  }

  void checkTask() {
    if (currentTask != null) {
      switch (currentTask.type) {
      case MOVE:
        if (PVector.dist(pos, currentTask.target) < MIN_DIST) {

          currentTask = null;
        } else {
          steer(currentTask.target);
        }      
        break;
      case FETCH:
        if (PVector.dist(currentTask.bin.pos, pos) < MIN_DIST) {
          pickup();
          currentTask = null;
        } else {
          steer(currentTask.bin.pos);
        }
        break;
      case DELIVER:
        if (PVector.dist(currentTask.bin.pos, pos) < MIN_DIST) {
          deliver();
          currentTask = null;
        } else {
          steer(currentTask.bin.pos);
        }
        break;
      }
    } else {
      if (tasks != null) {
        currentTask = tasks.pop();
        if (currentTask == null) {
          tasks = null;
        }
      } else {
        if (PVector.dist(pos, startingPos) < MIN_DIST) {
          vel.mult(0.8);
          facing = lerp(facing, 0, 0.1);
        } else {
          steer(startingPos);
        }
      }
    }
  }


  void steer(Tbl table) {
    steer(table.pos);
  }

  void steer(PVector target) {
    PVector desired = PVector.sub(target, pos);
    desired.normalize();
    desired.mult(maxSpeed);

    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxForce);
    float dist = PVector.dist(pos, target);
    if (dist < 100) {
      steer.mult(dist / 100.0);
    }
    applyForce(steer);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }


  void brake() {
    //log("brake");
    acc.mult(0);
    vel.mult(0);
  }



  void draw() {
    boolean drawHolding = false;
    color holdingColour = color(255);
    if (holdingItem != null ) {
      drawHolding = true;
      holdingColour = color(255,0,0);
    } else if (holdingComponent != null) {
      holdingColour = color(255);
      drawHolding = true;
    }
    String text = "";
    if (holdingItem != null) {
      text = "item:"+holdingItem.name;
    } else if (holdingComponent != null) {
      text = "cmp:"+holdingComponent.name;
    } else if (currentTask != null) {
      text = "task:"+currentTask.type.toString();
    }
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(facing);
    rectMode(CENTER);
    stroke(0);
    fill(c);
    rect(0, 0, radius*2, radius*2);
    rectMode(CORNER);
    rect(-radius-3, -radius - 3, 3,radius);
    rect(radius, -radius - 3, 3,radius);
    
    rect(-radius-3,(-radius*2)+3,radius,3);
    rect(3,(-radius*2)+3, radius,3);
    
    if (drawHolding) {
      fill(holdingColour);
      rect(-3,(-radius*2),6,6);
    }
    //fill(0);
    //text(text, -radius, -radius - 10);
    popMatrix();
    fill(0);

    //float x = pos.x + radius;
    //float y = pos.y;

    //y += 10;
    //for (String s : log) {
    //  text(s, x, y);
    //  y += 10;
    //}
  }
}
