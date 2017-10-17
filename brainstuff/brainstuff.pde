float[][] training = {{0, 0, 0}, {0, 1, 1}, {1, 0, 1}, {1, 1, 0}};
ArrayList<String> results = new ArrayList<String>();
Brain brain;
void setup() {
  size(500, 500);
  brain = new Brain(2, 3, 10, 1);
  println(brain);
  frameRate(10000);
  textFont(createFont("Consolas", 10));
}

void draw() {

  //println(brain);
  train();
  if (frameCount % 200 == 0 ) {
    background(0);
    //brain.draw();
    for (int i = 0; i < results.size(); i += 1) {
      text(results.get(i), 10, 20 + (10 * i));
    }
    String totalString = correct + "/" + total+" = " + nf(((correct / total) * 100),1,0) + "%";
    text(totalString, 10, 10);
  }
  //stop();
}