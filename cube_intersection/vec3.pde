class Vec3 extends PVector {
  Vec3() { super(); }
  Vec3(float x, float y) { super(x, y); }
  Vec3(float x, float y, float z) { super(x, y, z); }
  Vec3(Vec3 v) { super(); set(v); }

  String toString() {
    return String.format("[ %+.2f, %+.2f, %+.2f ]",
      x, y, z);
  }
  
  Vec3 copy() {
    return new Vec3(this.x, this.y, this.z);
  }

  Vec3 rotate(float angle) {
    return rotateZ(angle);
  }

  Vec3 rotateX(float angle) {
    float cosa = cos(angle);
    float sina = sin(angle);
    float tempy = y;
    y = cosa * y - sina * z;
    z = cosa * z + sina * tempy;
    return this;
  }

  Vec3 rotateY(float angle) {
    float cosa = cos(angle);
    float sina = sin(angle);
    float tempz = z;
    z = cosa * z - sina * x;
    x = cosa * x + sina * tempz;
    return this;
  }

  Vec3 rotateZ(float angle) {
    float cosa = cos(angle);
    float sina = sin(angle);
    float tempx = x;
    x = cosa * x - sina * y;
    y = cosa * y + sina * tempx;
    return this;
  }
}
