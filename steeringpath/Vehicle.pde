class Vehicle {
  float maxSpeed = 4;
  float maxForce = 0.2;
  PVector pos, acc, vel;
  float rad = 5;
  float diam = rad * 2;


  Vehicle(float x, float y) {
    this.pos = new PVector(x, y);
    acc = new PVector(0,0);
    vel = new PVector(0,0);
    maxSpeed = random(1,5);
    maxForce = random(0.1,0.6);
  }

  void update() {
    //println(pos + " " + vel + " " + acc);
    vel.add(acc);
    vel.limit(maxSpeed);
    
    pos.add(vel);
    acc.mult(0);
    //
    if (pos.x < -diam) {
      pos.x = width + diam;
    }

    if (pos.x > width + diam) {
      pos.x = -diam;
    }

    if (pos.y < -diam) {
      pos.y = width + diam;
    }

    if (pos.y > width + diam) {
      pos.y = - diam;
    }
  }
  
  void follow(ArrayList<Path> paths) {
    Path shortest = null;
    float shortestDist = 1000000;
    for (Path path : paths) {
      float dist = follow(path, false);
      if (dist < shortestDist) {
        shortest = path;
        shortestDist = dist;
      }
    }
    
    if (shortest != null) {
      follow(shortest, true);
    }
  }

  float follow(Path path, boolean seek) {
    PVector predict = vel.copy();
    predict.normalize();
    predict.mult(maxSpeed * 10);
    predict.add(pos);
    PVector normal = getNormalPoint(path,predict,path.start,path.end);
    float dist = PVector.dist(predict, normal);
    if (dist > path.r && seek) {
      seek(normal);
    }
    return dist;
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, pos);
    //desired.normalize();
    //float dist = desired.mag();
    //if (dist < 100) {
    //  desired.setMag(map(dist, 0, 100, 0, maxSpeed));
    //} else {
      desired.setMag(maxSpeed);
    //}
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
    vertex(0, -diam);
    vertex(rad, rad);
    vertex(-rad, rad);
    endShape(CLOSE);
    popMatrix();
    
    //flowfield.drawVector(PVector.sub(vel, pos),pos.x,pos.y,0.5);
  }
}