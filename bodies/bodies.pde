import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam;

ArrayList<Body> bodies = new ArrayList<Body>();
final float bigG = 6.67E-10;
int body_id = 0;
Body star;
int num_bodies = 5;
float density_min = 100;
float density_max = 500;

float radius_min = 1;
float radius_max = 5;

int positions_limit = 250;

boolean draw_line = true;



void setup() {
  size(1280, 720, P3D);
  smooth();

  float r = 100;
  float density = 10;
  float vol = (4/3) * PI * r * r * r;
  star = new Body(width / 2, height / 2, 0, r, vol * density, true, bodies);
  bodies.add(star);

  createSomePlanets();
  background(51);
  cam = new PeasyCam(this, 500);
  cam.lookAt(width /2,height /2 ,0);
  //frameRate(1);
}

void draw() {
  boolean removedAtLeastOne = false;
  //fill(51, 100);
  //rect(0, 0, width, height);
  background(51);
  int count = bodies.size();
  
  for (int i = 0; i < count; i += 1){
    Body b = bodies.get(i);
    b.attract();
    b.update();
    b.draw();
    //println(b);
  }
  
  

  for (int i = bodies.size()-1; i >= 0; i -= 1) {
    Body b = bodies.get(i);
    if (b.locked) continue;
    if (PVector.dist(b.pos, star.pos) > width * 4 || b.dead) {
      bodies.remove(i);
      removedAtLeastOne = true;
    }
  }
  if (removedAtLeastOne) { 
    createSomePlanets();
  }
  //noLoop();
}