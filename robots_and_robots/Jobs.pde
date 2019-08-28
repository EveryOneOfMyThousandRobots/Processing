Robot findClosest(PVector pos) {
  Robot returnBot = null;
  float dist = Float.MAX_VALUE;
  float cDist = 0;
  for (Robot robot : robots) {
    if (robot.tasks == null) {
      cDist = PVector.dist(robot.pos, pos);
      if (cDist < dist) {
        returnBot = robot;
        dist = cDist;
      }
    }
  }

  return returnBot;
}

void findJob() {
  if (jobTimer > FIND_JOBS_EVERY_MILLIS) {
    jobTimer = 0;
    //for (Robot robot : robots) {

    if (workspace.item != null ) {
      if (workspace.item.isComplete() && !workspace.assigned) {
        Robot closest = findClosest(workspace.pos);
        if (closest != null) {
          closest.tasks = new InstructionList(workspace, outgoing, workspace.item);
        }
        workspace.assigned = true;
      } else {

        for (Component cmp : workspace.item.requires.keySet()) {
          int numRequired = workspace.item.requires.get(cmp);
          if (numRequired > 0) {
            ComponentBin bin = findBin(cmp);
            if (bin != null) {
              Robot closest = findClosest(bin.pos);
              if (closest != null) {
                closest.tasks = new InstructionList(bin, workspace, cmp);
                workspace.item.requires.put(cmp, 0);
                break;
              }
            }
          }
        }
      }
    } else if (incoming.item != null && !incoming.assigned && !deliveringItemTo(workspace) && workspace.item == null) {
      Robot closest = findClosest(incoming.pos);
      if (closest != null) {
        closest.tasks = new InstructionList(incoming, workspace, incoming.item);
        incoming.assigned = true;
      }
    }

    //}
  }
}
