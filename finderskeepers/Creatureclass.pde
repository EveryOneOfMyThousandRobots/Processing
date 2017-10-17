int BOT_ID = 0;
boolean DRAW_PATH = false;
boolean DRAW_SIGHT_LINE = false;

class C {
  ArrayList<PVector> prevPositions = new ArrayList<PVector>();
  String firstName;
  String lastName;
  PVector pos;
  PVector acc;
  PVector vel;
  DNA dna;
  float fitness = 0;
  int countStuckFrames = 0;
  int countOfEyes;
  float[] eyes;
  float[] dist;
  float[] viewDist;
  float facing;
  Brain brain;
  int parent1_id = 0;
  int parent2_id = 0;


  float w, h;
  final int id;

  float distToEnd;
  PVector dirToEnd;
  Arena arena;

  String toString() {
    String output = "\nBot\n\tEyes (" + countOfEyes + "):";


    for (int i = 0; i < eyes.length; i += 1) {
      output += "\n\t\t" + eyes[i] + " dist: " + viewDist[i];
    }

    output += "\nfacing: " + facing;


    output += dna.toString();


    return output;
  }

  C(Arena arena, String lastName) {
    this.arena = arena;
    this.w = arena.scale;
    this.h = arena.scale;
    pos = new PVector(arena.start.x, arena.start.y);
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
    dna  = new DNA();

    if (lastName == null ) {
      this.lastName = getLastName();
    } else {
      this.lastName = lastName;
    }

    firstName = getFirstName();


    facing = 0;
    brain = new Brain(17, 3, 12, 2, dna);

    BOT_ID += 1;
    id = BOT_ID;
    brain.setFromDNA();

    setFromDNA();
    prevPositions.add(pos.copy());
  }

  //breeed
  C cross (C partner) {
    C c = new C(arena, lastName);

    c.dna = this.dna.cross(partner.dna);
    c.parent1_id = id;
    c.parent2_id = partner.id;
    c.mutate();
    c.setFromDNA();

    return c;
  }

  void mutate() {
    dna.mutate();
  }

  void setFromDNA() {
    countOfEyes = 8; //floor(dna.get("countOfEyes", 1, 6));

    eyes = new float[countOfEyes];
    dist = new float[countOfEyes];
    viewDist = new float[countOfEyes];
    for (int i = 0; i < eyes.length; i += 1) {
      eyes[i] = (TWO_PI / 8) * i;//dna.get("eye_angle_" + i, 0, TWO_PI);
      viewDist[i] = width; //dna.get("eye_view_dist_" + i, 1, 150);
    }
    brain.setFromDNA();
  }

  void look() {
    for (int i = 0; i < eyes.length; i += 1 ) {
      float angle = facing + eyes[i];
      dist[i] = -1;

      PVector ww = PVector.fromAngle(angle);
      PVector p = ww.copy();
      p.normalize();
      PVector posa = pos.copy();
      posa.x += w / 2;
      posa.y += h / 2;


      boolean collides = false;
      for (float d = 0; d < viewDist[i]; d += 1) {
        posa.add(p.x, p.y);

        for (Wall wall : arena.walls) {
          if (wall.collides(posa)) {
            collides = true;
            break;
          }
        }
        if (collides) break;
      }

      if (collides) {
        dist[i] = 1 / PVector.dist(pos, posa);
        if (DRAW_SIGHT_LINE) {
          if (dist[i] > 0) {
            stroke(map(dist[i], 0, 1, 0, 255));
            line(pos.x + (w/2), pos.y + (h/2), posa.x, posa.y);
          }
        }
      }
    }
  }


  void applyForce(PVector p) {
    this.acc.add(p.copy());
  }

  void update() {

    vel.add(acc);
    vel.mult(0.95); //drag
    vel.limit(3);
    acc.mult(0);

    PVector newPos = PVector.add(pos, vel);
    PVector topRight = new PVector(newPos.x + w, newPos.y);
    PVector bottomRight = new PVector(newPos.x + w, newPos.y + h);
    PVector bottomLeft = new PVector(newPos.x, newPos.y + h);

    boolean collides = false;
    for (Wall wall : arena.walls) {
      if (wall.collides(newPos) | wall.collides(topRight) | wall.collides(bottomRight) | wall.collides(bottomLeft)) {
        collides = true;

        break;
      }
    }
    if (!collides) {
      if (DRAW_PATH) {
        prevPositions.add(pos.copy());
      }
      pos = newPos;
      countStuckFrames = 0;
    } else {
      countStuckFrames += 1;
    }
    look();
    //check obstacles
    float[] inputs = new float[brain.inputs.length];

    int i = 0;
    for (i = 0; i < dist.length; i += 1) {
      inputs[i] = dist[i];
    }
    eval();
    inputs[8] = map(distToEnd, 0, width * 2, 0, 1);

    if (Float.isNaN(pos.x)) pos.x = arena.start.x;
    if (Float.isNaN(pos.y)) pos.x = arena.start.y;
    inputs[9] = map(pos.x, 0, width, 0, 1);
    inputs[10] = map(pos.y, 0, height, 0, 1);
    //inputs[11] = facing;
    inputs[12] = dirToEnd.x;
    inputs[13] = dirToEnd.y;
    inputs[14] = countStuckFrames;
    inputs[15] = frameCount % 25;
    inputs[16] = frameCount;
    // inputs[inputs.length-1] = 1;
    brain.setInputs(inputs);
    brain.calc();

    // facing += brain.getOutput(0);
    PVector p = new PVector(brain.getOutput(0), brain.getOutput(1));
    p.mult(0.2);
    applyForce(p);
  }

  void eval() {
    distToEnd = PVector.dist(pos, arena.end);
    dirToEnd = PVector.sub(arena.end, pos);
    dirToEnd.normalize();
    float distFromStart = PVector.dist(pos, arena.start);

    if (Float.isNaN(distFromStart)) {
      distFromStart = 0;
    }
    if (Float.isNaN(distToEnd)) {
      distToEnd = width * 2;
    }
    fitness = map(distFromStart, 0, width*2, 1, 2) + map(distToEnd, 0, width * 2, 3, 1) - (countStuckFrames/10.0 );
    fitness = pow(fitness, 4);
  }



  void draw() {
    //pushMatrix();
    //translate(pos.x, pos.y );
    //rectMode(CENTER);
    //rotate(facing);
    noStroke();
    if (pop.fittestLastRound != null) {
      if (parent1_id == pop.fittestLastRound.id || parent2_id == pop.fittestLastRound.id) {
        stroke(0);
      }
    }

    fill(0, 0, 200, 100);
    rect(pos.x, pos.y, w, h);

    if (DRAW_PATH) {
      PVector a = null;
      PVector b = null;
      for (int i = 1; i < prevPositions.size(); i += 1) {
        a = prevPositions.get(i-1);
        b = prevPositions.get(i);
        stroke(51);
        line(a.x, a.y, b.x, b.y);
      }
      if (b != null) {
        line(b.x, b.y, pos.x, pos.y);
      }
    }
    //popMatrix();
  }
}