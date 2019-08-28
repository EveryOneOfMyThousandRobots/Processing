import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class args extends PApplet {

 public void settings() {
   
   
 }
 
 public void setup() {
   
   noLoop();
 }
 
 public void draw() {
   background(0);
   fill(255);
   int y = 10;
   for (String s : args) {
     text(s, 10, y);
     y += 10;
   }
 }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "args" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
