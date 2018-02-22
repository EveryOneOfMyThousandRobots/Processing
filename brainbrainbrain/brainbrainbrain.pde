Brain brain;
HashMap<String, Integer> idList = new HashMap<String, Integer>(100);

float[][] training = {{0, 0, 0}, {0, 1, 1}, {1, 0, 1}, {1, 1, 0}};
void setup() {
  idList.put("something", 1);
  brain = new Brain(2, 2, 3, 1);
  //println(brain.toString());
  for (int i = 0; i < training.length; i += 1) {
    float x1 = training[i][0];
    float x2 = training[i][1];
    float answer = training[i][2];
    brain.setInput(x1, x2);
    brain.calc();
    float y = brain.output.nodes[0].value;
    float error = pow(answer - y, 2);
    brain.calcError(answer);
    
    println(x1 + "," + x2 + " y: " + y + " answer:" + answer + " error: " + error) ;
    
  }
  //println(brain.toString());
  //println(brain.output.toString());
}

void draw() {
}