PGraphics trail;
float G = 1000;
int agent_id = 0;
class Agent {
  final int id;
  {
    agent_id += 1;
    id = agent_id;
  }
  float zoff = random(0,5);
  ArrayList<PVector> posList = new ArrayList<PVector>();
  ArrayList<Float> velList = new ArrayList<Float>();
  PVector prevPos, pos, vel, acc, target;
  float maxSpeed = 8;
  float maxForce = 0.3;

  float minRange, maxRange;
  float minAngle, maxAngle;
  boolean hasSplit = false;
  boolean finished = false;

  Agent(float x, float y, float angle) {


    minRange = 10;
    maxRange = 50;
    minAngle = angle-HALF_PI;
    maxAngle = angle+HALF_PI;


    pos = new PVector(x, y);

    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    target = pos.copy();
    prevPos = pos.copy();
  }

  void setNewTarget() {
    zoff += 1;
    float r = random(minRange, maxRange);
    float rr = noise(pos.x + random(1), pos.y + random(1),zoff);
    float angle = map(rr,0,1,minAngle, maxAngle);
    target.set(pos.x + r * cos(angle), pos.y + r * sin(angle));
  }

  void scanPosList() {
    if (finished) return;
    for (int i = posList.size()-2; i >= 1; i -= 1) {
      if (i % 2 == 0) {
        posList.remove(i);
      }
    }
  }



  void applyForce(PVector force) {
    acc.add(force);
  }
  void update() {
    if (finished) return;
    
    if (posList.size() == 0 || frameCount % 10 == 0) {
      posList.add(pos.copy());
    }
    
    avoid();
    prevPos.set(pos.x, pos.y);
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);

    float dist = PVector.dist(pos, target);
    if (dist < minRange) {
      setNewTarget();
    }
    if (!hasSplit && random(1000) < 1 ) {
      float na = atan2(vel.y, vel.x) + radians(random(-5, 5));

      agents.add(new Agent(pos.x, pos.y, na));
      hasSplit = true;
    }

    //for (Block b : blocks ) {
    //  float d = PVector.dist(pos, b.pos);

    //  if (d < b.r) {
    //    avoid(b);
    //    break;
    //  }
    //}
  }
  
  void avoid() {
    PVector sum = new PVector(0,0);
    for (Agent other : agents) {
      if (other.id == id) return;
      
      for (PVector p : posList) {
         PVector repel = PVector.sub(pos,p);
         float magSq = repel.magSq();
         repel.normalize();
         repel.div(G / magSq);

         sum.add(repel);
      }
    }
    applyForce(sum);
    
  }

  void avoid(Block b) {
    PVector desired = PVector.sub(pos, b.pos);
    float dist = desired.mag();
    desired.normalize();

    if (dist < maxRange) {
      desired.mult(map(dist, 0, maxRange, 0, maxSpeed));
    } else {
      desired.mult(maxSpeed);
    }
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxForce);
    applyForce(steer);
  }

  void seek() {
    PVector desired = PVector.sub(target, pos);
    float dist = desired.mag();
    desired.normalize();

    if (dist < maxRange) {
      desired.mult(map(dist, 0, maxRange, 0, maxSpeed));
    } else {
      desired.mult(maxSpeed);
    }
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxForce);
    applyForce(steer);
  }

  void draw() {
    if (finished) {
      stroke(0);
      
      PVector prev = posList.get(0).copy();
      for (float t = 0; t < (float)posList.size()-3; t += 0.005) {
        PVector p = GetSplinePoint(posList, t, false);

        line(prev.x, prev.y, p.x, p.y);
        prev = p;
        map.setByScreenPos(p.x,p.y);
      }
      //for(int i = 0; i < posList.size()-1; i += 1) {
      //  PVector a = posList.get(i);
      //  PVector b = posList.get(i+1);
      //  line(a.x, a.y, b.x, b.y);

      //}
    } else {
      stroke(0);
      fill(0);
      ellipse(pos.x, pos.y, 4, 4);
      fill(255, 0, 0);
      ellipse(target.x, target.y, 4, 4);

      PVector A = new PVector(vel.y, -vel.x);
      A.normalize();

      A.mult(vel.mag() * 3);
      PVector B = A.copy();
      B.mult(-1);
      A.add(pos);
      B.add(pos);
      trail.beginDraw();

      trail.stroke(0);
      trail.line(prevPos.x, prevPos.y, pos.x, pos.y);
      trail.stroke(255, 0, 0, 128);
      trail.line(A.x, A.y, B.x, B.y);

      trail.endDraw();
    }
  }
}
