ArrayList<File> files = new ArrayList<File>();
import java.util.Date;
String path = "R:\\System\\Basil\\Consignment\\PeteD\\";
void addFile(ArrayList<File> files, String folder) {
  if (files.size() > 50) return;
  File file = new File(folder);
  if (file.isDirectory()) {
    files.add(file);
    File[] sub = file.listFiles();
    if (sub == null) return;
    for (int i = 0; i < sub.length; i += 1) {
      addFile(files, sub[i].getAbsolutePath());
    }
  } else {
    files.add(file);
  }
}

PFont font;
int index = 0;
void setup() {
  size(400, 400);
  font = createFont("Consolas", 12);
  textFont(font);
  addFile(files, path);
  frameRate(4);


  //noLoop();
}


void draw() {
  background(0);
  fill(255);
  int x = 10;
  int y = 12;
  boolean screenReached = false;
  while (!screenReached) {
    for (int i = index; i < files.size(); i += 1) {
      text(files.get(i).getAbsolutePath(), x, y);
      y += 12;
      if (y > height) {
        screenReached = true;
        break;
      }
    }
    index = (index + 1) % files.size();
  }

  
}
