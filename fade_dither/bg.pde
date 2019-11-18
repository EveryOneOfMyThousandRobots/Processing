Noiser Bg; 
void drawBG() {
  //img.beginDraw();
  img.background(0);
  img.loadPixels();
  color red = color(255, 0, 0);
  color yell = color(255, 255, 0);
  ox += (width / height);///width);
  oy += 1;///height);
  nza = TWO_PI * (currentFrame / TOTAL_FRAMES);
  
  for (int x = 0; x < width; x += 1) {
    //float xx = map((x+ox) % width, 0, width, 0, 1);

    for (int y = 0; y < height; y += 1) {
      //float yy = map((y+oy)%height, 0, height, 0, 1);
      nzx = (float(x)*0.01) + nzr * cos(nza);
      nzy = (float(y)*0.01) + nzr * sin(nza);
      color c = lerpColor(red, yell, noise(nzx, nzy, sin(nza)));
      img.pixels[y * width + x] = c;
    }
  }
  img.updatePixels();

 // img.textAlign(CENTER, CENTER);

  //img.fill(255);
  //img.textFont(font_front);
  //img.text("contrived\nand\ninsufferable", width / 2, height / 2);

  //img.endDraw();
  
  //img.beginDraw();
  //img.fill(0);
  //img.textFont(font_back);
  ////img.text("contrived\nand\ninsufferable", width / 2, height / 2);

  //img.fill(255);
  //img.textFont(font_front);
  //img.text("contrived\nand\ninsufferable", width / 2, height / 2);
 //img.endDraw();

}
