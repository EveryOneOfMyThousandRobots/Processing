class Man {
  Brain brain;
  float facing;
  float viewAngle;
  float viewRange;
  float size = 10;

  PVector pos;
  float fitness;
  float[] inputs;
  ArrayList<Bullet> shots = new ArrayList<Bullet>();
  int shootCountDown;
  float shootCountDownLimit = 25;
  float shootDist;
  Genome genome;

  Man baby() {
    Man m = new Man();
    m.genome = new Genome(genome);
    m.genome.mutate();    
    m.brain = brain.copy(genome);
    //m.shootCountDownLimit = shootCountDownLimit + random(-0.01, 0.01);
    //m.shootDist = shootDist + random(-1, 1);
    //m.viewAngle = viewAngle + random(-0.01, 0.01);
    //m.viewRange = viewRange + random(-0.01, 0.01);
    m.setGenome();
    return m;
  }

  Man() {
    pos = new PVector(width / 2, height / 2);
    // Brain(int numInputs, int numLayers, int numPerLayer, int numOutputs) {
    brain = new Brain(15, 2, 5, 7);
    facing = radians(90);
    genome = new Genome();

    //viewAngle = radians(45);
    //viewRange =  random(50, 150);
    inputs = new float[15];
    //shootDist = viewRange;

    setGenome();
  }

  void setGenome() {
    genome.add("viewAngle");
    viewAngle = map(genome.get("viewAngle"), 0, 999, 30, 90);
    genome.add("viewRange");
    viewRange = map(genome.get("viewRange"), 0, 999, 50, 150);
    genome.add("shootDist");
    shootDist = map(genome.get("shootDist"), 0, 999, 50, 150);
    genome.add("shootCountDownLimit");
    shootCountDownLimit = map(genome.get("shootDist"), 0, 999, 25, 50);
  }

  void shoot() {
    shots.add(new Bullet(pos.x, pos.y, facing, shootDist));
  }

  void update() {
    PVector m = pos.copy();
    int ii = 3;
    //println("\n" + frameCount + " facing: " + facing);
    for (float a = facing - viewAngle; a < facing + viewAngle; a += ((viewAngle * 2) / 5)) {
      ii += 1;
      boolean collision = false;
      boolean target = false;
      // print(a +  "\n    " ) ;
      PVector mm = m.copy();
      PVector xx = PVector.fromAngle(a);//.normalize();

      for (float r = 1; r < viewRange; r += 1) {

        //xx.setMag(r);
        //  print(" (" + floor(xx.x) + "," + floor(xx.y) + ") ");
        mm.add(xx);
        for (Wall w : walls) {
          if (w.collides(mm.x, mm.y)) {
            collision = true;
            break;
          }
        }
        if (collision) {
          break;
        } else {
          for (Target t : targets) {
            if (t.hit) continue; 

            if (t.collides(mm.x, mm.y)) {
              collision = true;
              target = true;
              fitness +=  0.1;
            }
          }
        }
      }
      if (collision) {
        if (target) {
          inputs[ii+5] = PVector.dist(pos, mm);
          if (refreshScreen) {
            stroke(255, 0, 0);
            line(pos.x, pos.y, mm.x, mm.y);
          }
        } else {
          inputs[ii] = PVector.dist(pos, mm);
          if (refreshScreen) {
            stroke(255);
            line(pos.x, pos.y, mm.x, mm.y);
          }
        }
      }
      stroke(255);
    }

    if (facing > TWO_PI) {
      facing -= TWO_PI;
    }
    inputs[0] = facing;
    inputs[1] = pos.x;
    inputs[2] = pos.y;
    inputs[3] = frameCount;
    brain.setInputs(inputs);

    brain.calc();
    if (brain.output.values[5] + brain.output.values[6] > 0) {
      facing += radians(1);
    } else {
      facing -= radians(1);
    }
    //facing += 0.001* map(brain.output.values[5]+ brain.output.values[6], -2, 2, 0, TWO_PI);
    float newX = 0;//pos.x + brain.output.values[0] - brain.output.values[1];
    float newY = 0;//pos.y + brain.output.values[2] - brain.output.values[3];
    PVector newP = PVector.fromAngle(facing).normalize();
    newP.mult(1 + (map(brain.output.values[0] + brain.output.values[1], -2, 2, -0.1,0.1)));
    
    //newP.add()/1000, (brain.output.values[2] + brain.output.values[3])/1000);
    newP.add(pos);
    newX = newP.x;
    newY = newP.y;
    //newP.mult(newX);
    //newX = newP.x;
    //newY = newP.y;
    boolean collides = false;
    for (Wall w : walls) {
      if (w.collides(newX, newY, size)) {
        collides = true;
        break;
      }
    }
    if (!collides && !outOfBounds(newX, newY, size)) {
      fitness += 0.01 * PVector.dist(pos, new PVector(newX, newY));
      pos.x = newX;
      pos.y = newY;
    } else {
      fitness -= 0.1;
    }



    for (int i = shots.size() - 1; i >= 0; i -= 1) {
      Bullet b = shots.get(i);
      b.update();
      if (b.hitTarget) {
        fitness += 10;
        b.hitTarget = false;
        shots.remove(i);
      }
    }
    if (brain.output.values[4] > 0.5 && shootCountDown == 0) {
      shoot();
      shootCountDown = floor(shootCountDownLimit);
      //     fitness -= 0.01;
    }
    if (shootCountDown > 0 ) {
      shootCountDown -= 1;
    }
  }

  void draw() {
    stroke(255);
    fill(0);
    ellipse(pos.x, pos.y, size * 2, size * 2);
    fill(255);
    text(fitness, pos.x + size*2, pos.y);
    for (int i = shots.size()-1; i >= 0; i -= 1) {
      Bullet b = shots.get(i);
      b.draw();
    }
  }
}