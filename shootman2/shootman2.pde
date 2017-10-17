import java.util.TreeMap;

float[][] training = {{0, 0, 0}, {0, 1, 1}, {1, 0, 1}, {1, 1, 0}};
int trIdx = 0;
PFont font;
float[] points;
int pointsIdx = 0;
float highestFitness = 0;
float lowestError = 100;
class M {
  Brain brain = new Brain(2, 1, 4, 1);
  float error = 0;
  float fitness = 0;
}

class Pop {
  ArrayList<M> ms = new ArrayList<M>();

  Pop(int size) {
    for (int i = 0; i < size; i += 1) {
      ms.add(new M());
    }
  }

  M getPartner() {
    M m = null;
    while (true) {
      int r1 = floor(random(ms.size()));
      float r2 = random(1);
      m = ms.get(r1);
      if (r2 < m.fitness) {
        break;
      }
    }

    return m;
  }

  void breed() {
    float highest = 0;
    for (int i = 0; i < ms.size(); i += 1) {
      M m = ms.get(i);
      if (m.fitness > highest) {
        highest = m.fitness;
      }
      
      if (highest > highestFitness) {
        highestFitness = highest;
      }
    }

    for (M m : ms) {
      m.fitness /= highest;
    }
    
    ArrayList<M> newPop = new ArrayList<M>();
    for (int i = 0; i < ms.size(); i += 1) {
      M m1 = getPartner();
      M m2 = getPartner();
      
      M child = new M();
      child.brain.dna = m1.brain.dna.cross(m2.brain.dna);
      child.brain.mutate();
      newPop.add(child);
    }
    ms.clear();
    ms = newPop;
  }

  void train() {
    
    for (int i = 0; i < 100; i += 1) {
      for (M m : ms) {
        for (int j = 0; j < training.length; j += 1) {

          m.brain.setInputs(training[j][0], training[j][1]);
          m.brain.calc();
          m.error = abs(training[j][2] - m.brain.output.values[0]) + 0.01;
          if (m.error < lowestError) {
            lowestError = m.error;
          }
          m.fitness = pow(1 / m.error, 4);
        }
      }
    }
  }
}


Pop pop;

void setup() {
  size(200, 200);
  //println(m.brain);
  //m.brain.setInputs(1, 0);
  //m.brain.calc();
  //println(m.brain.output.values[0]);
  //// frameRate(2);
  font = createFont("Consolas", 10);
  textFont(font);
  //points = new float[width];
  pop = new Pop(200);
  fill(0);
}



void draw() {
  background(255);
  pop.train();
  pop.breed();
  text(frameCount, 10, 10);
  text(highestFitness, 10, 20);
  text(lowestError, 10,30);
  
  //float[] tr = training[trIdx];
  //trIdx += 1;
  //trIdx = trIdx % training.length;
  //m.brain.setInputs(tr[0], tr[1]);

  //m.brain.calc();
  //float result = m.brain.output.values[0];
  //float error = abs(tr[2] - result);
  //m.brain.mutate();

  //fill(0);
  //text("input : " + tr[0] + "," + tr[1], 10, 10);
  //text("output (guess,correct) : " + result + "," + tr[2], 10, 20);
  //text("error: " + error, 10, 30);
  //points[pointsIdx] = error;
  //pointsIdx += 1;
  //pointsIdx = pointsIdx % points.length;

  //for (int x = 0; x < points.length; x += 1) {
  //  float y = map(points[x], 0, 1, height, height / 2);
  //  point(x, y);
  //}

  //float x = 10;
  //float y = 40;
  //for (String s : m.brain.dna.dna.keySet()) {
  //  if (y > height / 2) break;
  //  float f = m.brain.dna.dna.get(s);
  //  text(s + " : " + f, x, y);
  //  y += 10;
  //}
}