class SF {
  PGraphics img;
  float rAngle = 0;
  float rAngleInc;

  int sections;
  int points;
  float size;

  float[] distances;
  int[] linesA;
  int[] linesB;
  PVector pos;
  PVector vel;

  SF(float x, float y) {
    pos = new PVector(x,y);
    rAngleInc = radians(random(0.1,1));
    
    sections = floor(random(6, 13));
    if (sections % 2 == 1) {
      sections += 1;
    }
    points = floor(random(10, 20));

    size = random(50, 100);
    vel = new PVector(0, size * 0.02 + random(0.01, 0.05));
    distances = new float[points];

    linesA = new int[floor(random(1, points))];
    linesB = new int[linesA.length];

    for (int i = 0; i < linesA.length; i += 1) {
      linesA[i] = floor(random(points));
      linesB[i] = floor(random(points));
    }
    
    for (int i = 0; i < points; i += 1) {
      distances[i] = random(0, size/2);
      //lastDist = distances[i]+1;
    }
    generate();
  }

  String toString() {
    return "sections: " + sections + ", points: " + points + ", size: " + floor(size);
  }

  void generate() {

    img = createGraphics(floor(size), floor(size));

    img.beginDraw();
    img.stroke(255);
    float angleInc = TWO_PI / float(sections);
    PVector from = new PVector(0,0);
    //img.pushMatrix();
    
    for (float angle = rAngle; angle < (TWO_PI + rAngle); angle += angleInc) {
      img.pushMatrix();
      img.translate(img.width / 2, img.height / 2);
      //img.rotate(rAngle);
      img.rotate(angle);
      PVector left = PVector.fromAngle(-(angleInc / 2));
      PVector right = PVector.fromAngle(angleInc / 2);
      left.add(from);
      //left.setMag(size/2);
      right.add(from);
      //right.setMag(size/2);
      PVector leftTo = PVector.sub(left, from);
      PVector rightTo = PVector.sub(right, from);
      PVector[] leftPoints = new PVector[points];
      PVector[] rightPoints = new PVector[points];
      //img.stroke(255, 0, 0);
      //img.line(from.x, from.y, leftTo.x, leftTo.y);
      //img.stroke(0, 255, 0);
      //img.line(from.x, from.y, rightTo.x, rightTo.y);

      for (int p = 0; p < points; p += 1) {
        leftPoints[p] = PVector.sub(leftTo, from).setMag(distances[p]);
        rightPoints[p] = PVector.sub(rightTo, from).setMag(distances[p]);
        println("left: " + leftPoints[p].toString() + " right: " + rightPoints[p].toString());
        ellipse(leftPoints[p].x, leftPoints[p].y, 10, 10);
      }
      img.stroke(255);
      for (int i = 0; i < linesA.length; i += 1) {
        PVector lft1 = leftPoints[linesA[i]];
        PVector rgt1 = rightPoints[linesB[i]];

        PVector lft2 = leftPoints[linesB[i]];
        PVector rgt2 = rightPoints[linesA[i]];

        img.line(lft1.x, lft1.y, rgt1.x, rgt1.y);
        img.line(lft2.x, lft2.y, rgt2.x, rgt2.y);
      }
      img.popMatrix();
    }
    //img.popMatrix();
    img.endDraw();
  }
  
  void draw() {
    pushMatrix();
    translate(pos.x, pos.y );
    rotate(rAngle);
    image(img, -size/2, -size/2);
    popMatrix();
    
  }
  
  void update() {
    pos.add(vel);
    rAngle += rAngleInc;
  }
}
