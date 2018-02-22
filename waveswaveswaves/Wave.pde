class Wave {
  ArrayList<PVector> points = new ArrayList<PVector>();
  int d_step = 0;
  
  float freq;
  float amp;
  float interval;
  float seconds;
  float secWidth;
  PVector pos, dims;
  float timeNow, timeLast;
  float delta = 0;
  float x_step = 0;
  float div_length = 60;
  
  Wave(float freq, float amp, int seconds, float interval, float x, float y, float w, float h) {
    this.freq = freq;
    this.amp = amp;
    this.seconds = seconds;
    this.interval = interval;
    pos = new PVector(x,y);
    dims = new PVector(w,h);
    secWidth = dims.x / this.seconds;
    //println(secWidth);
    calcWave();
  }
  
  void calcWave() {
    points.clear();
    //float angle = 0;
    for (float x = 0; x < dims.x; x += 1) {
      //float a = f(x);//TWO_PI * (((x % secWidth) / secWidth * freq) % 1);
      //angle = (freq / secWidth) * interval;
      //angle = angle % TWO_PI;
      float y = f(x); //sin(a);
      points.add(new PVector(x,y));
    }
    
  }
  
  float f(float x) {
    return sin (TWO_PI *(((x % secWidth) / secWidth * freq)%1 ));
  }
  
  void draw() {
    timeNow = millis();
    delta = timeNow - timeLast;
    timeLast = timeNow;
    
    stroke(0);
    strokeWeight(3);
    fill(255);
    rect(pos.x, pos.y, dims.x, dims.y);
    strokeWeight(1);
    stroke(128);
    line(pos.x, pos.y + (dims.y / 2), pos.x + dims.x, pos.y + (dims.y / 2));
    for (int x = 0; x < seconds; x += 1) {
      line(pos.x + x * secWidth, pos.y, pos.x + x * secWidth, pos.y + dims.y);
    }
    noFill();
    stroke(0);
    strokeWeight(2);
    beginShape();
    for (PVector p : points) {
      vertex(pos.x + p.x, pos.y + (dims.y / 2) + (amp * p.y));
    }
    endShape();
    x_step += (secWidth / 1000.0) * delta;
    x_step = x_step % dims.x;
    float x_step2 = x_step +0.01;
    float yy = f(x_step);
    float yy2 = f(x_step2);
    
    
    float x1 = pos.x + x_step ;
    float y1 = pos.y + (dims.y / 2) + (yy * amp);
    float x2 = pos.x + x_step2;
    float y2 = pos.y + (dims.y / 2) + (yy2 * amp);
    PVector A = new PVector(x1,y1);
    PVector B = new PVector(x2,y2);
    //float x2 = pos.x + x_step;
    //float y2 = pos.y + (dims.y / 2) + (a.y + c.y * amp);
    //noStroke();
    //fill(255,0,0);
    //ellipse(x1,y1,6,6);
    //fill(0,255,0);
    //ellipse(x2,y2,6,6);
    
    float len = PVector.dist(A,B);
    PVector C = new PVector(0,0);
    
    C.x = B.x + (B.x - A.x) / len * div_length;
    C.y = B.y + (B.y - A.y) / len * div_length;
    PVector D = PVector.sub(C,A);
    D.mult(- 1 / D.mag());
    
    D.mult(div_length);
    stroke(0);
    line(A.x, A.y, C.x, C.y);
    line(A.x, A.y, A.x + D.x, A.y + D.y);
    
    
    //if (d_step < points.size()-2) {
    //  PVector a = points.get(d_step);
    //  PVector b = points.get(d_step + 1);
    //  PVector c = PVector.sub(b,a).normalize();
    //  c.mult(10);
    //  float x1 = pos.x + a.x ;
    //  float y1 = pos.y + (dims.y / 2) + (a.y * amp);
    //  float x2 = pos.x + a.x + c.x;
    //  float y2 = pos.y + (dims.y / 2) + (a.y + c.y * amp);
    //  //ellipse(x1,y1,4,4);
    //  line(x1,y1,x2,y2);
      
      
    //} else {
    //  d_step = -1;
    //}
    //d_step += 1;
    
  }
  
}