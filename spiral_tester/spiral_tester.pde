
int sx, sy;
float n;
void setup() {
  size(400, 400);
  sx = width / 2;
  sy = height / 2;
  frameRate(10);
}


void draw() {
  n += 1;

  stroke(0);
  PVector p = spiral(n);
  
  point(sx + p.x, sy + p.y);
  

  //m = floor(sqrt((float)n));
  //if (m % 2.0 == 1) { //m is odd
  //  k = 0.5*(m-1);
  //} else if (m % 2 == 0 && n >= m * (m+1)) { //m is even and n >= (
  //  k = m/2.0;

  //} else {
  //  k = (m/2)-1;
  //}

  //String R = "";

  //String D = "";
  //for (int i = 0; i < (2*k+1); i += 1) {
  //  R += "R";
  //  D += "D";
  //}
  //String L = "";
  //String U = "";
  //for (int i = 0; i < (2*k+1); i += 1) {
  //  L += "L";
  //  U += "U";
  //}

  //println(R + D +"|" + L + U +"||" + " n=" + n + ", k=" +k + ", m="+m);
}


PVector spiral(float n) {
  PVector p = new PVector();


  float  k = ceil((sqrt(n)-1)/2);
  float t = 2 * k+1;
  float m = t*t;
  t = t-1;
  if (n >= m-t) {
    return p.set(k-(m-n), -k);
  } else {
    m = m - t;
  }

  if (n >= m-t) {
    return p.set(-k,-k+(m-n));
  } else {
    m = m - t;
  }

  if (n >= m-t) {
    return p.set(-k+(m-n),k);
  } else {
    return p.set(k,k-(m-n-t));
  }




  
}
