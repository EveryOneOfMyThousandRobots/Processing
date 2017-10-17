QuickSort qs;

void setup () {
 size(600,200);

 background(255);
 
 int[] a = getRandomArray(10,10, 0,10);
 
 qs = new QuickSort(a);



 
 
 
}

int[] getRandomArray(int min, int max, int rangeLow, int rangeHigh) {
  int[] a = new int[(int) random(min,max)];
  

  
  for (int i = 0; i < a.length; i += 1) {
    
    a[i] = (int) random(rangeLow,rangeHigh);
  }
  
  return a;
}

void draw() {
  qs.Step();
  qs.draw();
}

class QuickSort {
  float[] colours;
  float minColour;
  float maxColour;
  
  boolean doNextLeft = false;
  int nll;
  int nlr;
  boolean doNextRight = false;
  int nrr;
  int nrl;
  
  
  private int l = -100,r = -100;
  private int left, right;
  private int[] array;
  private int len;
  public int iterations = 0;
  int pivot = 0;
  
  QuickSort(int[] array) {
    this.array = array;
    len = array.length;
    colours = new float[len];
    minColour = array[0];
    maxColour = array[len - 1];
    left = 0;
    right = len - 1;
    
   
  }
  
  public void Step() {
    if (l == -100) {
     quickSort(left, right);
    } else {
      if (doNextLeft) {
        quickSort(nll, nlr);
      } 
      
      if (doNextRight) {
        quickSort(nrl, nrr);
      }
    }
    updateColours();
     
  }
  
  
  
  public String toString() {
    String returnValue = "len:" + len + "\titerations: " + iterations + "\tpivot: " + pivot + "\n\t";
    
    for (int i : array) {
      returnValue += " " + i;
    }
    
    
    
    return returnValue;
    
  }
  
  void updateColours() {
    for (int i = 0; i < len; i += 1) {
      colours[i] = map(array[i], minColour, maxColour, 0, 255);
    }
    
    
  }
  
  void draw() {
    int tileWidth = width / colours.length;
    float x = 0;
    float y = (height / 2) - (tileWidth / 2);
    for (int i = 0; i < colours.length; i += 1){
      x = tileWidth * i;
      fill(colours[i]);
      rect(x,y, tileWidth, tileWidth);
      
    }
  }
  
  private void quickSort(int left, int right) {
    println(this);
    l = left;
    r = right;
    
    pivot = array[l + (r-l) / 2];
    
    while (l <= r) {
      iterations += 1;
      while (array[l] < pivot) {
        l += 1;
      }
      
      while(array[r] > pivot) {
        r -= 1;
      }
      
      if (l <= r) {
        swap(l,r);
        l += 1;
        r -= 1;
      }
    }
    
    
    
    doNextLeft= false;
    doNextRight = false;
    if (left < r) {
      doNextLeft = true;
      nll = left;
      nlr = r;
      
     // quickSort(left, r);
      
    }
    
    if (l < right) {
      doNextRight = true;
      nrl = l;
      nrr = right;
      //quickSort(l, right);
    }
  }
  
  private void swap(int a, int b) {
    int temp = array[a];
    array[a] = array[b];
    array[b] = temp;
  }
  
  
  
  
}