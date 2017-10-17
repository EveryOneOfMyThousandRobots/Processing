
class ActionPoint {
  PVector pos;
  PVector actionPos;
  float size = ACTION_POINT_SIZE;
  color c;
  int id;
  {
    ACTION_POINT_ID += 1;
    id = ACTION_POINT_ID;
  }
  
  ActionPoint(float x, float y, color c) {
    pos = new PVector(x,y);
    actionPos = new PVector(x + ACTION_POINT_SIZE / 2, y + ACTION_POINT_SIZE / 2);
    this.c = c;
    
  }
  
  void draw() {
    rectMode(CORNER);
    stroke(0);
    fill(c);
    rect(pos.x, pos.y, size, size);
  }
}

class Pickup extends ActionPoint {
  boolean waiting = false;
  color col_idle, col_waiting;
  Pickup(float x, float y, color c) {
    super(x,y,c);
    col_idle = c;
    col_waiting = color(0,0,255);
  }
  
  void update() {
    if (random(1) < 0.01 && !waiting && jobs.size() < JOB_LIMIT) {
      int r1 = floor(random(dropoffs.size()));
      DropOff d = dropoffs.get(r1);
      
      Job job = new Job(this, d);
      
      jobs.add(job);
      waiting = true;
    }
    if (waiting) {
      c = col_waiting;
    } else {
      c = col_idle;
    }
  
  }
  
  
  
  
  
}

class DropOff extends ActionPoint {
  DropOff(float x, float y, color c) {
    super(x,y,c);
  }
  

}