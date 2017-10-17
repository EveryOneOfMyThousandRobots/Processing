class Player {
  PVector pos, acc, vel;
  Ball ball;
  Goal goal;
  float coolDown = 0;
  Player(Ball ball, Goal goal) {
    this.ball = ball;
    this.goal = goal;
    pos = new PVector(random(0, width), random(0, height));
    acc = new PVector(0,0);
    vel = new PVector(0,0);
  }
  
  void findBall() {
    if (coolDown > 0) {
      coolDown -= 1;
      return;
    }
    acc = PVector.sub(ball.pos, this.pos);
    acc.normalize();
    acc.mult(0.1);
    
    if (PVector.dist(pos,ball.pos) < ball.radius) {
      //kick
      PVector toGoal = PVector.sub(goal.centre, ball.pos);
      toGoal.normalize();
     
      ball.applyForce(toGoal);
      vel.mult(-1);
      coolDown = 20;
    }
    
  }
  
  void update() {
    findBall();
    
    vel.add(acc);
    vel.mult(0.9);
    pos.add(vel);
    acc.mult(0);
  }
  
  void draw() {
    stroke(0);
    fill(0,255,255);
    ellipse(pos.x, pos.y, 20,20);
  }
}