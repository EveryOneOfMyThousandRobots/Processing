

class NewLisa {
  PImage img;

  ArrayList<Shape> shapes = new ArrayList<Shape>();
  float error = 0;
  float errorCount = 0;
  float fitness = 0;
  String name;
  DNA dna;
  {
    this.name = getNewName();
  }
  NewLisa(DNA dna) {
    this.dna = dna;
    createShapes();
  }
  NewLisa() {
    dna = new DNA();
    createShapes();
    //  img = createImage((int)imgw, (int)imgh, ARGB);
  }

  private void createShapes() {
    for (int i = 0; i < SHAPES_PER_LISA; i += 1) {
      shapes.add(new Shape(this, i));
    }
  }

  void mutate() {
    dna.mutate();
    for (Shape s : shapes) {
      s.set();
    }
  }

  void checkImage() {
    img = createImage((int)imgw, (int)imgh, RGB);
    errorCount = 0;
    error = 0;
    loadPixels();
    img.loadPixels();
    lisa.loadPixels();
    for (float x = 0; x < imgw; x += 1) {
      for (float y = 0; y < imgh; y += 1) {
        errorCount += 1;
        int guess = pixels[floor(x + imgw) + floor(y) * width];
        
        int correct = lisa.pixels[floor(x) + floor(y) * floor(imgw)];
        if (BRIGHTNESS_MODE) {
          float correct_brightnes = sqrt(map(brightness(correct), 0, 255, 0, 1));
          float guess_brightness =sqrt(map(brightness(guess), 0, 255, 0, 1));
          error += abs(guess_brightness - correct_brightnes);
        } else {
          float rc = sqrt(map(hue(correct), 0, 255, 0, 1));
          float gc = sqrt(map(saturation(correct), 0, 255, 0, 1));
          float bc = sqrt(map(brightness(correct), 0, 255, 0, 1));



          float rg = sqrt(map(hue(guess), 0, 255, 0, 1));
          float gg = sqrt(map(saturation(guess), 0, 255, 0, 1));
          float bg = sqrt(map(brightness(guess), 0, 255, 0, 1));


          //float rc = sqrt(map(red(correct), 0, 255, 0, 1));
          //float gc = sqrt(map(green(correct), 0, 255, 0, 1));
          //float bc = sqrt(map(blue(correct), 0, 255, 0, 1));



          //float rg = sqrt(map(red(guess), 0, 255, 0, 1));
          //float gg = sqrt(map(green(guess), 0, 255, 0, 1));
          //float bg = sqrt(map(blue(guess), 0, 255, 0, 1));



          //error += map((rg - rc) + (gg - gc) + (bg - bc), -1000, 1000, 0, 1);
          float thisError = abs((rg - rc) + (gg - gc) + (bg - bc)); 
          //float huediff = map(abs(rg - rc), 0, 1, 0,255);
          //float satdiff = map(abs(gg - gc), 0, 1, 0,255);
          //float brightdiff = map(abs(bg - bc), 0, 1, 0,255);
          error += thisError;
          img.set(floor(x), floor(y), guess);
        }
        //println(x + "," + y + " guess: " + guess + " actual: " + correct + " error " + error);
        //println("(" + rc + "," + gc + "," + bc +") (" + rg + "," + gg + "," + bg + ")");
      }
    }
    error /= errorCount;
    error = abs(error);
    error += 0.01;
    fitness = 1 / error;
    fitness = pow(fitness, 6);
    //  println(fitness);
    // println(error);
    img.updatePixels();
  }

  void setDNA() {
    for (Shape s : shapes) {
      s.set();
    }
  }

  NewLisa cross(NewLisa partner) {
    DNA child_dna = dna.cross(partner.dna); 
    NewLisa child = new NewLisa(child_dna);
    child.name = name;
    child.mutate();
    child.setDNA();
    //child.shapes.clear();

    //for (int i = 0; i < shapes.size(); i += 1) {
    //  child.shapes.add( shapes.get(i).cross(partner.shapes.get(i), child));
    //}

    return child;
  }



  void draw() {
    for (Shape shape : shapes) {
      shape.draw();
      //shape.mutate();
    }
  }

  String toString() {
    return "" + fitness;
  }
}

class Shape {
  float x, y, w, h;
  float hue, sat, bright, a;
  NewLisa parent;
  DNA dna;
  int shapeId;
  float blob_min, blob_max;

  Shape(NewLisa parent, int shapeId) {
    this.dna = parent.dna;
    this.parent = parent;
    this.shapeId = shapeId;
    set();
  }

  //Shape cross(NewLisa parent, int shapeId) {
  //  Shape child = new Shape(parent, shapeId);
  //  child.set();

  //  return child;
  //}

  void set() {
    blob_min = BLOB_MIN;// dna.get("blob_min", 0, BLOB_MAX);
    blob_max = BLOB_MAX; //dna.get("blob_min", blob_min, BLOB_MAX);
    x = dna.get(shapeId + "_x", imgx, imgx + imgw);
    y = dna.get(shapeId + "_y", imgy, imgy + imgh);
    w = dna.get(shapeId + "_width", blob_min, blob_max);
    h = dna.get(shapeId + "_height", blob_min, blob_max);
    hue = dna.get(shapeId + "_hue", 0, 255);
    sat = dna.get(shapeId + "_sat", 0, 255);
    bright = dna.get(shapeId + "_bright", 0, 255);
    a = dna.get(shapeId + "_alpha", 0, 255);
  }

  void draw() {
    noStroke();
    fill(color(hue, sat, bright, a));
    ellipse(x, y, w, h);
    //rect(x,y,w,h);
  }

  //void mutate() {

  //  set();
  //  //x = mutate(x, imgx, imgx+imgw);
  //  //y = mutate(y, imgy, imgy+imgh);
  //  //w = mutate(w, 0, 30);
  //  //y = mutate(y, 0, 30);
  //  //r = mutate(r, 0, 255);
  //  //g = mutate(g, 0, 255);
  //  //b = mutate(b, 0, 255);
  //  //a = mutate(a, 0, 255);
  //}

  //float mutate(float me, float min, float max) {
  //  if (random(1) <= MUTATION_RATE) {

  //    me = random(min, max);

  //    //while ( me >= max || me <= min) {
  //    //  me += parent.error * LEARNING_RATE;
  //    //}
  //    //if (me < min) {
  //    //  me = min + me;
  //    //}
  //    //if (me >= max) {
  //    //  me = min + (me % (max - min));
  //    //}
  //  }
  //  return me;
  //}
}