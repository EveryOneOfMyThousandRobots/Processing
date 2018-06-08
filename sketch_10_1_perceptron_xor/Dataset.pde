//data and training
float learningRate = 0.01;
class Dataset {
  
  float f(float x) {
    //y = mx + b
    return (0.89 * x) - 0.2;
  }
  
  private PVector[] data;
  //private float[] dataY;
  private int[] labels;
  int[] guesses;
  
  
  PVector get(int i ) {
    return data[i];
  }
  int getLabel(int i) {
    return labels[i];
  }
  
  int length() {
    return data.length;
  }
  
  float mapX(float x) {
    return map(x, -1, 1, 0, width);
  }
  
  float mapY(float y) {
    return map(y, -1, 1, height, 0);
  }
  
  

  Dataset(int points) {
    data = new PVector[points];
    //dataY = new float[points];
    labels = new int[points];
    for (int i = 0; i < data.length; i += 1) {
      data[i] = new PVector(random(-1,1), random(-1,1), 1);
    }
    

    for (int i = 0; i < data.length; i += 1) {
      if (f(data[i].x) > data[i].y) {
        labels[i] = 1;
      } else {
        labels[i] = -1;
      }
    }
  }
  
  float getX(int i) {
    return mapX(data[i].x);
  }
  
  float getY(int i) {
    return mapY(data[i].y);
  }


  void draw() {
    stroke(0);
    for (int i = 0; i < data.length; i += 1) {
      if (labels[i] == 1) {
        fill(255);
      } else {
        fill(0);
      }

      ellipse(getX(i), getY(i), 4, 4);
      
    }
  }
}
