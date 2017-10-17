final int NUM_POINTS = 8;
float shortestDist = 0;
PVector[] points;
//PVector[] originals;
PVector[] best = null;
float total_iterations = 0;
float current_iteration = 0;

int[] order; // = {0,1,2,3,4,5,6,7,8,9};

float fct(float n) {
  if (floor(n) == 1) {
    return 1;
  } else {
    return floor(n) * fct(floor(n)-1);
  }
}

PVector[] copyVectors( PVector[] pa) {
  PVector[] copy = new PVector[pa.length];

  for (int i = 0; i < pa.length; i += 1) {
    copy[i] = pa[i].copy();
  }

  return copy;
}

PVector[] copyOrder(PVector[] pa, int[] ord) {
  PVector[] copy = new PVector[pa.length];
  
  for (int i = 0; i < ord.length; i += 1) {
    copy[i] = pa[ord[i]].copy();
  }
  
  return copy;
}

void setup() {
  size(600, 400, P2D);
  points = new PVector[NUM_POINTS];
  order = new int[NUM_POINTS];
  for (int i = 0; i < points.length; i += 1) {
    points[i] = new PVector(random(width), random(height));
    order[i] = i;
  }
//  originals = copyVectors(points);

  total_iterations = fct(NUM_POINTS);
  
  shortestDist = getDist(points);
  best = copyVectors(points);
  frameRate(1000);
}

void swap(int[] pa, int i, int j) {
  if (i >= 0 && i < pa.length && j >= 0 && j < pa.length && i != j) {
    int temp = pa[i];
    pa[i] = pa[j];
    pa[j] = temp;
  }
}

void swap(PVector[] pa, int i, int j) {
  if (i >= 0 && i < pa.length && j >= 0 && j < pa.length && i != j) {
    PVector temp = pa[i];
    pa[i] = pa[j];
    pa[j] = temp;
  }
}

//void draw() {
  //background(0);
  //String output = "";
  
void nextOrder() {
  //for (int i = 0 ; i < vals.length; i += 1) {
  //  output += " " + vals[i];  
  //}
  //text(frameCount + ": " + output, 20, height / 2);
 // println(frameCount + ": " + output);
  int largestI = -1;
  for (int i = 0; i < order.length-1; i += 1) {
    if (order[i] < order[i+1]) {
      largestI = i;
    }
  }
  
  if (largestI == -1) {
    println("finished in " + frameCount + " steps");
    noLoop();
  } else {
    int largestJ = -1;
    for (int j = 0; j < order.length; j += 1) {
      if (order[largestI] < order[j]) {
        largestJ = j;
      }
    }
    swap(order, largestI, largestJ);
    
    int[] newVals = new int[order.length - largestI - 1];
 
    int j = 0;
    for (int i = largestI + 1; i < order.length; i += 1) {
      newVals[j] = order[i];
      j += 1;
    }
    
    int[] reverse = new int[newVals.length];
    j = 0;
    for (int i = newVals.length-1; i >= 0; i -=1) {
      reverse[j] = newVals[i];
      j += 1;
    }
    j = 0;
    for (int i = largestI + 1; i < order.length; i += 1) {
      order[i] = reverse[j];
      j += 1;
    }
    
  }
}

//PVector[] getNext(PVector[] p) {
//}

void draw() {
  background(0);
  fill(255);
  noStroke();
  for (PVector p : points) {
    ellipse(p.x, p.y, 10, 10);
  }
  current_iteration += 1;
  float percentDone = (current_iteration / total_iterations) * 100;

  //draw current path
  noFill();
  stroke(255);
  strokeWeight(2);
  beginShape();
  for (int i = 0; i < order.length; i += 1) {
    int n = order[i];
    PVector p = points[n];
    vertex(p.x, p.y);
  }
  endShape();
  //draw best path
  noFill();
  stroke(255, 100,60);
  strokeWeight(4);
  beginShape();
  for (PVector p : best) {
    vertex(p.x, p.y);
  }
  endShape();
  //other
  //int i = floor(random(points.length));
  //int j = floor(random(points.length));
  //swap(points, i, j);
  float dist = getDist(points);
  if (dist < shortestDist) {
    shortestDist = dist;
    best = copyOrder(points, order);
  }
  text(shortestDist, 10, 10);
  text("Done " + nf(percentDone, 3,3) + "%", 10, 20);
  text("FPS: " + nf(frameRate, 3,3), 10, 30);
  
  nextOrder();
 // points = copyOrder(originals,order);
}


float getDist(PVector[] pa) {
  float totalDist = 0;

  for (int i = 0; i < order.length-1; i += 1 ) {
    int n1 = order[i];
    int n2 = order[i + 1];
    PVector a = pa[n1];
    PVector b = pa[n2];

    totalDist += PVector.dist(a, b);
  }


  return totalDist;
}