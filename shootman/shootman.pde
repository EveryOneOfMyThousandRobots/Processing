ArrayList<Man> men = new ArrayList<Man>();
ArrayList<Wall> walls = new ArrayList<Wall>();
ArrayList<Target> targets = new ArrayList<Target>();
ArrayList<Target> originalTargets = new ArrayList<Target>();
PFont sysFont;
PImage lvl1;//
boolean refreshScreen = false;

float fr= 1000;

int numGenerations = 0;
int genAge = 0;
float highestFitness;
int framesWithoutHit = 0;
int framesWithoutHitLimit = 750;
int frameLimitBase = 1000;
float highestLastRound = 0;
String fittestLast = "";

void generation() {
  framesWithoutHit = 0;
  numGenerations += 1;
  highestLastRound = 0;
  genAge = 0;
  Man fittest = null;

  if (men.size() > 0) {
    for (Man m : men) {
      if (fittest == null) {
        fittest = m;
        if (fittest.fitness > highestFitness) {
          highestFitness = fittest.fitness;
        }
      }

      if (m.fitness > fittest.fitness) {
        fittest = m;
        if (fittest.fitness > highestFitness) {
          highestFitness = fittest.fitness;
        }
      }
    }
  }



  men.clear();
  if (fittest != null) {
    highestLastRound = fittest.fitness;
    fittestLast = "\nCountDown: " + fittest.shootCountDownLimit + "\n" + 
      "shoot dist: " + fittest.shootDist + "\n" + 
      "view Angle: " + fittest.viewAngle + "\n" + 
      "view Range: " + fittest.viewRange + "\n" +
      "genome: " + fittest.genome.toString();
    men.add(fittest.baby());
    men.add(fittest.baby());

    for (int i = 0; i < 8; i += 1) {
      if (highestLastRound < (highestFitness * 0.25) ) {
        men.add(new Man());
      } else {
        men.add(fittest.baby());
      }
    }
  } else {
    for (int i = 0; i < 10; i += 1) {
      men.add(new Man());
    }
  }
  targets.clear();
  for (Target t : originalTargets) {
    targets.add(t.copy());
  }
  //targets = (ArrayList<Target>)originalTargets.clone();
}
int tilesAcross = 20;
int tilesDown = 20;
int tileWidth, tileHeight;
void setup() {
  size(800, 800);
  tileWidth = width / tilesAcross;
  tileHeight = height / tilesDown;
  lvl1 = loadImage("lvl1.png");
  lvl1.loadPixels();

  for (int x = 0; x < lvl1.width; x += 1) {
    for (int y = 0; y < lvl1.height; y += 1) {
      int col = lvl1.pixels[x + y * lvl1.width];
      col = col & 0xffffff;
      float xx = (x + 1) * tileWidth ;
      float yy = (y + 1) * tileHeight;
      print(col + " ");
      if (col == 0xffffff) {

        originalTargets.add(new Target(xx + (tileWidth / 2), yy + (tileHeight / 2)));
      } else if (col == 0x0) {
        walls.add(new Wall(xx, yy, tileHeight, tileWidth));
      }
    }
  }

  //for (int i = 0; i < 30; i += 1) {
  //  float[] a = getTile(false);

  //  originalTargets.add(new Target(a[0] + (tileWidth / 2), a[1] + (tileHeight / 2)));
  //}
  generation();
  sysFont = createFont("Consolas", 10);
  textFont(sysFont);


  walls.add(new Wall(0, 0, tileHeight, height));
  walls.add(new Wall(0, 0, width, tileHeight));
  walls.add(new Wall(width - tileHeight, 0, tileHeight, height));
  walls.add(new Wall(0, height - tileHeight, width, tileHeight));

  //for (int i = 0; i < 40; i += 1) {
  //  float[] xt = getTile(true);
  //  walls.add(new Wall(xt[0], xt[1], tileWidth, tileHeight));
  //}
  frameRate(1000);
  background(0);
}



void draw() {
  refreshScreen = false;
  framesWithoutHit += 1;
  genAge += 1;
  if (numGenerations % 10 == 0 || numGenerations == 1) {
    refreshScreen = true;
  }
  if (genAge > frameLimitBase && framesWithoutHit >= framesWithoutHitLimit) {
    generation();
  }
  if (refreshScreen ) {
    background(0);
    stroke(64);
    for (int x = width / 20; x < width; x += width / 20) {
      line(x, 0, x, height);
    }
    for (int y = height / 20; y < height; y += height / 20) {
      line(0, y, width, y);
    }
  }

  for (Man m : men) {
    m.update();
    if (refreshScreen) {
      m.draw();
    }
  }

  for (int i = targets.size()-1; i >= 0; i -= 1) {
    Target t = targets.get(i);
    if (t.hit) {
      t.hit = false;
      targets.remove(i);
      framesWithoutHit = 0;
      //float[] a = getTile(false);
      // targets.add(new Target(a[0] + (tileWidth / 2), a[1] + (tileHeight / 2)));
    } else {
      if (refreshScreen) {
        t.draw();
      }
    }
  }
  if (refreshScreen ) {
    for (Wall w : walls) {

      w.draw();
    }
    fill(255);
    text("age: " + genAge + "\nGen: " + numGenerations + "\nhighest: " + highestFitness
      + "\nfps: " + fr + "\nfittest Last: " + highestLastRound + "\n" + fittestLast, 20, 20);
  }
}

void mouseWheel(MouseEvent e) {
  fr += -e.getCount();
  frameRate(fr);
}