 long time_now, delta_time, time_last;
 Animation anim;
 void setup() {
   size(300,300);
   anim = new Animation();
   
   PImage sheet = loadImage("sheet.png");
   for (int i = 0; i < sheet.width / 32; i += 1) {
     PImage img = createImage(32,32,ARGB);
     img.copy(sheet,32*i,0,32,32,0,0,32,32);
     anim.addFrame(img,83);
   }
   
   
   
   time_last = millis();
 }
 
 
 void draw() {
   time_now = millis();
   delta_time = time_now - time_last;
   time_last = time_now;
   
   background(255);
   image(anim.frames.get(0).img,0,0);
   image(anim.frames.get(1).img,32,0);
   image(anim.frames.get(2).img,64,0);
   anim.update(delta_time);
   anim.draw();
 }
 
 class Animation {
   ArrayList<Frame> frames = new ArrayList<Frame>();
   
   int frameIndex = 0;
   Frame frame = null;
   long timer = 0;
   
   void addFrame(PImage img, long time) {
     frames.add(new Frame(img,time));
   }
   
   
   void update(long deltaTime) {
     if (frame == null) {
       frame = frames.get(frameIndex);
       timer = frame.time;
     }
     
     timer -= deltaTime;
     
     if (timer <= 0) {
       frameIndex = (frameIndex + 1) % frames.size();
       frame = frames.get(frameIndex);
       timer = frame.time;
     }
     
   }
   
   void draw() {
     if (frame != null) {
       image(frame.img,width / 2, height /2 );
     }
   }
   
 }
 
 class Frame{
   PImage img;
   long time;
   Frame(PImage img, long time) {
     this.img = img;
     this.time = time;
   }
 }
