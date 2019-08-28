enum JobType {
  CARRY;
}

class Job {
  JobType type;
  Resource resource = null;
  Machine machine = null;
  ArrayList<Worker> assigned = new ArrayList<Worker>();
  Job(JobType type) {
    this.type = type;
  }
  
  

  


  void update() {
  }
  
  void draw() {
    if (resource != null && machine != null) {
      stroke(255,0,0);
      line(resource.x, resource.y, machine.x, machine.y);
    }
  }
}
