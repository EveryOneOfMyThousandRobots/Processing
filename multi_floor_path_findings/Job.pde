class Job {
  String action;

  Tile tile;

  Job(String action, Tile tile) {
    this.action = action;
    this.tile = tile;
  }
}



class JobQueue {
  private Queue<Job> jobs = new LinkedList<Job>();
  ArrayList<Job> handedOut = new ArrayList<Job>();
  
  boolean isJobAvailable() {
    return jobs.size() > 0;
  }
  
  Job getNextJob() {
    if (jobs.size() > 0){
      Job job = jobs.poll();
      if (job != null) {
        handedOut.add(job);
        
      }
      return job;
    } else {
      return null;
    }
     
  }
}

JobQueue jobs = new JobQueue();

boolean addJob(String action, Tile destination) {

  if (destination == null) {
    return false;
  }

  if (destination.hasJob) {
    return false;
  }


  //jobs.add(new Job(action, destination));
  return true;
}
