import java.util.HashSet; //<>//
import java.util.LinkedHashMap;
class JobManager {
  private LinkedHashMap<String, Job> jobs = new LinkedHashMap<String, Job>();
  private ArrayList<Robot> unnassigned = new ArrayList<Robot>();
  void update() {
    //for (Tree tree : trees) {
    //  for (Chest chest : chests) {
    //    addJob(tree,chest);
    //  }
    //}
  }

  void assignJobs() {
    unnassigned.clear();
    for (Robot r : robots) {
      if (r.job == null && r.state == STATE.IDLE && r.remainingPower >= 100) {
        unnassigned.add(r);
      }
    }
    if (unnassigned.size() > 0 ) {
      Collections.sort(unnassigned, rc);

      for (String k : jobs.keySet()) {
        Job j = jobs.get(k);
        if (!j.failed && j.assigned == null) {
          float shortestdist = 0;
          float dist = 0;
          Robot closest = null;
          for (Robot r : unnassigned) {
            dist = quickDist(r.pos, j.resource.pos);
            if (closest == null || dist < shortestdist) {
              closest = r;
              shortestdist = dist;
            } 
          }
          if (closest != null) {
            unnassigned.remove(closest);
            closest.job = j;
            j.assigned = closest;
          }
        }
      }
    }
  }

  boolean addJob(Resource resource, Structure structure) {

    String k = getJobKey(resource, structure);
    if (!jobs.containsKey(k)) {
      jobs.put(k, new Job(resource, structure));
      return true;
    }

    return false;
  }

  void failed(Job j) {
    if (jobs.containsKey(j.k)) {
      jobs.remove(j.k);
      j.assigned = null;
      j.failed = true;
      jobs.put(j.k, j);
    }
  }

  void complete(Job j) {

    if (jobs.containsKey(j.k)) {
      jobs.remove(j.k);
      j.assigned = null;

      jobs.put(j.k, j);
    }
  }

  //Job apply(Robot r) {
  //  Job returnjob = null;
  //  for (String s : jobs.keySet()) {
  //    Job j = jobs.get(s);
  //    if (!j.failed && j.assigned == null) {
  //      returnjob = j;
  //      j.assigned = r;
  //      break;
  //    }
  //  }


  //  return returnjob;
  //}
}
String getJobKey(Resource r, Structure s) {
  return r.id+"_"+s.id;
}
class Job {
  final String k;
  final Resource resource;
  final Structure structure;
  Robot assigned = null;
  boolean failed = false;
  final String name;

  Job(Resource res, Structure structure) {
    this.resource = res;
    this.structure = structure;
    this.k = getJobKey(res, structure);
    name = res.type.name + " to chest";
  }

  int hashCode() {
    return k.hashCode();
  }

  boolean equals(Job o) {
    return (o.hashCode() == hashCode());
  }

  String toString() {
    String r = "";
    if (assigned == null) {
      r = "assigned: false";
    } else {
      r = "assigned: true " + assigned.state;
    }

    if (failed) {
      r += ", failed";
    }
    return "job (" + k + "), " + r;
  }
}

class CreateJob {
  ArrayList<Resource> resources;
  Structure structure;

  CreateJob(ArrayList<Resource> resources) {
    this.resources = resources;
  }

  void addChest(Structure structure) {
    this.structure = structure;
  }
}
