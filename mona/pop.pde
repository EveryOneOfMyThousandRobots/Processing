class Population {
  ArrayList<NewLisa> newlisas = new ArrayList<NewLisa>();
  TreeMap<String, Integer> popNames = new TreeMap<String, Integer>();
  float highestFitness = -100000000;
  float highestError = 0;


  Population(int size) {
    for (int i = 0; i < size; i += 1) {
      newlisas.add(new NewLisa());
    }
  }
  
  PImage bestLastGen;
  
  String toString() {
    String output = "";
    int i = 0;
    for (NewLisa nl : newlisas) {
      
      output += "\n" + i + ":\t" + nl.toString();
      i += 1;
    }
    
    return output;
  }

  void draw() {
    highestError = 0;
    popNames.clear();
    for (NewLisa nl : newlisas) {
      noStroke();
      fill(0);
      rect(imgx, imgy, imgw, imgh);
      nl.draw();
      nl.checkImage();
      if (nl.error > highestError) {
        highestError = nl.error;
      }
      if (!popNames.containsKey(nl.name)) {
        popNames.put(nl.name, 1);
      } else {
        int count = popNames.get(nl.name);
        count += 1;
        popNames.put(nl.name, count);
      }
    }
    
    int y = (height / 2) + 10;
    int x = 10;
    fill(255);
    for (String s : popNames.keySet()) {
      text(s + " : " + popNames.get(s), x, y);
      y += 10;
      if (y > height) {
        if (x > width / 2) {
          break;
        } else {
          x = (width / 2) + 10;
          y = (height / 2) + 10;
        }
      }
      
    }
  }

  NewLisa getPartner() {
    NewLisa n = null;
    int breakout = 0;

    while (breakout < 10000) {
      int r1 = floor(random(newlisas.size()));
      float r2 = random(1);
      n = newlisas.get(r1);
      if (r2 < n.fitness) {
        break;
      }
      breakout += 1;
    }

    return n;
  }

  void breed() {
    ArrayList<NewLisa> newPop = new ArrayList<NewLisa>();
    highestFitness = 0;
    for (int i = 0; i < newlisas.size(); i += 1) {
      NewLisa nl = newlisas.get(i);
      if (nl.fitness > highestFitness) {
        highestFitness = nl.fitness;
        bestLastGen = createImage(lisa.width, lisa.height, RGB);
        bestLastGen.copy(nl.img,0,0, nl.img.width, nl.img.height, 0, 0, bestLastGen.width, bestLastGen.height); 
      }
    }

    for (int i = 0; i < newlisas.size(); i += 1) {
      NewLisa nl = newlisas.get(i);
      nl.fitness /= highestFitness;
    }
    
    for (int i = 0; i < POPULATION; i += 1) {
      NewLisa p1 = getPartner();
      NewLisa p2 = getPartner();
      
      if (p1 != null && p2 != null) {
        NewLisa child = p1.cross(p2);
        newPop.add(child);
      } else {
        println("error");
        stop();
      }
    }
    
    //for (int i = 0; i < 5; i += 1) {
    //  newPop.add(new NewLisa());
    //}
    
    newlisas.clear();
    newlisas = newPop;
  }
}