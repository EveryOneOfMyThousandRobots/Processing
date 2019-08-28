class RData implements Comparable<RData> {
  
  
  
  Float angle;
  PVector val;
  boolean collided = false;
  RData(float angle, float x, float y) {
    this.angle = angle;
    this.val = new PVector(x, y);
  }
  
  int hashCode() {
    return nfc(angle,4).hashCode();
  }
  
  boolean equals(RData o) {
    return hashCode() == o.hashCode(); 
  }


  int compareTo(RData o) {
    if (angle < o.angle) {
      return -1;
    } else if (angle > o.angle) {
      return 1;
    } else {
      return 0;
    }
  }

  public String toString() {

    return "RayData: " + nfc(angle, 2) + " (" + floor(val.x) + "," + floor(val.y) + ")";
  }
}



class Ray {

  PVector start, end;
  PVector collidesAt = new PVector();
  boolean collided = false;
  Ray(PVector start, PVector end) {
    this.start = start.copy();
    this.end = end.copy();
  }


  void update() {
  }


  void draw() {
    stroke(255, 64);
    line(start.x, start.y, end.x, end.y);
  }

  void cast() {
    collided = false;
    float dist = 0;
    float minDist = -1;
    PVector closest = null;
    PVector temp = new PVector();
    for (Edge e : edgeList) {
      float t = t(start, end, e.start, e.end);
      float u = u(start, end, e.start, e.end);
      if (t >= 0 && t <= 1 && u >= 0 && u <= 1) {
        temp.x = start.x + t * (end.x - start.x);
        temp.y = start.y + t * (end.y - start.y);

        dist = quickDist(start, temp);

        if (closest == null || dist < minDist) {
          minDist = dist;
          closest = temp.copy();
        }
      }
    }

    if (closest != null) {
      collidesAt.set(closest);
      collided = true;
    }
  }
}

class Particle {
  PVector pos = new PVector();
  ArrayList<Ray> rayList = new ArrayList<Ray>();


  Particle() {
  }

  String getCoord(PVector v) {
    return floor(v.x)+"_"+floor(v.y);
  }

  void setRays() {


    rayList.clear();
    for (RData r : rays) {


      addRay(PVector.add(pos, r.val));

      //rays.add(new Ray(pos, e.end));
    }
  }


  void addRay(PVector end) {
    Ray r = new Ray(pos, end);
    r.cast();
    rayList.add(r);
    //rays.add(new Ray(pos, end, -0.001));
    //rays.add(new Ray(pos, end, 0.001));
    //String k1 = getCoord(end);
    //if (!coords.contains(k1)) {
    //  rays.add(new Ray(pos, end));
    //} else {
    //  coords.add(k1);
    //}
  }

  void update() {
    pos.set(mouseX, mouseY);
  }


  void draw() {
    stroke(255);
    fill(255);
    if (rayList.size() >= 2) {

      beginShape(TRIANGLES);
      for (int i = 0; i < rayList.size()-1; i += 1) {
        Ray r1 = rayList.get(i);
        Ray r2 = rayList.get(i+1);

        vertex(pos.x, pos.y);
        vertex(r1.collidesAt.x, r1.collidesAt.y);
        vertex(r2.collidesAt.x, r2.collidesAt.y);
        //line(pos.x, pos.y, r1.end.x, r1.end.y);
        if (r1.collided) {
          //ellipse(r1.collidesAt.x, r1.collidesAt.y, 5, 5);
        }
        //vertex(pos.x, pos.y);
        //vertex(r1.end.x, r1.end.y);
      }
      Ray r1 = rayList.get(0);
      Ray r2 = rayList.get(rayList.size()-1);
      vertex(pos.x, pos.y);
      vertex(r1.collidesAt.x, r1.collidesAt.y);
      vertex(r2.collidesAt.x, r2.collidesAt.y);
    }

    //vertex(pos.x, pos.y);
    endShape(CLOSE);
  }
}
