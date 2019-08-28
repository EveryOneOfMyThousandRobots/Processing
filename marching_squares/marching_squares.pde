
import java.util.*;
int res = 5;
ArrayList<MapGen> maps;
int numberOfMaps = 10;
float numColours = 10;
int threshhold = 4;
void setup() {
  size(600, 600);
  
  fillMapArray();
  //noLoop();
}
void fillMapArray() {
  maps = new ArrayList<MapGen>();
  MapGen mapp = new MapGen("a", 45, width/res, height/res, 5, true);
  mapp.generate();
  maps.add(mapp);
  mapp = new MapGen("b", 45, width/res, height/res, 5, true);
  mapp.generate();
  maps.add(mapp);
  
  mapp = new MapGen("c", 40, width/res, height/res, 5, true);
  mapp.generate();
  maps.add(mapp);
  
  for (int i = 0; i < numberOfMaps; i += 1) {
    MapGen map = new MapGen("hello", 58 - i, width/res, height/res, 5, true);
    map.generate();
    maps.add(map);
  }
}


void draw() {
  background(0);

  for (int i = 0; i < maps.size(); i += 1) {

    maps.get(i).draw();
  }
  loadPixels();
  
  for (int x = 0; x < width; x += 1) {
    //println("\n" + x);
    for (int y = 0; y < height; y += 1) {
      //print(red(pixels[x + y * width]) + " ");
      pixels[x + y * width] = getColour(pixels[x + y * width]);
      //print(red(pixels[x + y * width]) + " ");
    }
  }
  updatePixels();
  
  fill(0,128);
  rect(0,0,width/2,height);
  int x = 10;
  int y = 10;
  fill(255);
  for (MapGen gm : maps) {
    text(gm.toString(),x,y); 
    y += 25;
  }
  //map.generate();
  //map.draw();
}

color getColour(color c) {
  
  float r = red(c);
  
  r = round(r / (255.0/numColours)) * 255.0/numColours;
  
  return color(r);
  
  
}



void mouseReleased() {
  if (mouseButton == LEFT) {
    fillMapArray();
  }
}
