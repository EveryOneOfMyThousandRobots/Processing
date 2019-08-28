import java.util.HashSet; //<>// //<>// //<>//
import java.util.HashMap;
int EDGE_ID = 0;
class Edge {

  PVector start, end;

  final int id;
  {
    EDGE_ID += 1;
    id = EDGE_ID;
  }

  Edge(PVector start, PVector end) {
    this.start = start.copy();
    this.end = end.copy();
  }

  Edge(float sx, float sy, float ex, float ey) {
    start = new PVector(sx, sy);
    end = new PVector(ex, ey);
  }

  void draw() {
    stroke(255);
    line(start.x, start.y, end.x, end.y);
    //ellipse(start.x, start.y, 2, 2);
    //ellipse(end.x, end.y, 2, 2);
  }
}

HashMap<Integer, Edge> edges = new HashMap<Integer, Edge>();
ArrayList<Edge> edgeList = new ArrayList<Edge>();
int wantedToAdd = 0;
int actuallyAdded = 0;
void calcEdges() {
  edges.clear();
  edgeList.clear();

  for (int y = 0; y < NUM_TILES_DOWN; y += 1) {
    for (int x = 0; x < NUM_TILES_ACROSS; x += 1) {
      Tile t = getTileAt(x, y);

      if (t == null) continue;
      t.resetEdges();

      checkEdge(NORTH, WEST, t);
      checkEdge(SOUTH, WEST, t);
      checkEdge(EAST, NORTH, t);
      checkEdge(WEST, NORTH, t);
    }
  }
}

void createRayData() {
  wantedToAdd = 0;
  actuallyAdded = 0;
  float ox = mouseX;
  float oy = mouseY;
  float radius = width;
  rays.clear();
  for (Edge e : edgeList) {
    for (int i = 0; i < 2; i += 1) {

      float rdx = (i == 0 ? e.start.x : e.end.x) - ox;
      float rdy = (i == 0 ? e.start.y : e.end.y) - oy;

      float baseAngle = atan2(rdy, rdx);

      float angle = 0;
      for (int j = 0; j < 3; j += 1) {
        if (j == 0) angle = baseAngle - 0.0001f;
        if (j == 1) angle = baseAngle;
        if (j == 2) angle = baseAngle + 0.0001f;

        rdx = radius * cos(angle);
        rdy = radius * sin(angle);
        RData r = new RData(angle, rdx, rdy); 
        wantedToAdd += 1;
        if (!rays.contains(r)) {
          rays.add(r);
          actuallyAdded += 1;
        }
      }
    }
  }
  Collections.sort(rays);
  //HashSet<Float> unique = new HashSet<Float>();
  //for (RData r : rays) {
  //  if (unique.contains()
    
  //}
  
}

void checkEdge(String edgeDir, String checkDir, Tile t) {

  Tile edgeTile = t.neighbours.get(edgeDir);
  Tile checkTile = t.neighbours.get(checkDir);

  if (edgeTile == null) {
    if (checkTile == null) {
      makeEdge(edgeDir, t);
    } else {
      Edge edge = checkTile.edges.get(edgeDir);
      if (edge == null) {
        makeEdge(edgeDir, t);
      } else {
        extend(edgeDir, edge, t);
      }
    }
  }
}

void extend(String dir, Edge e, Tile t) {
  //  edge.end.x += TILE_SIZE;
  //t.edges.put(NORTH, edge);

  switch (dir) {
  case SOUTH:
  case NORTH:
    e.end.x += TILE_SIZE;
    break;
  case EAST:
  case WEST:
    e.end.y += TILE_SIZE;
    break;
  default:
    return;
  }
  t.edges.put(dir, e);
}

void makeEdge(String dir, Tile t) {
  PVector start, end;
  switch (dir) {
  case NORTH:
    start = t.TL;
    end = t.TR;
    break;
  case EAST:
    start = t.TR;
    end = t.BR;
    break;
  case SOUTH:
    start = t.BL;
    end = t.BR;
    break;
  case WEST:
    start = t.TL;
    end = t.BL;
    break;
  default:
    return;
  }

  if (start != null && end != null) {
    Edge edge = new Edge(start, end);
    t.edges.put(dir, edge);
    edgeList.add(edge);
  }
}
