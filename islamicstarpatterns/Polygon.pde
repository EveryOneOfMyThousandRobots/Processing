class Polygon {
  ArrayList<Edge> edges = new ArrayList<Edge>();
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  PVector pos;
  float radius;

  Polygon(float x, float y, int numSides, float radius) {
    
    pos = new PVector(x,y);
    this.radius = radius;

    //addVertex(x,y);
    //addVertex(x + radius, y);
    //addVertex(x + radius, y + radius);
    //addVertex(x, y + radius);
    float cx = x + radius / 2;
    float cy = y + radius / 2;


    for (int i = 0; i < numSides; i += 1) {
      float angle = (i * (TWO_PI / numSides)); 
      float xx = cx + radius * cos(angle);
      float yy = cy + radius * sin(angle);
      addVertex(xx, yy);
    }
    close();
  }

  //void findEnds() {
  //  //for (Edge edge : edges) {
  //  //  edge.clearEnds();
  //  //}
  //  //for (int i = 0; i < edges.size(); i += 1) {
  //  //  for (int j = 0; j < edges.size(); j += 1) {
  //  //    if (i == j) continue;

  //  //    edges.get(i).findEnds(edges.get(j));
  //  //  }
  //  //}
  //}

  void makeHankins() {
    for (Edge edge : edges) {
      edge.hankin();
    }
  }

  void close() {
    PVector first = vertices.get(0);
    PVector last = vertices.get(vertices.size()-1);
    edges.add(new Edge(last, first));
  }

  void addVertex(float x, float y) {
    PVector a = new PVector(x, y);
    int count = vertices.size();
    if (count > 0) {
      PVector prev = vertices.get(count-1);
      Edge edge = new Edge(prev, a);
      edges.add(edge);
    }
    vertices.add(a);
    println("vertex Added (" + x + "," + y + ")");
  }


  void draw() {
    for (Edge edge : edges) {
      edge.draw();
    }
  }
}