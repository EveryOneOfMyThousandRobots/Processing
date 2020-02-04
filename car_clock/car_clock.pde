import java.time.LocalDateTime;



byte setBit(byte a, int pos) {
  a |= (1 << pos);

  return a;
}

Digit hour0;
Digit hour1;
Digit min0;
Digit min1;


void setup() {
  size(640, 360);
  float step = width / 5;


  hour0 = new Digit(step, height/2, 50, 100);
  hour1 = new Digit(step*2, height/2, 50, 100);
  min0 = new Digit(step*3, height/2, 50, 100);
  min1 = new Digit(step*4, height/2, 50, 100);

  LocalDateTime now = LocalDateTime.now();
  //for testing
  //set to hour for real
  h = now.getHour();
  //for testing
  m = now.getMinute();
  h0 = (h - (h%10)) / 10;
  h1 = (h%10);
  m0 = (m  - (m%10)) / 10;
  m1 = (m%10);
  
  hour0.value = hour0.nextValue = h0;
  hour1.value = hour1.nextValue = h1;
  min0.value = min0.nextValue = m0;
  min1.value = min1.nextValue = m1;
}

int h, m;
int h0, h1;
int m0, m1;

void draw() {
  background(0);
  LocalDateTime now = LocalDateTime.now();
  //for testing
  //set to hour for real
  h = now.getHour();
  //for testing
  m = now.getMinute();
  h0 = (h - (h%10)) / 10;
  h1 = (h%10);
  m0 = (m  - (m%10)) / 10;
  m1 = (m%10);

  hour0.setValue(h0);
  hour0.update();
  hour1.setValue(h1);
  hour1.update();
  min0.setValue(m0);
  min0.update();
  min1.setValue(m1);
  min1.update();

  hour0.draw();
  hour1.draw();
  min0.draw();
  min1.draw();
  text(h0 + " " + h1 + ":" + m0 + " " + m1, 10, 10);
}
