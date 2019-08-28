//PImage starter;
ArrayList<SImage> images = new ArrayList<SImage>();
int imageIndex = 0;
String path;
String[] fileNames;
PFont font;
void setup() {
  size(1280, 1024);
  frameRate(1);
  //println(sketchPath());
  path = sketchPath() + "\\data";

  println(path);
  fileNames = listFileNames(path);
  printArray(fileNames);
  float counter = 0;
  float total = fileNames.length;
  for (String s : fileNames) {
    counter += 1;
    //images.add(new SImage(s, CHANNEL.RED));
    //images.add(new SImage(s, CHANNEL.GREEN));
    //images.add(new SImage(s, CHANNEL.BLUE));
    images.add(new SImage(s, CHANNEL.ALL));
    println(nfc((counter / total) * 100.0, 2) + "%");
  }
  font = createFont("Consolas", 12);
  textFont(font);

  //noLoop();
}



void draw() {
  //String fileName = fileNames[imageIndex];
  background(0);
  //PImage img = loadImage(path + "\\" + fileName);
  SImage s = images.get(imageIndex);
  s.draw();
  //s.output();
  imageIndex = (imageIndex + 1) % images.size();
 
  //} else {
  //  image(img, xoff, yoff);
  //}

  //if (frameCount % 5 == 0) {

  //}
  //init();

  //background(0);
  ////image(starter, 0, 0 );

  //for (Tile t : tiles) {
  //  t.draw();
  //}




  //  println("ALL   " + getStdi(starter, 0, 0, width, height, CHANNEL.ALL));
  //  println("RED   " + getStdi(starter, 0, 0, width, height, CHANNEL.RED));
  //  println("GREEN " + getStdi(starter, 0, 0, width, height, CHANNEL.GREEN));
  //  println("BLUE  " + getStdi(starter, 0, 0, width, height, CHANNEL.BLUE));
}
