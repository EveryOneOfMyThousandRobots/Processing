class Block {
  PVector pos;
  PVector dims;
  Surface[] surfaces;
  Block(float x, float y, float w, float h) {
    pos = new PVector(x,y);
    dims = new PVector(w,h);
    
    float w2 = w / 2;
    float h2 = h / 2;
    
    surfaces = new Surface[4];
    
    surfaces[0] = new Surface(x,    y,    x+w,  y,     x - w2, y - h2, w * 2, h2,      color(255,0,0,128));
    surfaces[1] = new Surface(x+w,  y,    x+w,  y+h,   x+w,      y - h2, w2, h * 2,    color(0,255,0,128));
    surfaces[2] = new Surface(x+w,  y+h,  x,    y+h,   x - w2, y+h,      w * 2, h2,      color(0,0,255,128));
    surfaces[3] = new Surface(x,    y+h,  x,    y,     x - w2, y -h2, w2, h * 2,      color(200,0,200,128));
    
    
    
  }
  
  Surface collidesWith(float x, float y) {
    for (Surface s : surfaces) {
      if (x > s.coll.x && x < s.coll.x + s.collDims.x && y > s.coll.y && y < s.coll.y + s.collDims.y) {
        return s;
      }
    }
    
    return null;
  }
  
  void draw() {
    for (Surface s : surfaces) {
      s.draw();
    }
  }
  
  
}

int surfaceRes = 8;
float sn = sin(-HALF_PI);
float cs = cos(-HALF_PI);

class Surface {
  PVector A, B;
  PVector coll, collDims;
  PVector[] forcePoints;
  PVector[] forces;
  color collisionBoxColour = color(255,0,255);
  
  Surface(float x0, float y0, float x1, float y1, float cx, float cy, float cw, float ch, color collisionBoxColour) {
    A = new PVector(x0, y0);
    B = new PVector(x1,y1);
    
    coll = new PVector(cx, cy);
    collDims = new PVector(cw,ch);
    this.collisionBoxColour = collisionBoxColour;
    
    float step = (1.0 / (float) surfaceRes);
    forces = new PVector[surfaceRes];
    forcePoints = new PVector[surfaceRes];
    int s = 0;
    for (float t = 0; t < 1; t += step) {
      PVector C = PVector.sub(B,A);
      PVector D = C.copy();
      C.mult(t);
      forcePoints[s] = C.add(A);
      D.normalize();
      float xx = D.x;
      float yy = D.y;
      println("D = " + D);
      D.x = yy;//(xx * cs) - (yy + sn);
      D.y = -xx;//(xx * sn) + (yy + cs);
      
      
      forces[s] = D;
      
      s += 1;
      
      println("C " + C);
      println("D' =  " + D);
    }
  }
  
  void draw() {
    stroke(0,128);
    line(A.x, A.y, B.x, B.y);
    //for (int s = 0; s < surfaceRes; s += 1) {
    //  PVector C = forcePoints[s];
    //  PVector D = forces[s];
    //  stroke(255,0,0,128);
    //  line(C.x, C.y, C.x + (20*D.x), C.y + (20*D.y));
      
      
    //}
    
    //stroke(collisionBoxColour);
    //noFill();
    //rect(coll.x, coll.y, collDims.x, collDims.y);
  }
}
