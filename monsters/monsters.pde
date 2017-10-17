ArrayList<HashMap<String, DataPoint>> graph = new ArrayList<HashMap<String, DataPoint>>();

HashMap<String, DataPoint> families = new HashMap<String, DataPoint>();
PVector worldPos, worldDims;
PVector boundaryTopLeft, boundaryBottomRight;

class DataPoint {
  int count, health;
  float average;
  
  color col;
}








int C_ID = 0;



void log(String s) {
  println(s);
}


ArrayList<C> cs = new ArrayList<C>();
ArrayList<Food> food = new ArrayList<Food>();
void setup() {
  size(600, 600);

  worldPos = new PVector(0, 0);
  worldDims = new PVector(width, height / 2);
  boundaryTopLeft = new PVector(worldPos.x, worldPos.y);
  boundaryBottomRight = new PVector(worldPos.x + worldDims.x, worldPos.y + worldDims.y);
  for (int i = 0; i< 10; i += 1) {
    float x = random(worldPos.x + 20, worldPos.x + worldDims.x - 20);
    float y = random(worldPos.y + 20, worldPos.y + worldDims.y - 20);
    cs.add(new C(x, y));
  }

  for (int i = 0; i< 50; i += 1) {
    food.add(new Food());
  }

  frameRate(5000);

  int x = (int)boxmuller(0, 100);
  int i = 0;
  while (x > 20) {
    i += 1;
    x = (int)boxmuller(0, 100);
  }
  println(i + "iterations : " + x);
}

void draw() {
  int virusSig = -1;
  if (random(0, 100) <= 25) {
    virusSig = (int)random(0, 1000);
    //log("virus (" + virusSig + ") appeared");
  }
  boolean refreshFamilies = false;
  if (frameCount % 200 == 0 || frameCount < 2) {
    refreshFamilies = true;
    families.clear();
  }
  background(0);
  loadPixels();
  for (int i = cs.size() -1; i >= 0; i -= 1) {
    C c = cs.get(i);
    if (c.dead) { 
      cs.remove(i);
      continue;
    }
    if (virusSig >= 0 && virusSig == c.virusSig) {
      if (random(0, c.health + (c.survived * 10)) <= 25 ) {
        c.dead =true;
        log(c.getName() + " died from virus (" + virusSig + ")");
      } else {
        // log(c.getName() + " survived virus (" + virusSig + ")");
        c.survived += 1;
      }
    }
    if (!c.dead) {
      c.update();
      c.draw();


      if (refreshFamilies) {
        if (families.get(c.lastName) != null) {
          DataPoint ii = families.get(c.lastName);
          ii.health += c.health;
          ii.count += 1;

          families.put(c.lastName, ii);
        } else {
          DataPoint p = new DataPoint();
          p.count = 1;
          p.health = floor(c.health);
          p.col = c.col;
          families.put(c.lastName, p);
        }
      }
    }
  }
  if (refreshFamilies) {
    for (DataPoint d : families.values()) {
      d.average = d.health / d.count;
    }
    graph.add( (HashMap<String, DataPoint>)families.clone());
    if (graph.size()>width/2) {
      graph.remove(0);
    }
  }

  for (Food f : food) {
    f.draw();
  }
  updatePixels();

  if (cs.size() < 4) {
    for (int i = 0; i < 4; i += 1) {
      float x = random(worldPos.x + 20, worldPos.x + worldDims.x - 20);
      float y = random(worldPos.y + 20, worldPos.y + worldDims.y - 20);
      // cs.add(new C(x,y));
      C c = new C(x, y);
      cs.add(c);
      log(c.getName() + " appeared from nowhere");
    }
  }
  float y = 10;
  fill(255);
  for (String K : families.keySet()) {
    DataPoint ii = families.get(K);
    text(K + ": " + floor(ii.average) + " (" + ii.count + ")", 10, y);
    y += 11;
  }

  int highest = 0;
  
  for (HashMap<String, DataPoint> map : graph) {

    
    for (DataPoint V : map.values()) {
      if (floor(V.average) > highest) {
        highest = floor(V.average);
      }
      
        
    }
  }
  HashMap<String, PVector> pointsA = new HashMap<String, PVector>();
  HashMap<String, PVector> pointsB = new HashMap<String, PVector>();
  float gx = 0;
  float gy = 0;
  for (HashMap<String, DataPoint> map : graph) {
    
    gx += 1;
    float ggx = map(gx, 0, graph.size(), 0, width);
    for (String K : map.keySet()) {
      
      DataPoint V = map.get(K);
      gy = map(V.average, 0, highest, height, height / 2);
      stroke(V.col);
      float fromx=ggx-1, fromy=height;
      PVector p = pointsB.get(K);
      if (p != null) {
        fromx = p.x;
        fromy = p.y;
      }
      line(fromx, fromy, ggx, gy);
      pointsA.put(K, new PVector(ggx, gy));
    }
    pointsB = (HashMap<String,PVector>)pointsA.clone();
    pointsA.clear();
  }
}

float angle(PVector v1, PVector v2) {
  float a = atan2(v2.y, v2.x) - atan2(v1.y, v1.x);
  if (a < 0) a += TWO_PI;
  return a;
}