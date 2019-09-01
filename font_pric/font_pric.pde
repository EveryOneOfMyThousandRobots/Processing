HashMap<Integer, PGraphics> map = new HashMap<Integer, PGraphics>();
HashMap<Integer, double[]> map_d = new HashMap<Integer, double[]>(); 
final int IMG_SIZE = 14;
PFont font;
void setup() {
  size(400, 400);
  font = createFont("Calibri", 10);
  textFont(font);

  for (int c = 65; c < 65 + 26; c += 1) {
    String s = Character.toString((char)c);
    PGraphics img = createGraphics(IMG_SIZE, IMG_SIZE);
    img.beginDraw();
    img.background(0);
    img.fill(255);
    img.textAlign(CENTER, CENTER);

    img.text(s, IMG_SIZE/2, IMG_SIZE/2);

    img.endDraw();
    map.put(c, img);
  }
}

void draw() {
  background(51);
  int x = 0, y = 0;

  for (Integer s : map.keySet()) {
    image(map.get(s), x, y);
    x += IMG_SIZE;
    if (x >= width-1) {
      x = 0;
      y += IMG_SIZE;
    }
  }

  Brain brain = new Brain();
  brain.run();

  noLoop();
}

double[] imgToDoubleArray(PImage p) {

  double[] a = new double[p.width * p.height];


  p.loadPixels();
  for (int i = 0; i < p.pixels.length; i += 1) {
    a[i] = brightness(p.pixels[i]);
  }
  
  //print("\nImage: " + Arrays.toString(a));



  return a;
}

PImage DoubleArrayToImage(double[] da) {
  PGraphics img = createGraphics(IMG_SIZE, IMG_SIZE);
  img.beginDraw();
  img.loadPixels();
  for (int i = 0; i < da.length; i += 1) {
    img.pixels[i] = color((float)da[i]);
  }
  img.updatePixels();
  img.endDraw();

  return img;
}

class Brain {
  void run() {
    int x = 0;
    int y = 100;
    double[][] X = new double[map.size()][1];
    ArrayList<Integer> mapList = new ArrayList(map.keySet());
    for (int xi = 0; xi < X.length; xi += 1) {
      X[xi][0] = mapList.get(xi);
    }
    double[][] Y = new double[map.size()][IMG_SIZE*IMG_SIZE];
    for (int yi = 0; yi < Y.length; yi += 1) {
      PImage p = map.get(mapList.get(yi));
      Y[yi] = imgToDoubleArray(p);
      println("Y=" + Arrays.toString(Y[yi]));
    }

    int m = 1;
    int nodes = 400;

    X = np.T(X);
    Y = np.T(Y);

    double[][] W1 = np.random(nodes, 1);
    double[][] b1 = new double[nodes][m];

    double[][] W2 = np.random(1, nodes);
    double[][] b2 = new double[1][m];

    for (int i = 0; i < 4000; i++) { //<>//
      // Foward Prop
      // LAYER 1
      double[][] Z1 = np.add(np.dot(W1, X), b1);
      double[][] A1 = np.sigmoid(Z1);

      //LAYER 2
      double[][] Z2 = np.add(np.dot(W2, A1), b2);
      double[][] A2 = np.sigmoid(Z2);

      double cost = np.cross_entropy(m, Y, A2);
      //costs.getData().add(new XYChart.Data(i, cost));

      // Back Prop
      //LAYER 2
      double[][] dZ2 = np.subtract(A2, Y);
      double[][] dW2 = np.divide(np.dot(dZ2, np.T(A1)), m);
      double[][] db2 = np.divide(dZ2, m);

      //LAYER 1
      double[][] dZ1 = np.multiply(np.dot(np.T(W2), dZ2), np.subtract(1.0, np.power(A1, 2)));
      double[][] dW1 = np.divide(np.dot(dZ1, np.T(X)), m);
      double[][] db1 = np.divide(dZ1, m);

      // G.D
      W1 = np.subtract(W1, np.multiply(0.01, dW1));
      b1 = np.subtract(b1, np.multiply(0.01, db1));

      W2 = np.subtract(W2, np.multiply(0.01, dW2));
      b2 = np.subtract(b2, np.multiply(0.01, db2));

      if (i % 400 == 0) {
        PImage img = DoubleArrayToImage(A2[0]);
        image(img,x,y);
        x += IMG_SIZE;
        if (x > width) {
          x = 0;
          y += IMG_SIZE;
        }
        //print("\n==============");
        //print("\nCost = " + cost);
        print("\nPredictions = " + Arrays.deepToString(A2));
      }
    }
  }
}
