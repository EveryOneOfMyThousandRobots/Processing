int toInt(byte b) {
  return int(b) & 0xff;
}

void loadImageA(int i) {

  currentLabel = toInt(labelFile[8 + i]);
  
  loadedImage = createImage(rows, cols, RGB);
  loadedImage.loadPixels();
  if (i < numImages) {
    int fileOffset = 16 + (i * rows * cols);
    for (int y = 0; y < rows; y += 1) {
      int yPos = fileOffset + (y * rows);
      for (int x = 0; x < cols; x+= 1) {
        int index = yPos + x;// * cols;
        int pixel = toInt(imageFile[index]);
        loadedImage.set(x, y, color(pixel));
        //println(pixel);
      }
    }
  }
  loadedImage.updatePixels();
}

int toInt(byte[] b, int offset) {
  int i = 0;
  int b1 = toInt(b[offset]);
  int b2 = toInt(b[offset+1]);
  int b3 = toInt(b[offset+2]);
  int b4 = toInt(b[offset+3]);
  //println(b1,b2,b3,b4);

  i += b1 << 24;
  i += b2 << 16;
  i += b3 << 8;
  i += b4;


  return i;
}