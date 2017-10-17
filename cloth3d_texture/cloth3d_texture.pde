// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/jrk_lOg_pVA

import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;
import toxi.geom.*;
PImage img;

int cols = 60;
int rows = 30;


Particle[][] particles = new Particle[cols][rows];
ArrayList<Spring> springs;

float w = 10;

VerletPhysics3D physics;

void setup() {
  size(700, 700, P3D); 
  springs = new ArrayList<Spring>();
  img = loadImage("kitty.jpg");
  textureMode(NORMAL);

  physics = new VerletPhysics3D();
  Vec3D gravity = new Vec3D(0, 0.4, 0);
  GravityBehavior3D gb = new GravityBehavior3D(gravity);
  physics.addBehavior(gb);

  float x = -cols*w/2;
  for (int i = 0; i < cols; i++) {
    float y = -rows * (w/2);
    for (int j = 0; j < rows; j++) {
      Particle p = new Particle(x, y, 0);
      particles[i][j] = p;
      physics.addParticle(p);
      y = y + w;
    }
    x = x + w;
  }

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      Particle a = particles[i][j];
      if (i != cols-1) {
        Particle b1 = particles[i+1][j];
        Spring s1 = new Spring(a, b1);
        springs.add(s1);
        physics.addSpring(s1);
      }
      if (j != rows-1) {
        Particle b2 = particles[i][j+1];
        Spring s2 = new Spring(a, b2);
        springs.add(s2);
        physics.addSpring(s2);
      }
    }
  }

  for (int i = 0; i < rows; i += 1) {
    particles[0][i].lock();
  }
}
float a = 0;
float zoff = 0;

void draw() {
  background(51);
  zoff += 0.1;
  translate(width/2, height/2);
  //rotateX(PI/2);
  //rotateY(a);
  //a += 0.01;
  physics.update();


  float xoff = 0;
  for (int i = 0; i < cols; i++) {
    xoff += 0.1;
    float yoff = 0;
    for (int j = 0; j < rows; j++) {
      yoff += 0.1;
      float windx = map(noise(xoff, yoff, zoff), 0, 1, 1, 5);
      float windz = map(noise(xoff + 1000, yoff + 1000, zoff), 0, 1, -5, 5);
      Vec3D wind = new Vec3D(windx, 0, windz);
      particles[i][j].addForce(wind);
    }
  }
  
  //stroke(255);
  noFill();
  noStroke();


  for (int j = 0; j < rows-1; j += 1) {
    beginShape(TRIANGLE_STRIP);
    texture(img);
    for (int i = 0; i < cols; i += 1) {
      float x1 = particles[i][j].x;
      float y1 = particles[i][j].y;
      float z1 = particles[i][j].z;
      float u = map(i, 0, cols-1, 0, 1);
      float v = map(j, 0, rows-1, 0,1);
      vertex(x1, y1, z1, u, v);
      float x2 = particles[i][j+1].x;
      float y2 = particles[i][j+1].y;
      float z2 = particles[i][j+1].z;
      v = map(j+1, 0, rows-1, 0,1);
      


      
      vertex(x2, y2, z2, u, v);
    }
    endShape();
  }
  

  //for (Spring s : springs) {
  //  s.display();
  //}
}