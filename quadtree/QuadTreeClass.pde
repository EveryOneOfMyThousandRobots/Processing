class QuadTree {



  QuadTree topLeft = null;
  QuadTree topRight = null;
  QuadTree botLeft = null;
  QuadTree botRight = null;
  boolean divided = false;

  ArrayList<Particle> points = new ArrayList<Particle>();
  int capacity;
  Rectangle rec;
  QuadTree (Rectangle boundary, int capacity) {
    this.rec = boundary;
    this.capacity = capacity;
  }

  void query(Rectangle search, ArrayList<Particle> foundPoint) {
    //foundPoint.clear();
    //ArrayList<PVector> found = new ArrayList<PVector>();
    if (!rec.intersects(search)) {
    } else {
      for (Particle p : points) {
        if (search.contains(p)) {
          found.add(p);
        }
      }
    }

    if (divided) {
      topLeft.query(search, foundPoint);
      topRight.query(search, foundPoint);
      botLeft.query(search, foundPoint);
      botRight.query(search, foundPoint);
    }
  }

  void reset() {
    points.clear();
    topLeft = null;
    topRight = null;
    botLeft = null;
    botRight = null;
    divided = false;
  }


  void insert(Particle p) {
    if (!rec.contains(p)) return;

    if (points.size() < capacity) {
      points.add(p);
    } else {
      if (!divided) {
        subdivide();
      }
      topLeft.insert(p);
      topRight.insert(p);
      botLeft.insert(p);
      botRight.insert(p);
    }
  }

  void draw() {
    strokeWeight(1);
    noFill();
    stroke(0);
    if (drawTree) {
      rect(rec.x, rec.y, rec.w, rec.h);
    }
    strokeWeight(4);
    for (Particle p : points) {
      point(p.pos.x, p.pos.y);
    }

    if (divided) {
      topLeft.draw();
      topRight.draw();
      botLeft.draw();
      botRight.draw();
    }
  }



  void subdivide() {
    float ww = rec.w / 2;
    float hh = rec.h / 2;
    topLeft = new QuadTree(new Rectangle(rec.x, rec.y, ww, hh), capacity);
    topRight = new QuadTree(new Rectangle(rec.x + ww, rec.y, ww, hh), capacity);
    botLeft = new QuadTree(new Rectangle(rec.x, rec.y + hh, ww, hh), capacity);
    botRight = new QuadTree(new Rectangle(rec.x + ww, rec.y + hh, ww, hh), capacity);
    divided = true;
  }
}
