float maxSteeringForce = 0.2;
float maxSpeed = 3;

class Agent {
  final int id;
  final int idHash;
  {
    ID += 1;
    id = ID;
    idHash = Integer.hashCode(id);
  }



  PVector pos, vel, acc;
  float alignRadius = 50;
  float separationRadius = 25;
  float cohestionRadius = 75 ;
  Agent(float x, float y) {
    pos = new PVector(x, y);
    vel = PVector.random2D();
    vel.mult(random(maxSpeed/2, maxSpeed));
    acc = new PVector();
  }

  void flock(ArrayList<Agent> agents) {
    PVector force = null;
    force = align(agents);
    force.limit(maxSteeringForce);
    acc.add(force);
    force = cohesion(agents);
    force.limit(maxSteeringForce);
    acc.add(force);
    force = separation(agents);
    acc.add(force);
    
    for (Block b : blocks) {
      Surface s = b.collidesWith(pos.x, pos.y);
      
      if (s != null) {
        PVector sum = new PVector();
        int counter = 0;
        for (int i = 0; i < s.forces.length; i += 1) {
          PVector fp = s.forcePoints[i];
          PVector f = s.forces[i];
          
          float d = PVector.dist(pos, fp);
          
          
          //sum.add(f.copy().mult(100 * (1 / (d * d))));
          sum.add(f.copy().mult(d*d));
          counter += 1;
          
        }
        if (counter > 0) {
          sum.div(counter);
          //sum.setMag(maxSpeed);
          sum.sub(vel);
          sum.limit(maxSteeringForce*4);
          acc.add(sum);
        }
      }
    }
  }

  PVector separation (ArrayList<Agent> list) {
    PVector steer = new PVector();
    int counter = 0;
    for (Agent a : list) {
      if (!equals(a) && agentDist(a) <= separationRadius ) {
        PVector diff = PVector.sub(pos, a.pos);
        
        
        diff.mult(1 / diff.mag());
        steer.add(diff);
        counter += 1;
      }
    }
    if (counter > 0) {
      steer.div(counter);
      steer.setMag(maxSpeed);
      steer.sub(vel);
      steer.limit(maxSteeringForce);
    }
    return steer;
  }

  PVector cohesion (ArrayList<Agent> list) {
    PVector steer = new PVector();
    int counter = 0;
    for (Agent a : list) {
      if (!equals(a) && agentDist(a) <= cohestionRadius ) {
        steer.add(a.pos);
        counter += 1;
      }
    }
    if (counter > 0) {
      steer.div(counter);
      steer.setMag(maxSpeed);
      steer.sub(vel);
      steer.limit(maxSteeringForce);
    }
    return steer;
  }

  PVector align (ArrayList<Agent> list) {
    PVector steer = new PVector();
    int counter = 0;
    for (Agent a : list) {
      if (!equals(a) && agentDist(a) <= alignRadius ) {
        steer.add(a.vel);
        counter += 1;
      }
    }
    if (counter > 0) {
      steer.div(counter);
      steer.setMag(maxSpeed);
      steer.sub(vel);
      steer.limit(maxSteeringForce);
      
    }
    return steer;
  }

  void update() {


    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);

    if (pos.x < 0) {
      pos.x = width;
    } 

    if (pos.x > width) {
      pos.x = 0;
    }

    if (pos.y < 0) {
      pos.y = height;
    } 

    if (pos.y > height) {
      pos.y = 0;
    }
  }

  float agentDist(Agent a) {
    return pos.dist(a.pos);
  }


  void draw() {
    stroke(0);
    fill(0);
    ellipse(pos.x, pos.y, 3, 3);
  }

  int hashCode() {
    return idHash;
  }

  boolean equals(Object o ) {
    if (o instanceof Agent) {
      Agent a = (Agent) o;
      if (a.id == this.id) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
