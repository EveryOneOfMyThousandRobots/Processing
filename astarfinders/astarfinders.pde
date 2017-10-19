PImage level;
ArrayList<Finder> finders = new ArrayList<Finder>();
int res = 10;
int debug = 0;
long millisLast = 0;
long millisTotal = 0;
float seconds = 0;
final int NUM_FINDERS = 25;
Grid grid;
void settings() {
  level = loadImage("lvl4.png");
  size(level.width * res, (level.height * res) + 100);
  grid = new Grid();
}

void setup() {
  for (int i = 0; i < NUM_FINDERS; i += 1) {
    Finder finder = new Finder(grid.getRandomBlank());
    finders.add(finder);
  }
  textFont(createFont("Consolas", 8));
}

void setOccupied() {
  for (Finder f : finders) {
    grid.getCellAtPos(f.pos).setOccupied();
  }
}

void clearOccupied() {
  for (Cell[] cells : grid.cells) {
    for (Cell cell : cells) {
      cell.clearOccupied();
    }
    
  }
}

void draw() {

  //if (frameCount % 25 == 0 ) {
    clearOccupied();
  //}
  //long time = millis();
  millisTotal = millis();
  seconds = millisTotal / 1000.0;
  //millisLast = time;
  background(0);
  for (Finder f : finders) {
    f.update();
    grid.getCellAtPos(f.pos).setOccupied();
  }
  grid.draw();
  int totalFrames = 0, totalTickets = 0, totallines = 0;
  int y = (level.height * res) + 10;
  int x = width / 2;
  int i = 0;
  for (Finder f : finders) {
    //f.update();
    //grid.getCellAtPos(f.pos).setOccupied();
    if (debug > 0 && i == 0) {
      f.draw(debug);
    } else {
      f.draw(0);
    }
    totalFrames += f.framesTaken;
    totalTickets += f.ticketsCompleted;
    totallines += f.itemsPicked;

    text(f.toString(), x, y);
    y += 10;
    if (y > height - 10) {
      y = (level.height * res) + 10;
      x = width / 2 + (width / 4);
    }
    i += 1;
  }
  fill(255);
  String output = "frames: " + totalFrames;
  output += "\ntickets: " + totalTickets;
  output += "\nLines:" + totallines;
  if (totalFrames > 0) {
    output += "\nlines /s: "  + (0.0 + float(totallines) / seconds);
    output += "\ntickets /s: "  + (0.0 + float(totalTickets) / seconds);
  }
  text(output, 10, (level.height * res) + 10);



  //text(frameCount + " " + finder.openSet.size(), 10, 10);
}

void keyPressed() {
  if (key == 'd') {
    debug = (debug + 1) % 4;
  }
}