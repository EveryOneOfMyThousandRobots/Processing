float[] getImageArray(PImage img) {
  
  img.loadPixels();
  float[] a = new float[img.width * img.height];
  for (int y = 0; y < img.height; y += 1){
    for (int x = 0; x < img.width; x += 1) {
      a[x + y * img.width] = map(brightness(img.get(x,y)), 0, 255, -1, 1);
    }
  }
  
  return a;
}