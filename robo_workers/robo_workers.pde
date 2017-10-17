PImage level;

final int JOB_LIMIT = 30;
final float ACTION_POINT_SIZE = 10;
int ACTION_POINT_ID = 0;
ArrayList<Robo> robos = new ArrayList<Robo>();
ArrayList<Pickup> pickups;
ArrayList<DropOff> dropoffs;
PVector centre;
Jobs jobs = new Jobs();
final int NUM_ROBOS = 10;
RoboComparator roboComp = new RoboComparator();
RoboComparatorDesc roboCompDesc = new RoboComparatorDesc(); 
RoboComparatorRandom roboCompRand = new RoboComparatorRandom();
int res = 10;
Grid grid;
void settings() {
  level = loadImage("lvl1.png");
  size(level.width * res, level.height * res);
  grid = new Grid(level.width, level.height);
  pickups = grid.pickups;
  dropoffs = grid.dropoffs;
}
void setup() {
  //size(800, 800);
  
  colorMode(HSB);
  centre = new PVector(width / 2, height / 2);
  for (int i = 0; i < NUM_ROBOS; i += 1) {
    Cell cell = grid.getRandomNotWall();
    robos.add(new Robo(cell.cpos.x, cell.cpos.y));
    //robos.get(i).applyForce(PVector.random2D());
  }
  background(255);
  //int howMany = floor(height / ACTION_POINT_SIZE);
  //for (int i = 0; i < howMany; i += 1) {
  //  color c = color((255.0 / howMany) * i, 255, 255);
  //  float x = random(width);
  //  float y = random(height);
  //  x = x - (x % ACTION_POINT_SIZE);
  //  y = y - (y % ACTION_POINT_SIZE);
  //  Pickup p = new Pickup(x, y, c);

  //  x = random(width);
  //  y = random(height);
  //  x = x - (x % ACTION_POINT_SIZE);
  //  y = y - (y % ACTION_POINT_SIZE);
  //  DropOff d = new DropOff(x, y, c);
  //  pickups.add(p);
  //  dropoffs.add(d);
  //}
  textFont(createFont("Consolas", 11));
}

void draw() {
  background(0);
  grid.draw();


  for (Pickup p : pickups) {
    p.update();
    p.draw();
  }

  for (DropOff d : dropoffs) {

    d.draw();
  }



  jobs.update();
  //fill(255);
  //text(jobs.size(), ACTION_POINT_SIZE + 10, 10);
  //float y = 0;
  //for (int i = 0; i < jobs.jobs.size(); i += 1) {
  //  y = 20 + (10 * i);
  //  text(jobs.jobs.get(i).toString(), ACTION_POINT_SIZE + 10, y);
  //}
  int j = 0;
  for (Robo robo : robos) {
    j += 1;
    //robo.seek(centre);
    robo.update();
    robo.draw();
    fill(255);
    //text(robo.toString(), 10, y + 10 + (j * 10));
  }
  
  robos.sort(roboCompDesc);


  //stroke(0);
  //noFill();
  //ellipse(centre.x, centre.y, 20,20);
}

//void mouseClicked() {
//  centre.set(mouseX, mouseY);
//}