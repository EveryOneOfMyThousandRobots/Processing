class M {
  Brain brain;
  M () {
    brain = new Brain(2, 10, 10, 1);
  }
  float fitness = 0;

  void update() {
    float[] a = {0, 1};
    brain.setInputs(a);
    brain.calc();
  }
  
  void update(float[] a) {
    brain.setInputs(a);
    brain.calc();
  }
}

void printArray(float[] a) {
  print("\t");
  for (int i = 0; i < a.length; i += 1) {
    print(" " + a[i]);
  }
  print("\n");
}

void printArray(float[][] a) {
  for (int i = 0; i < a.length; i += 1) {
    println(i);
    printArray(a[i]);
  }
}

M m;
float[][] inputArray = { {0,0}, {0,1}, {1,0}, {1,1}};
float[] result = {0,1,1,1};
int inputIdx = 0;
void setup() {
  size(500,500);
  m = new M();
  
  
  
  
  
  
  
  
}


long cycles = 0;
void draw() {
  background(0);
  cycles += 1;

  m.update();
  text("cycles " + cycles, 10,10);
  text("out " + m.brain.out.values[0], 10,30);
  text("fitness " + m.fitness, 10, 50);
  float[] a = inputArray[inputIdx];
  float r = result[inputIdx];
  inputIdx += 1;
  if (inputIdx >= inputArray.length) {
    inputIdx = 0;
  }
  m.update(a);
  float o = m.brain.out.values[0];
  
  m.fitness = o - r;
  
  
  if (m.fitness > 0.9) {

    print("input");
    printArray(m.brain.inputs);
    print("l1");
    printArray(m.brain.l1.values);
    printArray(m.brain.l1.weights);
    print("l2");
    printArray(m.brain.l2.values);
    printArray(m.brain.l2.weights);
    print("output");
    printArray(m.brain.out.values);
    printArray(m.brain.out.weights);
    stop();
  } else {
    m.brain.l1.adjustWeights();
    m.brain.l2.adjustWeights();
    m.brain.out.adjustWeights();
  }
}

float sigmoid(float f) {
  return 1 / (1 + (pow(exp(1),-f)));
}