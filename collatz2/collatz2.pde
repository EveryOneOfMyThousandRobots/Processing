ArrayList<Integer> nums = new ArrayList<Integer>();

HashMap<Integer, PVector> pos = new HashMap<Integer, PVector>();

int num = -1;
void setup() {
  size(400, 400);
}
float angle = 0;
void draw() {

  background(51);
  switch (num) {
  case -1:
  case 1:
    num = floor(random(1, 2000));
    angle = -HALF_PI;
    break;
  default:
    int pNum = num;
    num = f(num);


    if (nums.contains(num)) {
      num = -1;
    } else {
      nums.add(num);
      if (num % 2 == 0) {
        angle -= random(0.01, 0.03);
      } else {
        angle += random(0.01, 0.03);
      }
      PVector p = new PVector();
      p.x 
      pos.put(num, p);
    }

    //println(pNum  + " -> " + num);
    

    break;
  }
}



int f(int n) {
  if (n % 2 == 0) {
    return n / 2;
  } else {
    return (n*3)+1;
  }
}
