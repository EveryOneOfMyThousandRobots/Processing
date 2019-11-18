class Vect {
  float x, y;
  float ux, uy;
  float len;

  Vect (Vect a, Vect b) {
    this(a.x, a.y, b.x, b.y);
    
  }
  Vect(float sx, float sy, float tx, float ty) {
    this(tx - sx, ty - sy);
  }

  Vect (float x, float y) {
    this.x = x; 
    this.y = y;
    update();
  }

  void add(Vect o) {
    this.add(o.x, o.y);
  }

  void add(float x, float y) {
    this.x += x;
    this.y += y;
    update();
  }

  void subtract(Vect o) {
    this.add(-o.x, -o.y);
  }

  void multiply(float n) {
    this.x *= n;
    this.y *= n;
    update();
  }

  float dotProduct(Vect o) {
    float cos_theta = cos(getAngle(o));
    return this.len * o.len * cos_theta;
  }
  float getMultiplied(Vect o) {
    return (this.x * o.x)+ (this.y * o.y);
  }  

  float getAngle(Vect o) {
    //theta = acos(a * b / len a * len b)
    float result = 0;
    float a = getMultiplied(o);
    float b = this.len * o.len;
    result =acos(a/ b);
    return result;
  }

  void divide(float n) {
    if (n != 0) {
      this.x /= n;
      this.y /= n;
      update();
    }
  }



  void update() {
    float xx = (x * x);
    float yy = (y * y);

    len = sqrt(xx + yy);

    if (len == 0 ) {
      x = 0;
      y = 0;
      ux = uy = 0;
      len = 0;
    } else {
      ux = x / len;
      uy = y / len;
    }
  }
}

