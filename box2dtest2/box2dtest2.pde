VerletPhysics2D physics;
ArrayList<VisibleBoxConstraint> boxes = new ArrayList<VisibleBoxConstraint>();
RectConstraint

void setup() {
  size(600,600, P2D);
  init();
}

void init() {
  physics = new VerletPhysics2D();
  
  physics.addBehavior(new GravityBehavior2D(Vec2D.Y_AXIS.scale(0.05)));
  
  VisibleBoxConstraint a = new VisibleBoxConstraint(new Vec2D(100,100), new Vec2D(200,100));
  
}



void draw() {
}