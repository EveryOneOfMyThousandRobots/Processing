HashMap<Integer, Integer> cameFrom = new HashMap<Integer, Integer>();
HashMap<Integer, Integer> goesTo = new HashMap<Integer, Integer>();
HashMap<Integer, PVector> positions = new HashMap<Integer, PVector>();
HashMap<Integer, Float> angles = new HashMap<Integer, Float>();
float RAD = 10;
void setup() {
  size(800, 800);
  RAD = width / 100;
  positions.put(1, new PVector(10, height-10));
  goesTo.put(1, 1);
  
  for (int i = 2; i < 2000; i += 1) {
    positions.put(i, new PVector(random(width), random(height)));
  }
}

int nextX = 2;
void draw() {
  background(51);
  if (nextX < 2000) {
    int x = nextX;//floor(random(1, 1000));
    nextX += 1;

    while (true) {
      if (x == 1) {
        break;
      }
      if (!goesTo.containsKey(x)) {
        int hX = x;
        int nX = f(x);
        goesTo.put(hX, nX);
        x = nX;
        cameFrom.put(nX, hX);
        
        if (!positions.containsKey(nX)) {
          positions.put(nX, new PVector(random(width), random(height)));
        }
        
        if (!positions.containsKey(hX)) {
          positions.put(hX, new PVector(random(width), random(height)));
        }

      } else {
        break;
      }
    }
  }

  for (int i : positions.keySet()) {
    if (i == 1) continue;

    PVector p0 = positions.get(i);

    if (goesTo.containsKey(i)) {
      PVector p1 = positions.get(goesTo.get(i));
      

      if (PVector.dist(p0, p1) > RAD) {

        float f = 0;
        if (!angles.containsKey(i)) {
          f = random(-HALF_PI - QUARTER_PI, QUARTER_PI);
          angles.put(i, f);
        } else {
          f = angles.get(i);
        }


        p0.x = lerp(p0.x, p1.x + RAD * cos(f), 0.05);
        p0.y = lerp(p0.y, p1.y + RAD * sin(f), 0.05);
      }
    }
  }  


  stroke(255);
  fill(255);  
  for (int i : positions.keySet()) {
    PVector p0 = positions.get(i);
    ellipse(p0.x, p0.y, 2,2);
    if (goesTo.containsKey(i)) {
      PVector p1 = positions.get(goesTo.get(i));

      line(p0.x, p0.y, p1.x, p1.y);
    }
  }
}



int f(int x) {
  if (x % 2 == 0) {
    return x / 2;
  } else {
    return (x * 3)+1;
  }
}
