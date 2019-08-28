import geomerative.*;
import processing.pdf.*;

RFont font;
RGroup grp;
RPoint[] pnts;

int fontSize = 200;
float textWidth;

boolean freeze = false;
float offSet = 0;
float letterX = 50;
float letterY = 50;

void setup() {
  size(800, 400);
  background(51);
  //textSize(300);
  //fill(255);
  //noStroke();
  //frameRate(1);

  //text("train", 50, 300);

  RG.init(this);
  font = new RFont("arial.ttf", fontSize, RFont.LEFT);
  RCommand.setSegmentLength(15);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

  grp = font.toGroup("Chicken");
  textWidth = grp.getWidth();
  pnts = grp.getPoints();
  for (int i=0; i<pnts.length; i++) {
    //println(pnts[i].x + "," + pnts[i].y);
    vehicles.add(new Vehicle(pnts[i].x + 50, pnts[i].y + 300));
    //break;
  }  
}


void draw() {
  background(0);
  for (Vehicle v : vehicles) {
    v.update();
    v.draw();
    //text(v.toString(), 10, 10);
  }
}
