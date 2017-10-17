class Edge {
  float angle;
  PVector a, b;
  PVector mid;
  Hankin h1 = null, h2 = null;
  float delta;

  Edge(PVector a, PVector b) {
    this.a = a.copy();
    this.b = b.copy();
    angle = radians(angleSlider.getValue());
    delta = deltaSlider.getValue();
  }

//  void clearEnds() {
//    if (h1 != null) {
//      h1.clearEnd();
//    }
//    if (h2 != null) {
//      h2.clearEnd();
//    }
//  }

  void hankin() {
    angle = radians(angleSlider.getValue());
    delta = deltaSlider.getValue();
    mid = PVector.add(a, b).mult(0.5);
    
    
    
    PVector v1 = PVector.sub(a, mid);
    //edge length
    float edge_len = v1.mag() + delta;
    PVector v2 = PVector.sub(b, mid);

    PVector offset1 = mid.copy(); 
    PVector offset2 = mid.copy();
    if (delta > 0) {
      v1.setMag(this.delta);
      v2.setMag(this.delta);

      offset1 = PVector.add(mid, v2);
      offset2 = PVector.add(mid, v1);
    }
    v1.normalize();
    v2.normalize();

    v1.rotate(-angle);
    v2.rotate(angle);
    float interior = (NUM_SIDES - 2) * PI / NUM_SIDES;
    float alpha = interior * 0.5;
    float beta = PI - angle - alpha;
    float henkin_len = (edge_len * sin(alpha)) / sin(beta);
    
    v1.setMag(henkin_len);
    v2.setMag(henkin_len);


    h1 = new Hankin(offset1, v1);
    h2 = new Hankin(offset2, v2);
  }

  void draw() {
    stroke(255);
    if (debug) {
      line(a.x, a.y, b.x, b.y);
    }


    if (h1 != null && h2 != null) {
      h1.draw();
      h2.draw();
    }
    
    
    //noFill();
    //ellipse(mid.x, mid.y, 10,10);
  }

  //void findEnds(Edge edge) {
  //  //h1.findEnd(edge.h1);
  //  //h1.findEnd(edge.h2);
  //  //h2.findEnd(edge.h1);
  //  //h2.findEnd(edge.h2);
  //}
}