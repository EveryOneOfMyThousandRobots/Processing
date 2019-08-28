int TRI_ID = 0;
ArrayList<Tri> tris =new ArrayList<Tri>();

void checkEdges() {

  for (int i = 0; i < tris.size(); i += 1) {
    Tri t = tris.get(i);
    if (t.allEdgesFull) continue;
    for (int j = i + 1; j < tris.size(); j += 1) {
      Tri to = tris.get(j);
      if (to.allEdgesFull) continue;
      if (t.id == to.id) {
        continue;
      } else {
        for (Edge e : t.edges) {
          for (Edge ee : to.edges) {
            if (e.equals(ee)) {
              e.full = true;
              ee.full = true;
            }
          }
        }
      }
    }
  }
}



class Tri {
  final Polygon polygon;
  final Area area;
  Edge[] edges = new Edge[3];
  PVector[] points = new PVector[3];
  final int id;
  boolean allEdgesFull = false;
  color col;
  {
    TRI_ID += 1;
    id = TRI_ID;
  }

  private ArrayList<Tri> neighbours = new ArrayList<Tri>();

  void addNeighbour(Tri t) {
    if (t.id == id) return;
    if (neighbours.contains(t)) return;
    neighbours.add(t);
  }

  int countNeighbours() {
    return neighbours.size();
  }

  Tri getNeighbour(int i) {
    return neighbours.get(i);
  }

  Tri(Polygon polygon) {
    this.polygon = polygon;
    area = new Area(polygon);

    for (int n = 0; n < polygon.npoints; n += 1) {
      int nn = (n + 1) % polygon.npoints;
      int x1 = polygon.xpoints[n];
      int y1 = polygon.ypoints[n];
      int x2 = polygon.xpoints[nn];
      int y2 = polygon.ypoints[nn];


      edges[n] = new Edge(x1, y1, x2, y2);
      points[n] = new PVector(x1,y1);
    }

    setColour(this);
  }

  void update() {
    if (allEdgesFull) return;
    allEdgesFull = true;
    for (Edge e : edges) {
      if (!e.full) {
        allEdgesFull = false;
        return;
      }
    }
    
    if (allEdgesFull) {
      //col = color(255,0,0);
    }
  }


  void draw() {
    stroke(255);
    fill(col);
    beginShape();
    for (int n = 0; n < polygon.npoints; n += 1) {
      vertex(polygon.xpoints[n], polygon.ypoints[n]);
    }
    endShape(CLOSE);
  }

  //utility

  int hashCode() {
    return id;
  }

  boolean equals(Tri t) {
    if (t.id == this.id) return true;
    return false;
  }
}


class Edge {
  final int x1, y1;
  final int x2, y2;
  boolean full = false;

  int hashCode() {
    return int((x1 * 17) + (y1 * 2) + (x2 * 7) + (y2 * 11));
  }

  boolean equals(Edge o) {
    return (x1 == o.x1 && x2 == o.x2 && y1 == o.y1 && y2 == o.y2);
  }

  Edge(float x1, float y1, float x2, float y2) {
    this.x1 = floor(x1);
    this.y1 = floor(y1);
    this.x2 = floor(x2);
    this.y2 = floor(y2);
  }
}
