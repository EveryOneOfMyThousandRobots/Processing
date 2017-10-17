int pom1() {
  int r = floor(random(100));
  r = r % 2;
  if (r == 0) {
    return -1;
  } else {
    return 1;
  }
}

class C {
  ArrayList<Job> jobs = new ArrayList<Job>();

  Job current = null;
  int timer = 0;
  int numJobs;
  int jobIndex = -1;
  PVector pos, vel, acc;
  float fitness = 0;
  int lifeTime = 0;

  {
    pos = start.copy();//new PVector(10, width / 2);
    vel = new PVector();
    acc = new PVector();
  }

  C() {


    numJobs = floor(random(5, 50));
    for (int i = 0; i < numJobs; i += 1) {
      jobs.add(new Job());
    }
  }

  C(C parent) {
    numJobs = parent.numJobs;
    if (random(1) <= MUTATION_RATE) {
      numJobs += pom1();
    }
    if (numJobs < 5) {
      numJobs = 5;
    } else if  (numJobs > 50) {
      numJobs = 50;
    }

    for (int i = 0; i < numJobs; i += 1) {
      if (i <= parent.numJobs-1) {
        jobs.add(new Job(parent.jobs.get(i)));
      } else {
        jobs.add( new Job());
      }
    }

    for (int i = jobs.size()-1; i >= 0; i -= 1) {
      if (random(1) < 0.005) {
        jobs.remove(i);
      }
    }

    while (jobs.size() < numJobs) {
      Job j = new Job();
      int r = floor(random(jobs.size()));
      jobs.add(r, j);
    }
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void update() {

    lifeTime += 1;
    if (current == null) {
      jobIndex += 1;
      if (jobIndex > jobs.size() -1) {
        jobIndex = 0;
      }
      current = jobs.get(jobIndex);
      timer = current.time;
    }
    if (timer == current.time) {
      applyForce(current.dir);
    }
    timer -= 1;

    if (timer <= 0) {
      current = null;
    }

    vel.add(acc);
    vel.limit(6);

    acc.mult(0);
    PVector newPos = PVector.add(pos, vel);
    if (newPos.x - 5 < 0) {
      newPos.x = 5;
    }
    if (newPos.x + 5 > width) {
      newPos.x = width - 5;
    }
    if (newPos.y -5 < 0) {
      newPos.y = 5;
    }
    if (newPos.y + 5> height) {
      newPos.y = height - 5;
    }

    for (Obstacle o : blocks) {
      if (o.intersects(newPos, 10, 10)) {
        newPos.set(pos);
        break;
      }
    }

    pos.set(newPos);
    float dist = PVector.dist(pos, target);
    float f = 1 + (1 / dist) + (1 / numJobs) + (pos.x / 100.0);
    fitness = pow(f, 3);
    //if (f > fitness) {
    //  fitness = f;
    //}


    vel.mult(0.95);
  }

  void draw() {
    stroke(255);
    fill(128);
    ellipse(pos.x, pos.y, 10, 10);
    text(fitness, pos.x + 20, pos.y);
  }

  String toString() {
    String output = "C num(" + numJobs + ")";

    for (Job j : jobs) {
      output += "\n\t" + j.toString();
    }

    return output;
  }
}