ArrayList<FW> fw = new ArrayList<FW>();
PVector GRAV = new PVector(0, 0.06);
ArrayList<Explosion> expls= new ArrayList<Explosion>();
PGraphics bg;
ArrayList<Particle> particles = new ArrayList<Particle>();
void setup() {
  size(800,800);
  bg = createGraphics(width, height);
}


void draw() {
  background(0);
  //image(bg, 0, 0);
  
  
  if (fw.size() < 10 && random(1) < 0.1) {
   newFw();   
    
  }
  
  
  for (int i = fw.size()-1; i >= 0; i -= 1) {
    FW f = fw.get(i);
    f.applyForce(GRAV);
    f.update();
    f.draw();
    
    if (!f.alive) {
      fw.remove(i);
    }
    
    

  }
  
  for (int i = expls.size()-1; i >= 0; i -=1) {
    Explosion e = expls.get(i);
    e.update();
    e.draw();
    
    if (e.timer <= 0) {
      expls.remove(i);
    }
  }
  
  
  for (int i = particles.size()-1; i >= 0; i -= 1) {
    Particle p = particles.get(i);
    p.update();
    p.draw();
    
    if (!p.alive) {
      particles.remove(i);
    }
  }
  
  //bg.beginDraw();
  //bg.noStroke();
  //bg.fill(0, 15);
  //bg.rect(0, 0, width, height);
  //bg.endDraw();
}


void newFw() {
  FW f = new FW(width / 2 + random(-width/8,width/8), height);
  fw.add(f);
}
