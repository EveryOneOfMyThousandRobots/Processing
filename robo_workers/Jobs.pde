//import java.util.PriorityQueue;
final int JOB_MINIMUM_BIDS = 5;
class Jobs {
  ArrayList<Job> jobs = new ArrayList<Job>();
  void add(Job job) {
    jobs.add(job);
  }

  int size() {
    return jobs.size();
  }

  Job peek() {
    return jobs.get(0);
  }

  Job poll() {
    Job j = peek();
    jobs.remove(0);
    return j;
  }

  void update() {
    for (int i = 0; i < jobs.size(); i += 1) {
      Job j = jobs.get(i);
      if (j.bids.size() >= j.minimum_bids) {
        Robo bestRobo = null;
        float fittest = 0;

        int tries = 0;
        while (bestRobo == null && tries < 50 && j.bids.size() > 0) {
          tries += 1;
          for (int k = j.bids.size() - 1; k >= 0; k -= 1) {
            Robo r = j.bids.get(k);
            float fitness = r.fitness;
            fitness += 2 + (1 / PVector.dist(r.pos, j.pickup.pos));
            fitness = pow(fitness, 4);
            if (r.job != null) {
              j.bids.remove(k);
            } else {
              if (fitness > fittest && fitness >= j.minimum_fitness) {
                bestRobo = r;
                fittest = fitness;
              }
            }
          }
        }
        if (bestRobo != null) {
          bestRobo.setJob(j);
          jobs.remove(i);
          i -= 1;
        } else {
          j.attempts += 1;
          j.minimum_fitness -= 1;
          j.minimum_bids -= 1;
          if (j.minimum_bids < JOB_MINIMUM_BIDS) {
            j.minimum_bids = JOB_MINIMUM_BIDS;
          }
        }
      }
    }
  }

  void addBid(Robo robo) {
    for (Job job : jobs) {
      if (job.bids.size() < job.minimum_bids) {
        job.addBid(robo);
      }
    }
  }

  Job[] toArray() {
    Object[] objects = jobs.toArray();
    Job[] ja = new Job[objects.length];
    for (int i = 0; i < objects.length; i += 1) {
      if (objects[i] instanceof Job) {
        ja[i] = (Job)objects[i];
      }
    }

    return ja;
  }
}

int JOB_ID = 0;
class Job implements Comparable {
  int id;
  int minimum_bids = floor(random(JOB_MINIMUM_BIDS, 10));
  float minimum_fitness = random(1, 100);
  int attempts = 0;
  ArrayList<Robo> bids = new ArrayList<Robo>();
  {
    JOB_ID += 1;
    id = JOB_ID;
  }

  void addBid(Robo bid) {
    if (!bids.contains(bid)) {
      bids.add(bid);
    }
  }

  String toString() {
    return "::" + pickup.id + " ==> " + dropoff.id + " bids:" + bids.size() + " min_bids:" + minimum_bids + " min_fit:" + minimum_fitness;
  }

  Pickup pickup = null;
  DropOff dropoff = null;

  Job(Pickup pickup, DropOff dropoff) {
    this.pickup = pickup;
    this.dropoff = dropoff;
  }



  int compareTo(Object o ) {
    if (!(o instanceof Job)) return 0;
    Job j = (Job) o;
    if (j.id > id) {
      return -1;
    } else {
      return 1;
    }
  }
}