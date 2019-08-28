File[] files;
PImage img;
DistortionMap m;
final float MAX_SIZE = 500;

void settings() {
  files = listFiles(sketchPath()+"\\data");
  println(sketchPath());
  printArray(files);
  int r = floor(random(files.length));
  img = loadImage(files[r].getAbsolutePath());
  int attempts = 0;
  while (img.width > MAX_SIZE || img.height > MAX_SIZE) {
    attempts += 1;
    if (attempts > 100) break;
    if (img.width >= img.height && img.width > MAX_SIZE) {
      float factor = img.width / MAX_SIZE;
      img.resize(floor(img.width / factor), floor(img.height / factor));
    } else if (img.height > img.width && img.height > MAX_SIZE) {
      float factor = img.height / MAX_SIZE;
      img.resize(floor(img.width / factor), floor(img.height / factor));
    }
  }
  size(img.width*2, img.height);
}
void setup() {
  m = new DistortionMap(img);
}


void draw() {
  m.generate();
  m.corrupt();
  image(img, 0, 0);
  image(m.output, img.width, 0);
}

File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    return null;
  }
}
