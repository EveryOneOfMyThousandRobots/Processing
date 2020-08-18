class Shape {
  Vec3[] shell;
  Vec3[] current;

  float ax = QUARTER_PI, ay = HALF_PI, az = 0;
  float axi = 0.1;//random(QUARTER_PI);
  float ayi = 0.2;//random(QUARTER_PI);
  float azi = 0.3;//random(QUARTER_PI);
  float scale = 60;
  float res = 4;



  Shape() {
    shell = new Vec3[8];
    current=  new Vec3[8];
    float h = 0.5;
    shell[F_TL] = new Vec3(-h, -h, -h);
    shell[F_TR] = new Vec3(h, -h, -h);
    shell[F_BR] = new Vec3(h, h, -h);
    shell[F_BL] = new Vec3(-h, h, -h);

    shell[B_TL] = new Vec3(-h, -h, h);
    shell[B_TR] = new Vec3(h, -h, h);
    shell[B_BR] = new Vec3(h, h, h);
    shell[B_BL] = new Vec3(-h, h, h);
    setCurrent();
  }

  void setCurrent() {
    for (int i = 0; i < shell.length; i += 1) {
      current[i] = shell[i].copy();
    }
  }

  void update(float delta) {
    setCurrent();
    ax += axi * delta;
    ay += ayi * delta;
    az += azi * delta;
    rt();
    sc();
  }

  void sc() {
    for (int i = 0; i < current.length; i += 1) {
      current[i].x *= scale;
      current[i].y *= scale;
      current[i].z *= scale;
    }
  }

  void draw() {
    stroke(255);
    noFill();
    beginShape();
    for (float tx = 0; tx <= 1; tx += 1 / res) {
      PVector x0 = PVector.sub(current[F_TR], current[F_TL]);
      PVector xp = PVector.add(current[F_TL], PVector.mult(x0,tx));
      //pushMatrix();
      //translate(xp.x, xp.y, xp.z);
      //sphere(1);
      //popMatrix();
      //point(xp.x, xp.y, xp.z);

      for (float ty = 0; ty <= 1; ty += 1 / res) {
        PVector y0 = PVector.sub(current[F_BL], current[F_TL]);
        PVector yp = PVector.add(current[F_TL], PVector.mult(y0,ty));

        //pushMatrix();
        //translate(xp.x + yp.x, xp.y + yp.y, xp.z + yp.z);
        //sphere(1);
        //popMatrix();        
        //point(yp.x, yp.y, yp.z);
        //point(xp.x + yp.x, xp.y + yp.y, xp.z + yp.z);
        for (float tz = 0; tz <= 1; tz += 1 / res) {
          PVector z0 = PVector.sub(current[B_TL], current[F_TL]);
          PVector zp = PVector.add(current[B_TL], PVector.mult(z0, tz));
          vertex(xp.x + yp.x + zp.x, xp.y + yp.y + zp.y, xp.z + yp.z + zp.z);
          //pushMatrix();
          
          //translate(xp.x + yp.x + zp.x, xp.y + yp.y + zp.y, xp.z + yp.z + zp.z);
          //sphere(1);
          //popMatrix(); 
          //point(xp.x + yp.x + zp.x, xp.y + yp.y + zp.y, xp.z + yp.z + zp.z);
          //point(zp.x, zp.y, zp.z);
          // point(xp.x, yp.y, zp.z);
        }
      }
    }
    endShape();
    

    stroke(255, 128);
    beginShape();
    vertex(current[F_TL].x, current[F_TL].y, current[F_TL].z);
    vertex(current[F_TR].x, current[F_TR].y, current[F_TR].z);
    vertex(current[F_BR].x, current[F_BR].y, current[F_BR].z);
    vertex(current[F_BL].x, current[F_BL].y, current[F_BL].z);
    endShape(CLOSE);

    beginShape();
    vertex(current[B_TL].x, current[B_TL].y, current[B_TL].z);
    vertex(current[B_TR].x, current[B_TR].y, current[B_TR].z);
    vertex(current[B_BR].x, current[B_BR].y, current[B_BR].z);
    vertex(current[B_BL].x, current[B_BL].y, current[B_BL].z);
    endShape(CLOSE);

    beginShape();
    vertex(current[B_TL].x, current[B_TL].y, current[B_TL].z);
    vertex(current[B_TR].x, current[B_TR].y, current[B_TR].z);
    vertex(current[F_TR].x, current[F_TR].y, current[F_TR].z);
    vertex(current[F_TL].x, current[F_TL].y, current[F_TL].z);
    endShape(CLOSE);

    beginShape();
    vertex(current[B_BL].x, current[B_BL].y, current[B_BL].z);
    vertex(current[B_BR].x, current[B_BR].y, current[B_BR].z);
    vertex(current[F_BR].x, current[F_BR].y, current[F_BR].z);
    vertex(current[F_BL].x, current[F_BL].y, current[F_BL].z);
    endShape(CLOSE);
  }

  void rt() {


    for (int i = 0; i < current.length; i += 1) {
      current[i].rotateX(ax);
      current[i].rotateY(ay);
      current[i].rotateZ(az);
    }
  }
}
