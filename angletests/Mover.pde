class Mover {
  PVector pos, acc, vel, posPrime;
  float facing;
  
  Mover() {
    pos = new PVector(width / 2, height / 2);
    posPrime = pos.copy();
    acc = new PVector();
    vel = PVector.random2D();
    vel.mult(random(1,4));
  }
  
  
  void applyForce(PVector force) {
    acc.add(force);
    
  }
  void update() {
    vel.add(acc);
    vel.limit(3);
    acc.mult(0);
    posPrime.set(pos);
    posPrime.add(vel);
    for (Obstacle o : obstacles) {
      if (o.collides(posPrime)) {
        EDGE e = o.whichEdge(posPrime);
        //println(e);
        if (e == EDGE.TOP_BOTTOM) {
          vel.y *= -1;
        } else {
          vel.x *= -1;
        }
       
        //vel.mult(-1);
      }
    }
    pos.add(vel);
     
    
    facing = vel.heading() + HALF_PI;
    
    if (pos.x < 0) {
      pos.x = width;
    } else if (pos.x > width) {
      pos.x = 0;
    } 
    
    if (pos.y < 0) {
      pos.y = height;
    } else if (pos.y > height) {
      pos.y = 0;
    }
  }
  
  void draw() {
     pushMatrix();
     translate(pos.x, pos.y);
     rotate(facing);
     beginShape();
     vertex(0,-10);
     vertex(5,5);
     vertex(-5,5);
     endShape(CLOSE);
     popMatrix();
    
  }
}