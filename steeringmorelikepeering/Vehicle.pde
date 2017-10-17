class Vehicle {
  float maxSpeed = 4;
  float maxForce = 0.05;
  PVector pos, acc, vel;


  Vehicle(float x, float y) {
    this.pos = new PVector(x, y);
    acc = new PVector();
    vel = new PVector();
  }

  void update() {
    //float angle = PVector.dot(vel, acc);
    //float mag = acc.mag();
    //if (angle < -PI/12) {
    //  acc = PVector.fromAngle(-PI/12);
    //  acc.setMag(mag);
    //} else if (angle > PI/12) {
    //  acc = PVector.fromAngle(PI/12);
    //  acc.setMag(mag);
    //}
    
    
      
    
    vel.add(acc);
    vel.limit(maxSpeed);
    acc.mult(0);
    pos.add(vel);
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, pos);
    //desired.normalize();
    float dist = desired.mag();
    if (dist < 100) {
      desired.setMag(map(dist, 0, 100, 0, maxSpeed));
    } else {
      desired.setMag(maxSpeed);
    }
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxForce);
     
    applyForce(steer);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void draw() {
    stroke(255);
    fill(128);
    pushMatrix();

    translate(pos.x, pos.y);
    rotate(vel.heading()+ PI/2);
    beginShape();
    vertex(0, -10);
    vertex(5, 5);
    vertex(-5, 5);
    endShape(CLOSE);
    popMatrix();
  }
}