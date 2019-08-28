//ArrayList<Wall> walls = new ArrayList<Wall>();

final int AREA_WIDTH = 400;
final int TOTAL_WIDTH = 800;
final int AREA_HEIGHT = 400;
ArrayList<Polygon> polys = new ArrayList<Polygon>();
//Ray ray;
Particle p;
PVector pMouse;
PGraphics edges;
PGraphics topDown;
PGraphics render;

void settings() {
  size(TOTAL_WIDTH, AREA_HEIGHT);
}
void setup() {


  //size(400, 400);
  //colorMode(HSB);
  pMouse = new PVector();
  p = new Particle();
  edges = createGraphics(AREA_WIDTH,AREA_HEIGHT);
  topDown = createGraphics(AREA_WIDTH,AREA_HEIGHT);
  render = createGraphics(AREA_WIDTH,AREA_HEIGHT);
}


void draw() {
  
  render.beginDraw();
  render.background(0);
  topDown.beginDraw();
  pMouse.set(mouseX, mouseY);
  topDown.background(0);
  //topDown.image(edges, 0, 0);
  for (Polygon pp : polys) {
    pp.draw();
  }
  //ray.draw();
  p.update();
  //edges.beginDraw();
  //edges.fill(0,20);
  //edges.rect(0,0,width,height);
  
  p.draw();
  //edges.endDraw();
  p.cast();
  p.lookAt(pMouse);
  //p.pos.set(pMouse);
  fill(255);
  text(p.angle, 10, 10);
  
  topDown.endDraw();
  render.endDraw();
  image(topDown, 0, 0);
  image(render, AREA_WIDTH,0);


}

void keyPressed() {
  PVector force = new PVector();
  
  if (key == 'w') {
    force.y -= 0.5;
  } 
  
  if (key == 's') {
    force.y += 0.5;
  }
  
  if (key == 'a') {
    force.x -= 0.5;
  }
  
  if (key == 'd') {
    force.x += 0.5;
  }
  
  force.limit(0.5);
  
  p.applyForce(force);
}

void mouseClicked() {
  newPolys();
}

void newPolys() {
  polys.clear();
  for (int i = 0; i < 20; i += 1) {
    polys.add(new Polygon(random(AREA_WIDTH), random(AREA_HEIGHT)));
  }//ray = new Ray(width / 4, height / 2);
}
