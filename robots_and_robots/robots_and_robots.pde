PFont sysFont;
//Robot robot;
long delta = 0;
long deltaTimeLast = 0;
long deltaTimeNow = 0;
long jobTimer = 0;
void setup() {
  sysFont = createFont("Consolas", 10);
  textFont(sysFont);
  size(800, 800);
  initComponents();
  //initItems();
  initTables();
  //printItems();
  int x = width / 4;
  int y = height / 4;
  for (int i = 0; i < NUM_ROBOTS/2; i += 1) {

    Robot robot = new Robot(x, y, color(255, 0, 255));
    y += 50;
    robots.add(robot);
  }
  y = height / 4;
  x = floor(width * 0.75);
  for (int i = 0; i < NUM_ROBOTS/2; i += 1) {

    Robot robot = new Robot(x, y, color(255, 0, 255));
    y += 50;
    robots.add(robot);
  }
}


void draw() {
  deltaTimeNow = millis();
  delta = deltaTimeNow - deltaTimeLast;
  deltaTimeLast = deltaTimeNow;
  
  jobTimer += delta;
  
  background(255);
  for (Tbl tbl : tables) {
    tbl.draw();
  }

  for (Robot robot : robots) {
    robot.checkTask();
    robot.update();
    robot.draw();
  }

  incoming.update();
  outgoing.update();
  
  findJob();
  fill(0);
  text(str(deliveringItemTo(workspace)), width/4,50);
}
