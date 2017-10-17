import peasy.*;
//import peasy.org.apache.commons.math.*;
//import peasy.org.apache.commons.math.geometry.*;

final float MAX_DIST = 200;
final float MIN_DIST = 5;

PeasyCam cam;






Tree tree;
void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 800);
  tree = new Tree();
  tree.addLeaf(1, 2);
  tree.addLeaf(1, 3);
  tree.addLeaf(1, 4);
  tree.addLeaf(1, 10);
  tree.addLeaf(1, 15);
  tree.addLeaf(1, 21);

  tree.addLeaf(2, 1);
  tree.addLeaf(2, 5);
  tree.addLeaf(2, 9);
  tree.addLeaf(2, 11);
  tree.addLeaf(2, 15);
  tree.addLeaf(2, 16);
  tree.addLeaf(2, 20);
  tree.addLeaf(2, 21);

  tree.addLeaf(3, 1);
  tree.addLeaf(3, 8);
  tree.addLeaf(3, 12);
  tree.addLeaf(3, 15);
  tree.addLeaf(3, 17);
  tree.addLeaf(3, 19);
  tree.addLeaf(3, 21);

  tree.addLeaf(4, 1);
  tree.addLeaf(4, 8);
  tree.addLeaf(4, 15);
  tree.addLeaf(4, 18);
  tree.addLeaf(4, 21);

  tree.addLeaf(5, 2);
  tree.addLeaf(5, 3);
  tree.addLeaf(5, 4);
  tree.addLeaf(5, 8);
  tree.addLeaf(5, 12);
  tree.addLeaf(5, 15);
  tree.addLeaf(5, 21);

  tree.addLeaf(6, 5);
  tree.addLeaf(6, 8);
  tree.addLeaf(6, 9);
  tree.addLeaf(6, 10);
  tree.addLeaf(6, 11);
  tree.addLeaf(6, 12);
  tree.addLeaf(6, 15);
  tree.addLeaf(6, 21);



  // frameRate(5);
}

void draw() {
  background(0);
  int countBranches = tree.branches.size(); 
  tree.grow();
  tree.draw();
}