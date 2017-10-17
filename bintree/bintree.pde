Tree tree;
void setup() {
  size(400,400);
  tree = new Tree();
  


  for (int i = 0; i < 20; i += 1) {
    tree.add(random(1, 100));
  }
  
  println(tree);
  Node found = tree.search(5);
  if (found != null) {
    println(found.val);
  } else {
    println("not found");
  }
  println(tree.levels);
  
  //tree.traverse();
  noLoop();
}

void draw() {
  background(0);
  tree.draw();
}