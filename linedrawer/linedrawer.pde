class Thing {
  PVector A, B;
  
  Thing(float x1, float y1, float x2, float y2) {
    A = new PVector(x1,y1);
    B = new PVector(x2,y2);
  }
  
  
  void draw() {
    
    stroke(255);
    noFill();
    
    ellipse(A.x, A.y, 4, 4);
    ellipse(B.x, B.y, 4, 4);
    //line(A.x, A.y, B.x, B.y);
    float lowestY = max(A.y, B.y);
    float leftX = min(A.x, B.x);
    float rightX = max(A.x, B.x);
    
    float xx = leftX + ((rightX - leftX) / 2);
    float yy = lowestY + 50;
    ellipse(xx,yy, 5, 5);
    
    beginShape();
    curveVertex(A.x, A.y);
    curveVertex(A.x, A.y);
    curveVertex(xx, yy);
    curveVertex(B.x, B.y);
    curveVertex(B.x, B.y);
    
    
    endShape();
  }
}
Thing thing;
void setup() {
  size(500,500);
  thing = new Thing(random(width / 2), random(height), (width / 2) + random(width / 2), random(height));
}

void draw() {
  background(0);
  thing.draw();
  stop();
}
