float ups = 2;
float time_now = 0;
float time_last = 0;
float delta = 0;
float delta_a = 0;
float delta_sum = 0;
int count = 0;


void setup() {
  size(400,400);
}

void draw() {
  background(0);
  fill(255);
  time_now = millis();
  
  delta = time_now - time_last;
  time_last = time_now;
  String output = "delta: " + nfc(delta, 2);
  output = addString(output, "time now", time_now);
  output = addString(output, "time last", time_last);
  
  
  delta_a = (delta / 1000.0) * ups;
  delta_sum += delta_a;
  if (delta_sum > 1) {
    delta_sum -= 1;
    count += 1;
  }
  
  output = addString(output, "delta sum", delta_sum);
  output = addString(output, "delta a", delta_a);
  output = addString(output, "count", count);
  
  text(output, 10, 10);
  
}

String addString(String append, String name, float v) {
  return addString(append, name, nfc(v,2));
}

String addString(String append, String name, String val) {
  return append + "\n" + name + ": " + val;
}
