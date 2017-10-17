
ArrayList<String> radix = new ArrayList<String>();

PImage img; 
PImage sorted;
int[] cols;
String[][] strings;// = new String[10][10000];
void settings() {
  img = loadImage("flower.jpg");

  size(img.width * 2, img.height, P2D);
}

void setup() {
  img.loadPixels();
  sorted = createImage(img.width, img.height, RGB);
  sorted.loadPixels();
  cols = new int[256];


  for (int i = 0; i < img.pixels.length; i += 1) {
    String b = "000"+str(floor(hue(img.pixels[i])));
    b = b.substring(b.length()-3, b.length());
    radix.add(b);
    //sorted.pixels[i] = img.pixels[i];
  }
  
  radix = sortInstance(radix,1);
  radix = sortInstance(radix,2);
  radix = sortInstance(radix,3);
  colorMode(HSB);
  for(int i = 0; i < radix.size(); i += 1) {
    sorted.pixels[i] = color(int(radix.get(i)), 255,255);
    
  }




  sorted.updatePixels();
}

ArrayList<String> sortInstance(ArrayList<String> a, int pos) {
  strings = new String[10][a.size()];
  int[] indices = new int[10];
  int ci = 0;
  for (String s : a) {
    //print(s + " ");
    
    int i = int(s.substring(s.length()-pos, s.length()- (pos-1)));

    int ii = indices[i];
    strings[i][ii] = s;
    indices[i] += 1;
  }
  a.clear();
  for (int i = 0; i < strings.length; i += 1) {
    for (int j = 0; j < strings[i].length; j += 1) {
      String s = strings[i][j];
      if (s == null) break;
      a.add(s);
    }
  }
  
  return a;
}

void draw() {
  image(img, 0, 0);
  image(sorted, img.width, 0);
}