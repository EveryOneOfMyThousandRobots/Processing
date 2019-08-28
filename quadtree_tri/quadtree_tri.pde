QuadTree quad;
ArrayList<PVector> points = new ArrayList<PVector>(); 
ArrayList<Polygon> polys = new ArrayList<Polygon>();
//PVector mousePos;
void setup() {
  size(500,500);
  quad = new QuadTree(0,0,width,height);
  //mousePos= new PVector(0,0);
  for (int i = 0; i < 600; i += 1) {
    PVector p = new PVector(random(width), random(height));
    quad.addPoint(p);
    points.add(p);
  }
}

void draw() {
  background(0);
  quad.draw();
  //mousePos.set(mouseX, mouseY);
  stroke(255);
  fill(128);
  for (Polygon p : polys) {
    beginShape();
    for (int n = 0; n < p.npoints; n += 1){
      vertex(p.xpoints[n], p.ypoints[n]);
    }
    endShape(CLOSE);
  }
  
  
  fill(255);
  ArrayList<PVector> points = getPoints(mouseX, mouseY, 100, 100);
  text(points.size(), 10, 10);
  
  stroke(255, 0, 0);
  noFill();
  rect(mouseX, mouseY, 100,100);
  makeNew();
}
