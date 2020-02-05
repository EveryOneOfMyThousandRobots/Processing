



class Map {

  ArrayList<Area> areas = new ArrayList<Area>();

  Map() {
    for (int x = 0; x < 50; x += 10) {
      for (int y = 0; y < 50; y += 10) {
        areas.add(new Area(x,y,0));
      }
    }
  }


  void draw() {
    stroke(255);
    noFill();
    translate(width / 2, height / 2);
    for (Area a : areas) {

      PVector prev = null;
      
      for (float tx = 0; tx < 1; tx += 0.5) {
        for (float ty = 0; ty < 1; ty += 0.5) {
          PVector p = a.toScreen(tx,ty);
       
          if (prev != null) {
            line(p.x, p.y, prev.x, prev.y);
          }
          
          prev = p;
          
        }
        
      }
      
      
      //float x0 = (width / 4) + (a.pos.x);
      //float y0 = (height / 2) -(a.pos.z);
      //PVector a0 = new PVector(x0, y0);

      //ellipse(a0.x, a0.y, 2, 2);

      //PVector a1 = a0.copy().add(PVector.fromAngle(-PI/8).mult(a.dims.x));
      //ellipse(a1.x, a1.y, 2, 2);

      //PVector a2 = a0.copy().add(PVector.fromAngle(0).mult(2 * a.dims.x * cos(PI/8)));
      //ellipse(a2.x, a2.y, 2, 2);      

      //PVector a3 = a0.copy().add(PVector.fromAngle(PI/8).mult(a.dims.x));
      //ellipse(a3.x, a3.y, 2, 2);
      
      //fill(255,64);
      //beginShape();
      //vertex(a0.x, a0.y);
      //vertex(a1.x, a1.y);
      //vertex(a2.x, a2.y);
      //vertex(a3.x, a3.y);
      //endShape(CLOSE);
      
    }
  }
}

Map map;
void setup() {
  size(800, 800);
  map = new Map();
}



void draw() {
  background(0);
  map.draw();
}
