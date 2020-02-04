enum TYPE {
  OR, 
    AND, 
    NAND, 
    NOR, 
    XOR, 
    CLOCK, 
    LIGHT
}

enum CONN_TYPE {
  INPUT, OUTPUT;
}
int MODULE_ID = 0;


class Module implements Comparable<Module> {
  @Override
    boolean equals(Object o) {
    if (o instanceof Module) {
      return id == ((Module)o).id;
    } else {
      return false;
    }
  }

  int hashCode() {
    return Integer.hashCode(id);
  }

  int compareTo(Module m) {
    return Integer.compare(id, m.id);
  }


  final int id;
  {
    MODULE_ID += 1;
    id = MODULE_ID;
  }
  int numInputs;
  int numOutputs;
  TYPE type;
  PVector pos;
  boolean[] inputs;
  PVector[] inputPos;
  boolean[] outputs;
  PVector[] outputPos;
  int timer = 15;

  Module(float x, float y, TYPE type) {



    switch (type) {
    case OR:
    case NAND:
    case AND:
    case NOR:
    case XOR:
      this.type = type;
      numInputs = 2;
      numOutputs = 1;      
      break;
    case LIGHT:
      this.type = type;
      numInputs = 1;
      numOutputs = 0;
    case CLOCK:

      this.type = TYPE.CLOCK;
      numInputs = 0;
      numOutputs = 1;
    }
    pos = new PVector(x, y);
    if (numInputs > 0) {
      inputs = new boolean[numInputs];
      inputPos = new PVector[numInputs];
      for (int i = 0; i < numInputs; i += 1) {
        inputPos[i] = new PVector(getInputConnPosX(), getConnPosY(numInputs, i));
      }
    }

    if (numOutputs > 0) {
      outputs = new boolean[numOutputs];
      outputPos = new PVector[numOutputs];
      for (int i = 0; i < numOutputs; i += 1) {
        outputPos[i] = new PVector(getOutputConnPosX(), getConnPosY(numOutputs, i));
      }
    }
  }

  void update() {
    if (numInputs > 0) {
      for (int i = 0; i < numInputs; i += 1) {
        inputPos[i].set(getInputConnPosX(), getConnPosY(numInputs, i));
      }
    }

    if (numOutputs > 0) {
      for (int i = 0; i < numOutputs; i += 1) {
        outputPos[i].set(getOutputConnPosX(), getConnPosY(numOutputs, i));
      }
    }



    switch (type) {
    case OR : 
    case NAND : 
    case AND : 
    case NOR : 
    case XOR : 

      break; 
    case LIGHT : 

      break; 
    case CLOCK : 
      timer -= 1; 
      if (timer <= 0) {
        timer = 15; 
        outputs[0] = !outputs[0];
      }
    }
  }
  float getYStep(int n) {
    return (float) MODULE_HEIGHT / ((float)n+1);
  }


  float getConnPosY(int n, int i) {
    float y = 0; 
    float yStep = getYStep(n); 
    y = pos.y + yStep + (yStep * i) - (yStep / 4); 
    return y;
  }

  float getInputConnPosX() {
    return pos.x;
  }

  float getOutputConnPosX() {
    return pos.x + MODULE_WIDTH - (getYStep(numOutputs) / 2);
  }

  boolean isMouseOver(float mx, float my) {

    return (mx >= pos.x && mx < pos.x + MODULE_WIDTH && my >= pos.y && my < pos.y + MODULE_HEIGHT);
  }

  int getMouseOverInputIndex(float mx, float my) {

    int rv = -1; 
    if (numInputs > 0) {
      for (int i = 0; i < numInputs; i += 1) {
        float x = inputPos[i].x;  
        float y = inputPos[i].y;  

        if (mx >= x && mx < x + CONN_SIZE && my >= y && my < y + CONN_SIZE) {
          rv = i; 
          break;
        }
      }
    }

    return rv;
  }

  int getMouseOverOutputIndex(float mx, float my) {

    int rv = -1; 
    if (numOutputs > 0) {
      for (int i = 0; i < numOutputs; i += 1) {
        float x = outputPos[i].x;  
        float y = outputPos[i].y;  

        if (mx >= x && mx < x + CONN_SIZE && my >= y && my < y + CONN_SIZE) {
          rv = i; 
          break;
        }
      }
    }

    return rv;
  }



  void draw() {
    stroke(128); 
    fill(255); 
    rect(pos.x, pos.y, MODULE_WIDTH, MODULE_HEIGHT); 

    fill(0); 
    textAlign(CENTER, CENTER); 
    text(type.toString(), pos.x + MODULE_WIDTH / 2, pos.y + MODULE_HEIGHT / 2); 

    if (numInputs > 0) {
      //float step = getYStep(numInputs);
      for (int i = 0; i < numInputs; i += 1) {
        float y = getConnPosY(numInputs, i); 

        float x = getInputConnPosX(); 
        fill(255, 0, 0); 
        noStroke(); 
        rect(x, y, CONN_SIZE, CONN_SIZE);
      }
    }

    if (numOutputs > 0) {
      //float step = getYStep(numOutputs);
      for (int i = 0; i < numOutputs; i += 1) {
        boolean v = outputs[i]; 
        if (v) {
          fill(0, 255, 0);
        } else {
          fill(255, 0, 0);
        }
        float y = getConnPosY(numOutputs, i); 

        float x = getOutputConnPosX(); 

        rect(x, y, CONN_SIZE, CONN_SIZE);
      }
    }
  }
}
