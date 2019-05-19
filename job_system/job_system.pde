final float RESOURCE_SIZE = 16;
final float ROBOT_SIZE = 8;
final int NUM_ROBOTS = 5;
final int MAP_WIDTH_IN_TILES = 64;
final int MAP_HEIGHT_IN_TILES = 36;
boolean DRAW_PATHS = false;
boolean DRAW_JOB_LIST = false;
PGraphics GAME_WINDOW, GUI;

final int GUI_WIDTH = floor(RESOURCE_SIZE * 8);
final int GUI_HEIGHT = floor(RESOURCE_SIZE * 36); 
final int GAME_WIDTH = floor(RESOURCE_SIZE * MAP_WIDTH_IN_TILES);
final int GAME_HEIGHT =  floor(RESOURCE_SIZE * MAP_HEIGHT_IN_TILES);

void settings() {
  size(GUI_WIDTH + GAME_WIDTH, GUI_HEIGHT);
}


void setup() {
  GAME_WINDOW = createGraphics(GAME_WIDTH, GAME_HEIGHT);
  GUI = createGraphics(GUI_WIDTH, GUI_HEIGHT);
  //size(800, 600);
  loadExternalFiles();
  map = new Map("map001.png");
  buildNodes();
  map.generate();
  gman.addButton("create robot",2,20);

  println(Integer.toString(color(255), 16));
  //println(resourceTypeManager.toString());
  //for (String s : resourceTypes.keySet()) {
  //  println(s + " : " + resourceTypes.get(s).toString());
  //}
  jobs = new JobManager();

  for (int x = 0; x < nodes.length; x += 1) {
    float xx = x * RESOURCE_SIZE;

    for (int y = 0; y < nodes[x].length; y += 1) {
      float yy = y * RESOURCE_SIZE;
      Node n = getNode(x, y);
      if (n != null ) {
        if (n.wall) {
          map.walls.add(n);
        } else if (n.chest) {
          structures.structures.add(new Structure(xx, yy, structures.getStructureTypeById("structure::chest")));
        } else if (n.exclusionZone) {
        } else if (n.robot_start) {
          robots.add(new Robot(xx, yy));
        } else if (random(1) < 0.05) {
          Resource r = new Resource(resources.getRandomTypeId(), xx, yy);
          resources.resources.add(r);
        }
      }
    }
  }


  setNeighbours();
  //setCosts();
  //path = new Path(A,B);
}

void draw() {
  background(51);
  jobs.assignJobs();
  jobs.update();
  GUI.beginDraw();
  gman.draw();
  GUI.endDraw();
  GAME_WINDOW.beginDraw();
  GAME_WINDOW.background(100);
  map.drawWalls();
  //for (Tree t : trees) {
  //  t.draw();
  //}
  resources.draw();

  structures.draw();

  for (Robot r : robots) {
    r.update();
    r.draw();
  }
  GAME_WINDOW.endDraw();

  image(GAME_WINDOW, GUI_WIDTH, 0);
  image(GUI,0,0);
  fill(255);
  if (DRAW_JOB_LIST) {
    float x = 10;
    float y = 10;
    for (String  s : jobs.jobs.keySet()) {
      text(jobs.jobs.get(s).toString(), x, y);
      y += 11;
      if (y > height) break;
    }
  }

  if (dragStart) {
    dragMin.set(min(dragStartX, dragNowX), min(dragStartY, dragNowY)); 
    dragMax.set(max(dragStartX, dragNowX), max(dragStartY, dragNowY)); 



    dragDims.set(dragMax.x - dragMin.x, dragMax.y - dragMin.y);
    noFill();
    stroke(255);
    rect(dragMin.x, dragMin.y, dragDims.x, dragDims.y);
  }

  //path.draw();

  //for (int nx = 0; nx < nodes.length; nx += 1) {
  //  for (int ny = 0; ny < nodes[nx].length; ny += 1) {
  //    Node n = nodes[nx][ny];

  //    n.draw();
  //  }
  //}
}

CreateJob createJob = null;

boolean dragStart = false;
int dragStartX, dragStartY;
int dragNowX, dragNowY;
PVector dragMin = new PVector();
PVector dragMax = new PVector();
PVector dragDims = new PVector();
int mouseXG = 0;
void mouseDragged() {
  mouseXG = mouseX + GUI_WIDTH;
  if (mouseButton == LEFT) {
    if (!dragStart) {
      dragStart = true;
      dragStartX = mouseX;
      dragStartY = mouseY;
    }

    dragNowX = mouseX;
    dragNowY = mouseY;
  }
}

ArrayList<Resource> selected = new ArrayList<Resource>();
void mouseReleased() {
  mouseXG = mouseX + GUI_WIDTH;
  if (dragStart) {
    dragStart = false;
    resources.removeHighlight();
    resources.getResourcesInside(selected, dragMin, dragMax);
    println(selected.size());
    for (Resource r : selected) {
      r.drawMe.highlighted = true;
    }
    createJob = new CreateJob(selected);
  }
}
void mouseClicked() {
  mouseXG = mouseX + GUI_WIDTH;
  if (mouseButton == LEFT) {
    if (createJob == null) {
      Resource r = resources.clicked(mouseX-GUI_WIDTH, mouseY);
      if (r != null) {
        selected.clear();
        selected.add(r);
        createJob = new CreateJob(selected);
        r.drawMe.highlighted = true;
      }
    } else {
      //check for chest clicked
      for (Structure s : structures.structures) {
        if (s.click.inside(mouseX-GUI_WIDTH, mouseY)) {
          createJob.structure = s;
          for (Resource r : createJob.resources) {
            jobs.addJob(r, createJob.structure);
            r.drawMe.highlighted = false;
          }
          createJob = null;
          break;
        }
      }
    }
  } else if (mouseButton == RIGHT) {
    selected.clear();
    resources.removeHighlight();
  }
}

void keyPressed() {
  if (key == 'd') {
    DRAW_PATHS = !DRAW_PATHS;
  }

  if (key == 'j') {
    DRAW_JOB_LIST = !DRAW_JOB_LIST;
  }
}
