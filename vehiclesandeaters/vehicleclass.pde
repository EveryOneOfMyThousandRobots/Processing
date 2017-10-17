// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// The "Vehicle" class
import java.util.TreeMap;

boolean debug_mode = false;

class Vehicle {
  float age = 0;
  float lifeSpan;
  boolean alive = true;
  PVector acc, vel, pos;
  float health = 1;
  float healthCap = 4;
  float r = 3;
  float maxspeed; //= 2.5;
  float maxforce;// = 0.2;
  TreeMap<String, Float> dna;
  //health from food
  float healthFromGood;
  float healthLossFromPoision;
  float goodSteerFactor;
  float badSteerFactor;
  float healthLossPerUpdate;


  float foodViewDist, poisonViewDist;
  Vehicle(float x, float y, TreeMap<String, Float> DNA) {
    pos = new PVector(x, y);
    acc = new PVector();
    vel = new PVector();
    if (DNA != null) {
      dna = new TreeMap<String, Float>(); 
      for (String s : DNA.keySet()) {
        dna.put(s, DNA.get(s));
      }
      mutate();
    } else {
      newDNA();
    }
    setFromDNA();
  }

  void mutate(String s, float min, float max) {
    dna.put(s, dna.get(s) + random(min, max));
  }

  void mutate() {
    mutate("goodSteerFactor", -0.1, 0.1);
    mutate("badSteerFactor", -0.1, 0.1);
    mutate("foodViewDist", -1, 1);
    mutate("poisonViewDist", -1, 1);
    mutate("lifeSpan", -4, 4);
    mutate("healthFromGood", -0.1, 0.1);
    mutate("healthLossFromPoision", -0.1, 0.1);
    mutate("healthLossPerUpdate", -0.0001, 0.0001);
    mutate("maxspeed", -0.01, 0.01);
    mutate("maxforce", -0.005, 0.005);
    
    
  }

  void newDNA() {
    dna = new TreeMap<String, Float>();//new float[8]; 
    dna.put("goodSteerFactor", random(-3, 3));
    dna.put("badSteerFactor", random(-3, 3));
    dna.put("foodViewDist", random(10, 120));
    dna.put("poisonViewDist", random(10, 120));
    dna.put("lifeSpan", random(500, 1000));
    dna.put("healthFromGood", random(0, 1));
    dna.put("healthLossFromPoision", random(-1, -0.1));
    dna.put("healthLossPerUpdate", random(0.0001, 0.001));
    dna.put("maxspeed", random(0.1, 3));
    dna.put("maxforce", random(0.01, 1));
    
  }
  void setFromDNA() {
    goodSteerFactor = dna.get("goodSteerFactor");
    badSteerFactor = dna.get("badSteerFactor");

    //food radius
    foodViewDist = dna.get("foodViewDist");
    //poison radius

    poisonViewDist = dna.get("poisonViewDist");

    lifeSpan = dna.get("lifeSpan");

    healthFromGood = dna.get("healthFromGood");

    healthLossFromPoision = dna.get("healthLossFromPoision");
    healthLossPerUpdate = dna.get("healthLossPerUpdate");
    maxspeed  = dna.get("maxspeed");
    maxforce = dna.get("maxforce");
  }

  void baby() {
    Vehicle baby = new Vehicle(pos.x, pos.y, dna);
    vehicles.add(baby);
  }

  void behaviours(ArrayList<PVector> good, ArrayList<PVector> bad) {
    PVector steerGood = eat(good, healthFromGood, foodViewDist);
    PVector steerBad = eat(bad, healthLossFromPoision, poisonViewDist);
    if (steerGood != null) {
      steerGood.mult(goodSteerFactor);
      applyForce(steerGood);
    }
    if (steerBad != null ) {
      steerBad.mult(badSteerFactor);


      applyForce(steerBad);
    }
  }

  PVector eat(ArrayList<PVector> list, float nutrition, float viewDist) {
    if (!alive) return null;
    float closest = width * 10;
    int closestIndex = -1;
    for (int i = 0; i < list.size(); i += 1) {
      float thisDist = PVector.dist(pos, list.get(i));
      if (thisDist > viewDist) continue;
      if (thisDist < closest) {
        closest = thisDist;
        closestIndex = i;
      }
    }

    if (closestIndex >= 0 ) {

      if (closest < 5) {
        list.remove(closestIndex);
        health += nutrition;
        if (health > healthCap) {
          baby();
          health /= 4;
        }
      } else {
        return seek(list.get(closestIndex));
      }
    }

    return null;
  }



  // Method to update location
  void update () {
    age += 1;
    health -= healthLossPerUpdate;
    if (health <= 0 || age > lifeSpan) {
      alive = false;
    } else {
      // Update velocity
      vel.add(acc);
      // Limit speed
      vel.limit(maxspeed);
      pos.add(vel);
      // Reset accelerationelertion to 0 each cycle
      acc.mult(0);
      if (vel.mag() == 0) {
        
        applyForce(PVector.random2D().setMag(maxspeed));
      }
    }
    boundaries();
  }

  void applyForce (PVector force) {
    // We could add mass here if we want A = F / M
    acc.add(force);
  }

  // A method that calculates a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek (PVector target) {

    PVector desired = PVector.sub(target, pos);  // A vector pointing from the location to the target

    // Scale to maximum speed
    desired.setMag(maxspeed);

    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired, vel);
    steer.limit(this.maxforce);  // Limit to maximum steering force
    return steer;
    //this.applyForce(steer);
  }

  void draw() {
    // Draw a triangle rotated in the direction of velocity
    float theta = vel.heading() + PI/2;

    color col = lerpColor(RED, GREEN, health);
    fill(col);
    stroke(200);
    strokeWeight(1);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    beginShape();
    vertex(0, -this.r*2);
    vertex(-this.r, this.r*2);
    vertex(this.r, this.r*2);
    endShape(CLOSE);
    noFill();
    if (debug_mode) {
      stroke(0, 255, 0, 128);
      ellipse(0, 0, foodViewDist*2, foodViewDist*2);
      stroke(255, 0, 0, 128);
      ellipse(0, 0, poisonViewDist*2, poisonViewDist*2);
    }

    popMatrix();
  }

  void boundaries() {

    PVector desired = null;

    if (pos.x < distFromEdge) {
      desired = new PVector(this.maxspeed, this.vel.y);
    } else if (this.pos.x > width - distFromEdge) {
      desired = new PVector(-this.maxspeed, this.vel.y);
    }

    if (this.pos.y < distFromEdge) {
      desired = new PVector(this.vel.x, this.maxspeed);
    } else if (this.pos.y > height-distFromEdge) {
      desired = new PVector(this.vel.x, -this.maxspeed);
    }

    if (desired != null) {
      desired.normalize();
      desired.mult(this.maxspeed);
      PVector steer = PVector.sub(desired, this.vel);
      steer.limit(this.maxforce);
      this.applyForce(steer);
    }
  }
}