int targetFPS = (int)(1e3/60.0);
long time_now;
long time_prev;
long time_delta = 0;
float deltaTime = 0;
float timer = 1000;
float displayDelta;
Incrementer<String> listA = new Incrementer<String>();
Incrementer<String> listB = new Incrementer<String>();

float accumTime = 0;
float accumCount = 0;

int x = 0, y= 10;
void setup() {
  size(300,300);
  frameRate(60);
  time_prev = System.nanoTime();
  displayDelta = 0;



  for (int i = 65; i < 67; i += 1) {
    listA.add(Character.toString((char)i));
    
  }
  for (int i = 65; i < 69; i += 1) {
    listB.add(Character.toString((char)i));
    
  }
  background(0);
}

class Incrementer<T> {
  private ArrayList<T> list = new ArrayList<T>();
  private int index = -1;
  private T current;
  public void add(T t) {
    list.add(t);
  }
  private boolean overflow = false;
  public boolean Overflow() {
    return overflow;
  }


  public T getNext() {
    if (list.size() == 0) {
      current  =null;
      return current;
    } else {
      index += 1;
      if (index >= list.size()) {
        index = 0;
        overflow = true;
      } else {
        overflow = false;
      }
      current = list.get(index);
      return current;
    }
  }

  public T getCurrent() {
    return current;
  }
}

int listAIndex = 0;
int listBIndex = 0;

static class StopWatch {
  private static long time;

  public static void start() {
    time = System.nanoTime();
  }

  public static long end() {
    return System.nanoTime() - time;
  }
}



void draw() {

  String A = listA.getCurrent();
  if (A == null) {
    A = listA.getNext();
  }
  String B = listB.getNext();
  if (listB.overflow) {
    A = listA.getNext();
  }
  x += 15;
  if (x > width-20) {
    x = 10;
    y += 10;
    if (y > height-20) {
      y = 10;
      x = 10;
      background(0);
    }
  }



  text(A  + B, x, y);
}
