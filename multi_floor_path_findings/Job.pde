class Job {
  String action;
  
  Tile tile;
  
  Job(String action, Tile tile) {
    this.action = action;
    this.tile = tile;
  }
  
}


Queue<Job> jobs = new LinkedList<Job>();


boolean addJob(String action, Tile destination) {
  
  if (destination == null) {
    return false;
  }
  
  if (destination.hasJob) {
    return false;
  }
  
  
  jobs.add(new Job(action,destination));
  return true;
  
}
