ArrayList<ArrayList<PVector>> points = new ArrayList<ArrayList<PVector>>();
void setup() {
  size(400, 400);
  noLoop();

  makeStrip(1);
  makeStrip(height / 4);
  makeStrip(height / 2);
  makeStrip(floor(height * 0.75));
  makeStrip(height-1);
}

void makeStrip(int y) {
  float topEdgePoints = 11;
  
  float edgeDist = width / topEdgePoints;
  ArrayList<PVector> top = new ArrayList<PVector>();
  top.add(new PVector(0, y));
  for (float x = random(edgeDist / 2, edgeDist); x < width; x += random(edgeDist/2, edgeDist)) {
    //for (float x = edgeDist; x < width - edgeDist; x += edgeDist) {
    top.add(new PVector(x, y));
  }
  top.add(new PVector(width, y));
  points.add(top);
}

void ptex(PVector p) {
  vertex(p.x, p.y);
}

void draw() {
  background(0);
  stroke(255);
  noFill();
  
  for (int i = 0; i < points.size(); i += 1) {
    
    beginShape();
    ArrayList<PVector> row = points.get(i);
    ArrayList<PVector> rowBelow = null;
    ArrayList<PVector> rowAbove = null;
    if (i > 0) {
      rowAbove = points.get(i-1);
    }
    if (i < points.size()-1) {
      rowBelow = points.get(i+1);
    }
    for (int j = 0; j < row.size(); j += 1) {
      
      PVector me = row.get(j);
      PVector right = null;
      PVector rightAbove = null;
      PVector below = null;
      if (j < row.size() - 1) {
        right = row.get(j+1);
      }

      if (rowAbove != null) {
        if (j < rowAbove.size()-1) {

          rightAbove = rowAbove.get(j+1);
        }
      }
      if (rowBelow != null) {
       

          below = rowBelow.get(j);
        
      }

      if (right != null) {
        if (rightAbove != null) {
          ptex(me);
          ptex(right);
          ptex(rightAbove);
          //ptex(me);
        }

        if (below != null) {
          ptex(me);
          ptex(right);
          ptex(below);
          //ptex(me);
        }
      }
    }
    endShape();
  }


  
}