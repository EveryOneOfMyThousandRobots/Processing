Vec3[] getXRM(float a) {

  Vec3[] arr = new Vec3[3];

  arr[0] = new Vec3(1, 0, 0);
  arr[1] = new Vec3(0, cos(a), -sin(a));
  arr[2] = new Vec3(0, sin(a), cos(a));


  return arr;
}

Vec3[] getYRM(float a) {

  Vec3[] arr = new Vec3[3];

  arr[0] = new Vec3(cos(a), 0, sin(a));
  arr[1] = new Vec3(0, 1, 0);
  arr[2] = new Vec3(-sin(a), 0, cos(a));


  return arr;
}

Vec3[] getZRM(float a) {

  Vec3[] arr = new Vec3[3];

  arr[0] = new Vec3(cos(a), -sin(a), 0);
  arr[1] = new Vec3(sin(a), cos(a), 0);
  arr[2] = new Vec3(0, 0, 1);


  return arr;
}
