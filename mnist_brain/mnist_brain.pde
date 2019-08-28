
ArrayList<byte[][]> images;

int fromBytes(byte[] bytes,int start) {
  int x = 0;
  x += bytes[start] << 24;
  x += bytes[start+1] << 16;
  x += bytes[start+2] << 8;
  x += bytes[start+3];
  
  return x;
}
int w = 0, h = 0;
void setup() {
  size(280,280);
  byte[] imageBytes = loadBytes("images.bytes");
  int magicNumber = fromBytes(imageBytes,0);
  int numImages = fromBytes(imageBytes, 0x04);
  
  w = fromBytes(imageBytes,0x08);
  h = fromBytes(imageBytes,0x0c);
  println(w + "," + h);
  
  images = new ArrayList<byte[][]>();
  for(int filePos = 0x10; filePos < imageBytes.length; filePos += (w * h)) {
    byte[][] img1 = new byte[w][h];
    for(int x = 0; x < w; x += 1) {
      for(int y = 0; y < h; y += 1) {
        img1[x][y] = imageBytes[filePos + (y * 28 + x)];
      }
    }
    images.add(img1);
  }
  background(0);
}
int imageIndex = 0;
int posX = 0;
int posY = 0;
void draw() {
  //background(0);
  byte[][] s = images.get(imageIndex);
  
  PImage img = createImage(28,28, RGB);
  
  img.loadPixels();
  for (int x = 0; x < w; x += 1) {
    for(int y = 0; y < h; y += 1) {
      img.pixels[y * w + x] = color(s[x][y]);
    }
  }
  image(img,posX,posY);
  posX += w;
  if (posX > width-1) {
    posX = 0;
    posY += h;
    if (posY > height-1) {
      posY = 0;
    }
  }
  
  
  imageIndex += 1;
  if (imageIndex > images.size()-1) {
    imageIndex = 0;
  }
  
}
