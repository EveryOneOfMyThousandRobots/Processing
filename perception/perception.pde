int sign(float n) {
  if (n >= 0) {
    return 1;
  } else {
    return -1;
  }
}

class Perceptron {
  float[] weights;// = new float[3];
  float learningRate = 0.01;
  float learningRate_max = 0.02;
  float learningRate_min = 0.005;

  Perceptron(int num) {
    weights = new float[num];
    for (int i = 0; i < weights.length; i += 1) {
      weights[i] = random(-1, 1);
    }
  }

  float[] addBias(float[] inputs) {
    inputs = expand(inputs, inputs.length +1);
    inputs[inputs.length -1] = 1;
    return inputs;
  }
  
  float guessY(float x) {
    float w0 = weights[0];
    float w1 = weights[1];
    float w2 = weights[2];
    return -(w2 / w1) - (w0/w1) * x;
    //float m = weights[0] / weights[1];
    //float b = weights[2];
    //return (m * x) + b;
  }
  

  int guess(float... inputs) {
    int guess = 0;
    inputs = addBias(inputs);

    float sum = 0;
    for (int i = 0; i < weights.length; i += 1) {
      sum += inputs[i]*weights[i];
    }
    guess = sign(sum);
    return guess;
  }

  void train(int target, float... inputs) {
    inputs = addBias(inputs);
    int guess = guess(inputs);
    int error = target - guess;
    for (int  i = 0; i < weights.length; i += 1) {
      weights[i] += (error * inputs[i]) * learningRate;
    }
    learningRate = map( sin(frameCount), -PI, PI, learningRate_min, learningRate_max);
  }
}
Perceptron p;
Point[] points = new Point[100];
void setup() {
  size(300, 300);

  p = new Perceptron(3);
  //float[] inputs = {-1, 0.5};
  //int guess = p.guess(inputs);
  //println(guess);
  background(255);
  stroke(0);
  for (int i = 0; i < points.length; i += 1) {
    points[i] = new Point();
  }
  //noLoop();
  //line(0, random(height), width, random(height));
}
int trIdx;
void draw() {
  background(255);
  int correct = 0;
  int incorrect = 0;
  //draw line
  stroke(0);
  
  Point p1 = new Point(-1,f(-1));
  Point p2 = new Point(1, f(1));
  line(p1.getX(), p1.getY(), p2.getX(), p2.getY());


  //draw guess
  p1 = new Point(-1, p.guessY(-1));
  p2 = new Point(1, p.guessY(1));
  stroke(255,128,100);
  line(p1.getX(), p1.getY(), p2.getX(), p2.getY());
  //train 1
  Point ppp = points[trIdx];
  p.train(ppp.label, ppp.x, ppp.y);
  trIdx += 1;
  trIdx = trIdx % points.length;
  
  


  //draw
  for (Point pp : points) {
    pp.show();
    //float[] a = {pp.x, pp.y};
    noStroke();
    if (p.guess(pp.x, pp.y ) == pp.label) {
      fill(0, 255, 0);
      correct += 1;
    } else {
      fill(255, 0, 0);
      incorrect += 1;
    }
    ellipse(pp.getX(), pp.getY(), 6, 6);
  }
  noStroke();
  fill(255);
  rect(0,0,width,50);
  fill(0);
  text(correct + "\\" + (correct + incorrect), 10, 10);
  text(arrayToString(p.weights), 10, 20);
  text(p.learningRate, 10,30);
  text(frameCount, 10, 40);
  if (correct == (correct + incorrect)) {
    stop();
  }
  //println(p.weights);
  //println();
}

String arrayToString(float... a) {
  String out = "";
  for (float f : a ) {
    if (out.length() == 0) {
      out = str(f);
    } else {
      out += ", " + str(f);
    }
  }
  
  return out;
}