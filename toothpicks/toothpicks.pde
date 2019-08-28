

void setup() {
  size(600, 600);
  picks.add(new TP(0, 0, DIR.VERTICAL));
  //noLoop();
}


void draw() {
  background(255);
  translate(width /2, height / 2);
  stroke(0);
  //strokeWeight(2);
  ArrayList<TP> next = new ArrayList<TP>();
  for (TP tp : picks) {
    
    if (!tp.aTaken) {
      TP a = tp.createA(picks);
      if (a != null) {
        next.add(a);
      }
    }

    if (!tp.bTaken) {
      TP b = tp.createB(picks);


      if (b != null) {
        next.add(b);
      }
    }
  }

  picks.addAll(next);
  
  for (TP t : picks) {
    t.draw();
  }
  //println(picks.size());
}

//void mousePressed() {
//  redraw();
//}
