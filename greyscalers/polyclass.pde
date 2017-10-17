final float MIN_RAD = 3;
final float MAX_RAD = 50;

class Poly {
  int polyId;
  //ArrayList<PVector> points = new ArrayList<PVector>();
  float[] radii;
  PVector centre;
  float angle_inc;
  float rotation;

  DNA dna;
  int numPoints;
  float hue, sat, bri, alpha;




  Poly(DNA dna, int polyId) {
    this.polyId = polyId;
    this.dna = dna;
    setDNA();
  }

  void setDNA() {
    numPoints = floor(dna.get(polyId +"_numPoints", 3, 10));
    angle_inc = TAU / numPoints;
    radii = new float[numPoints];
    centre = new PVector();
    centre.x = dna.get(polyId + "_centrex", sbx, sbx + sbw);
    centre.y = dna.get(polyId + "_centrey", sby, sby + sbh);

    for (int i = 0; i <radii.length; i += 1) {
      radii[i] = dna.get(polyId + "_radius_" + i, MIN_RAD, MAX_RAD);
    }
    rotation = dna.get(polyId + "_rotation", 0, TAU);

    hue = dna.get(polyId + "_hue", 0, 255);
    sat = dna.get(polyId + "_sat", 0, 255);
    bri = dna.get(polyId + "_bri", 0, 255);
    alpha = dna.get(polyId + "_alpha", 0, 255);

    //for (int i = 0; i < numPoints; i += 1) {
    //  float x = dna.get(polyId + "_" + i + "_x", sbx, sbx + sbw);
    //  float y = dna.get(polyId + "_" + i + "_y", sby, sby + sbh);
    //  addPoint(x,y);
    //}
  }

  void draw() {
    noStroke();
    fill(hue, 0, bri);//, alpha);
    beginShape();
    for (int i = 0; i < radii.length; i += 1) {
      float x = centre.x + radii[i] * cos(rotation + (i * angle_inc));
      float y = centre.y + radii[i] * sin(rotation + (i * angle_inc));
      if (x < sbx) {
        x = sbx;
      } else if (x > sbx + sbw) {
        x = sbx + sbw;
      }
      if (y < sby) {
        y = sby;
      } else if (y > sby + sbh) {
        y= sby + sbh;
      }
      vertex(x, y);
    }
    endShape(CLOSE);
  }
}