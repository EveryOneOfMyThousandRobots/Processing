final int N = 0;
ArrayList<nPV> points = new ArrayList<nPV>();
ArrayList<nPV> vel = new ArrayList<nPV>();
final int NUM_POINTS = 5;

void setup() {
  size(600, 600, P2D);

  while (points.size() < NUM_POINTS) {
    nPV np = new nPV(random(width), random(height));
    if (!points.contains(np)) {
      points.add(np);
      vel.add(getRandom2DPV());
    }
  }
}

float distSq(PVector A, PVector B) {
  return distSq(A.x, A.y, B.x, B.y);
}

float distSq(float x, float y, PVector B) {
  return distSq(x, y, B.x, B.y);
}
float distSq(float x0, float y0, float x1, float y1) {
  float xx = (x0 - x1);
  float yy = (y0 - y1);

  return ((xx * xx) + (yy * yy));
}


void draw() {
  background(0);

  loadPixels();
  float maxDist = -1;
  for (int i = 0; i < points.size(); i += 1) {
    for (int j = 0; j < points.size(); j += 1) {
      if (j == i) continue;

      float dist = distSq(points.get(i), points.get(j));
      if (maxDist == -1 || dist > maxDist) {
        maxDist = dist;
      }
    }
  }
  //maxDist = sqrt(maxDist);

  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      //float[] distances = new float[points.size()];
      HashMap<nPV, Float> map = new HashMap<nPV, Float>();
      ValueComparator bvc = new ValueComparator(map);
      TreeMap<nPV, Float> sorted_map = new TreeMap<nPV, Float>(bvc);


      for (int i = 0; i < points.size(); i += 1) {
        float d = distSq(x, y, points.get(i));
        map.put(points.get(i), d);
      }
      sorted_map.putAll(map);
      Object[] s = sorted_map.entrySet().toArray();

      //println("unsorted :");
      //for (nPV n : map.keySet()) {
      //  println("\t" + n + " = " + map.get(n));
      //}

      //println("sorted :");
      //for (nPV n : sorted_map.keySet()) {
      //  println("\t" + n + " = " + map.get(n));
      //}
      //exit();

      Map.Entry me = (Map.Entry) s[N];

      float noise = map((Float)me.getValue(), 0, maxDist / 8, 255, 0);
      pixels[y * width + x] = color(noise);
    }
  }

  updatePixels();

  for (int i = 0; i < points.size(); i += 1) {
    PVector p = points.get(i);
    PVector v = vel.get(i);
    stroke(0);
    fill(255);
    ellipse(p.x, p.y, 5, 5);


    for (int j = 0; j < points.size(); j += 1) {
      if (i == j) continue;
      PVector p0 = points.get(j);
      float d = distSq(p, p0);

      PVector v0 = PVector.sub(p, p0);
      v0.div(d);
      v.add(v0);
    }
    v.limit(4);

    p.add(v);

    if (p.x < 0 || p.x > width-1) v.x *= -1;
    if (p.y < 0 || p.y > height-1) v.y *= -1;
  }

  //noLoop();
}
