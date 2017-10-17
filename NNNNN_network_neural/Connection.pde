int CONNECTION_ID = 0;
class Connection {
  int id;
  Neuron a,b;
  boolean sending = false;
  PVector sender = null;
  float output = 0;
  
  float weight =0 ;
  
  Connection (Neuron from, Neuron to, float weight) {
    CONNECTION_ID += 1;
    id = CONNECTION_ID;
    this.weight = weight;
    this.a = from;
    this.b = to;
    sender = new PVector(0,0);
  }
  
  String toString() {
    return id + " from:" + a.id + " to:" + b.id + " sending:" + sending + " output:" + output + " weight:" + weight;
  }
  
  int hashCode() {
    return 1000 + (id * 31);
  }
  
  void draw() {
    stroke(0, 100);
    strokeWeight(1 + weight * 4);
    line(a.pos.x, a.pos.y, b.pos.x, b.pos.y);
    
    if (sending) {
      fill(0);
      strokeWeight(1);
      ellipse(sender.x, sender.y, 8,8);
    }
  }
  
  void feedForward(float val) {
    //println(id + " feedForward");
    sending = true;
    sender.set(a.pos);
    output = val*weight;
    
  }
  
  void update() {
    if (sending) {
      //println(id + " sender: " + sender + " b.pos: " + b.pos);
      sender.x = lerp(sender.x, b.pos.x, 0.1);
      sender.y = lerp(sender.y, b.pos.y, 0.1);
      
      float dist = PVector.dist(sender, b.pos);
      //println(id + " dist " + dist + " sender: " + sender + " b.pos: " + b.pos);
      if (dist < 2) { //b.radius) {
        b.feedForward(output);
        sending = false;
      }
    }
  }
}