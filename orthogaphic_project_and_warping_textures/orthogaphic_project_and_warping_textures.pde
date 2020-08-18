
//import java.util.TimeUnit;
final int FACE_FLOOR = 0;
final int FACE_NORTH = 1;
final int FACE_EAST = 2;
final int FACE_SOUTH = 3;
final int FACE_WEST = 4;
final int FACE_TOP = 5;

World world;
void setup() {
  world = new World(64, 64);
  size(400, 400, P2D);
  time_now = time_last = System.nanoTime();
  frameRate(30);
  //noLoop();
}
long time_now, time_last, time_delta;
float dt;
final float MS = pow(10,6);
void draw() {
  time_now = System.nanoTime();
  
  time_delta = time_now - time_last;
  dt = constrain(time_delta, 0, 0.15);
  
  
  time_last = time_now;
  background(0);
  // world.drawTextures(0,0,width,height);
  ArrayList<Quad> quads = new ArrayList<Quad>();
  
  takeInput();

  for (int y = 0; y < world.h; y += 1) {
    for (int x = 0; x < world.w; x += 1) {
      getFaceQuads(x, y, camAngle, camPitch, camZoom, camPos, quads);
    }
  }
  
  for (Quad quad : quads) {
    drawWarpedTex(quad.textureId,quad.points[0],quad.points[1],quad.points[2],quad.points[3]);
    
  }
  
  fill(255);
  text("" +
       "dt: " + dt +
      "\ndtime: " + time_delta +
      "\nAngle: " + camAngle +
      "\nPitch: " + camPitch +
      "\nZoom: " + camZoom +
      "\nposx: " + camPos.x +
      "\nposy: " + camPos.y, 10, 10);
      
}

void drawWarpedTex(int t, PVector p0, PVector p1, PVector p2, PVector p3) {
  beginShape();
  texture(world.textures[t]);
  vertex(p0.x, p0.y, 0, 0);
  vertex(p1.x, p1.y, 32,0);
  vertex(p2.x, p2.y, 32, 32);
  vertex(p3.x, p3.y, 0, 32);
  endShape();
}
