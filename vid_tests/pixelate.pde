PGraphics pixelate(PGraphics input, int cellSize) {

  //input.beginDraw();
  input.loadPixels();
  for (int x = 0; x < input.width; x += cellSize) {
    for (int y = 0; y < input.height; y += cellSize) {
      float sumR = 0;
      float sumG = 0;
      float sumB = 0;
      float count = 0;
      for (int xx = 0; xx < cellSize; xx += 1) {
        for (int yy = 0; yy < cellSize; yy += 1) {

          int xp = x + xx;
          int yp = y + yy;
          if (xp > input.width - 1 || yp > input.height - 1) break;




          int index = yp * input.width + xp;
          int colour = input.pixels[index];

          sumR += (colour >> 16) & 255;
          sumG += (colour >> 8) & 255;
          sumB += (colour) & 255;
          count += 1;
        }
      }

      if (count > 0) {
        sumR /= count;
        sumG /= count;
        sumB /= count;
        input.noStroke();
        input.fill(color(sumR, sumG, sumB));
        input.rect(x, y, cellSize, cellSize);
      }
    }
  }
  //input.updatePixels();
  //input.endDraw();


  return input;
}
