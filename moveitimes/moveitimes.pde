import com.hamoid.*;

import processing.video.*;
Movie movie;

void setup( ) {
  size(360,200);
  movie = new Movie(this, "001.mov");
  
  movie.loop();
}

void draw() {
  //tint(255,20);
  background(0);
  //image(movie, 0,0);
  PImage m = movie.copy();
  image(m,0,0);
}

void movieEvent(Movie m) {
  m.read();
}
