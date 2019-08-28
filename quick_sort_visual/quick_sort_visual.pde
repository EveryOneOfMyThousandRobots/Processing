int[] sortMe = getArray();
int lastIndex = -1;

int[] getArray() {
  int[] a = new int[floor(random(100,1000))];
  
  
  for (int i = 0; i < a.length; i += 1) {
    a[i] = floor(random(1,100));
  }
  
  return a;
  
  
}
void setup() {
  size(1000,400);
  quickSort(sortMe, 0, sortMe.length-1, 0);
  colorMode(HSB);
  frameRate(4);
}


void draw() {
  background(51);
  draw(sortMe);
  quickSort(sortMe, 0, sortMe.length-1, 0);
  LEVEL_LIMIT += 1;
}


void draw(int[] ar) {
  stroke(255);
  fill(255);
  int max = -1;
  for (int i : ar) {
    if (i > max) {
      max = i;
    }
    
  }
  
  float w = float(width) / float(ar.length);
  
  for (int i = 0; i < ar.length; i += 1) {
    int a = ar[i];
    
    color c = color(map(a,0,max,0,255), 255,255);
    float y = map(a, 0, max, height / 2, 0);
    float h = map(a, 0, max, 0, height / 2);
    float x = (w * i);
    stroke(c);
    fill(c);
    rect(x,y, w, h);
  }
  
}

int LEVEL_LIMIT = 2;

void quickSort(int[] ar, int start, int end, int level) {
  
  if (start >= end) return;// ar;
  
  lastIndex = partition(ar, start, end);
  if (level > LEVEL_LIMIT) return;
  
  quickSort(ar, start, lastIndex-1, level + 1);
  quickSort(ar, lastIndex+1,end, level + 1);
  
  
  
}


int partition(int[] ar, int start, int end) {
  int pivotIndex = start;
  int pivotValue = ar[end];
  
  for (int i = start; i < end; i += 1) {
    if (ar[i] < pivotValue) {
      swap(ar, i, pivotIndex); //<>//
      pivotIndex += 1;
    }
  }
  
  swap(ar, pivotIndex, end);
  
  return pivotIndex;
}

void swap(int[] ar, int indexA, int indexB) {
  int temp = ar[indexA];
  ar[indexA] = ar[indexB];
  ar[indexB] = temp;
  
}
