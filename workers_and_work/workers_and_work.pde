ArrayList<Resource> resources = new ArrayList<Resource>();
ArrayList<Worker> workers = new ArrayList<Worker>();
ArrayList<Job> jobs = new ArrayList<Job>();
Machine chest;


void setup() {
  size(400, 400);
  chest = new Machine("Chest");
  workers.add(new Worker());
  float cx = width / 2;
  float cy = height / 2;
  for (int i = 0; i < 10; i += 1 ){
    float r = random(width / 8, (width / 2) - (width/8));
    float a = (TWO_PI / 10) * i;
    int x = floor(cx + r * cos(a));
    int y = floor(cy + r * sin(a));
    resources.add(new Resource(x,y, ""+i));
      
  }
  
  for (int i = 0; i < 5; i += 1) {
    Job j = new Job(JobType.CARRY);
    j.resource = resources.get(floor(random(resources.size())));
    j.machine = chest;
    jobs.add(j);
    
  }
  
  rectMode(CENTER);
}

void draw() {
  
  background(0);
  
  for (Worker w : workers) {
    w.update();
    w.draw();
  }

  for (Resource r : resources) {
    r.update();
    r.draw();
  }
  
  for (Job j : jobs) {
    j.update();
    j.draw();
  }
  
  chest.update();
  chest.draw();
}
