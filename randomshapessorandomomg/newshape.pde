CS getNewShape() {
  CS c = null;



  if (shapes.size() == 0 ) {
    c = new CS();
    c.centre = new PVector(width / 2, height / 2);

    float angle = TAU / 6;

    for (int i = 0; i < c.points.length; i += 1) {
      float radius = random(radius_min, radius_max);
      float a = (angle * i) + random(rmin, rmax);
      float x = c.centre.x + radius * cos(a);
      float y = c.centre.y + radius * sin(a);
      PVector p = new PVector(x, y);
      c.points[i] = p;
    }
  } else {

    int attempts = 0;
    c = new CS();
    while (attempts <= 1000) {
      
      attempts += 1;
      int r = floor(random(shapes.size()));
      CS o = shapes.get(r);

      r = floor(random(o.points.length -1));
      r -= (r % 2);

      if (o.used[r]) continue;

      c.points[0] = o.points[r].copy();
      c.points[1] = o.points[r+1].copy();

      o.used[r] = true;
      o.used[r+1] = true;
      c.used[0] =  true;
      c.used[1] = true;


      float x1 = c.points[0].x;
      float x2 = c.points[1].x;
      float y1 = c.points[0].y;
      float y2 = c.points[1].y;
      PVector mid = new PVector( (x1 + x2) / 2, (y1 + y2) / 2);
      //println("1 (" + x1 + "," + y1 + "),  2(" + x2 + "," + y2 +") mid: " + mid);
      //println("o.centre : " + o.centre);
      c.centre = PVector.sub(mid, o.centre).mult(2).add(o.centre);
      //println(centre);
      float startAngle = PVector.sub(c.points[1], c.centre).heading();
      float angle = TAU / 6;

      for (int i = 2; i < 6; i += 1) {
        float radius = random(radius_min, radius_max);
        float a = startAngle + (angle * i) + random(rmin, rmax);
        float x = c.centre.x + radius * cos(a);
        float y = c.centre.y + radius * sin(a);
        PVector p = new PVector(x, y);
        c.points[i] = p;
      }
      break;
    }
    if (attempts >= 999) {
      c = null;
      println("failed");
    }
  }

  return c;
}