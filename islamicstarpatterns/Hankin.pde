class Hankin {
  PVector a, b;
  PVector v;
  
  float previous_dist = 0;
  Hankin(PVector a, PVector v) {
    this.a = a.copy();

    this.v = v.copy();
    this.b = PVector.add(a, v);
    
  }



  void draw() {
    noFill();
    stroke(255, 0, 0);
    line(a.x, a.y, b.x, b.y);
    //if (debug) {
    //  ellipse(a.x, a.y, 10, 10);
    //  //line(a.x, a.y, b.x, b.y);
    //  if (end != null) {
    //    stroke(0, 255, 0);
    //    ellipse(end.x, end.y, 10, 10);
    //  }
    //}
  }

  //void findEnd(Hankin o) {
  //  ////find the intersecion of the lines
  //  //float denominator = (o.v.y * v.x) - (o.v.x * v.y);
  //  //float numa = (o.v.x * (a.y - o.a.y)) - (o.v.y * (a.x - o.a.x));
  //  //float numb = (v.x * (a.y - o.a.y)) - (v.y * (a.x - o.a.x));

  //  //float ua = numa / denominator;
  //  //float ub = numb / denominator;

  //  //float x = a.x + (ua * v.x);
  //  //float y = a.y + (ua * v.y); 

  //  //if (ua > 0 && ub > 0) {
  //  //  PVector candidate = new PVector(x, y);
  //  //  float d1 = PVector.dist(candidate, a);
  //  //  float d2 = PVector.dist(candidate, o.a);
  //  //  float dist = d1 + d2;
  //  //  float diff = abs(d1 - d2);
  //  //  if (diff < 0.001) {
  //  //    if (end == null) {
  //  //      end = candidate;
  //  //      previous_dist = dist;
  //  //    } else {
  //  //      if (dist < previous_dist) {
  //  //        end = candidate;
  //  //        previous_dist = dist;
  //  //      }
  //  //    }
  //  //  }
  //  //}
  //}
}