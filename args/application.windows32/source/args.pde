 void settings() {
   
   
 }
 
 void setup() {
   size(400,400);
   noLoop();
 }
 
 void draw() {
   background(0);
   fill(255);
   int y = 10;
   for (String s : args) {
     text(s, 10, y);
     y += 10;
   }
 }
