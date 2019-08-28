PImage crunch(PImage img) {
  img.loadPixels();
  PImage output = img.copy();
  int[] pxls = new int[img.pixels.length];



  //int iterations = NUM_ITERATIONS;
  arrayCopy(img.pixels, pxls);


  //-----------------------drip------------------------
  for (int j = 0; j < NUM_ITERATIONS; j += 1) {
    if (!go()) continue;


    for (int s = 0; s < NUM_SWIPES; s += 1) {
      if (!go()) continue;

      final int rndm = getRandomChoice();
      int x1 = floor(random(img.width));
      int y1 = floor(random(img.height));

      int x2 = floor(random(x1+1, x1+SWIPE_WIDTH));
      int y2 = floor(random(y1+1, y1+SWIPE_LENGTH));

      int xStart = x1;
      int xEnd   = min(x2, img.width-1);

      int yStart = y1;
      int yEnd   = min(y2, img.height-1);

      int yStep = floor(random(1, 4));
      int xStep = floor(random(1, 4));

      int[] pa = new int[abs(xStart-xEnd)];
      //final float cf = 1.0 - (float(abs(yStart - yEnd)) / float(SWIPE_LENGTH));

      int index = 0;
      for (int x = xStart; x < xEnd; x += 1) {
        pa[index] = pxls[x + yStart * img.width];
        index+=1;
      }



      for (int y = yStart+1; y < yEnd; y += yStep) {
        index = 0;
        float percent = 1.0 - (float)((float(y) - float(yStart)) / (float(yEnd)-float(yStart)));
        //percent *= 0.5;
        for (int x = xStart; x < xEnd; x += xStep) {
          pxls[x + y * img.width] = getCAvg(rndm, pxls[x + y * img.width], pa[index], percent);
          index += 1;
        }
      }


      //printArray(pa);
    }

    //-----------------------swipe------------------------
    for (int s = 0; s < NUM_SWIPES; s += 1) {
      if (!go()) continue;
      final int rndm = getRandomChoice();
      int x1 = floor(random(img.width));
      int y1 = floor(random(img.height));

      int x2 = floor(random(x1+1, x1+SWIPE_LENGTH));
      int y2 = floor(random(y1+1, y1+SWIPE_WIDTH));

      int xStart = x1;
      int xEnd   = min(x2, img.width-1);

      int yStart = y1;
      int yEnd   = min(y2, img.height-1);
      int yStep = floor(random(1, 4));
      int xStep = floor(random(1, 4));

      int[] pa = new int[abs(yStart-yEnd)];
      //final float cf = 1.0 - (float(abs(yStart - yEnd)) / float(SWIPE_LENGTH));

      int index = 0;
      for (int y = yStart; y < yEnd; y += 1) {
        pa[index] = pxls[xStart + y * img.width];
        index+=1;
      }
      for (int x = xStart; x < xEnd; x += xStep) {
        float percent = 1.0 - (float)((float(x) - float(xStart)) / (float(xEnd)-float(xStart)));
        //percent *= 0.5;
        index = 0;
        for (int y = yStart+1; y < yEnd; y += yStep) {  
          pxls[x + y * img.width] = getCAvg(rndm, pxls[x + y * img.width], pa[index], percent);
          index += 1;
        }
      }


      //printArray(pa);
    }


    for (int s = 0; s < 1; s += 1) {
      if (!go()) continue;
      final int rndm = getRandomChoice();
      int yStart = floor(random(img.height));
      int yEnd = constrain(floor(random(yStart+1, yStart+CHUNK_HEIGHT)),yStart+1,img.height-1);
      int size = yEnd - yStart;
      int xoff = floor(random(img.width)*0.5);
      int[][] pa = new int[img.width][size];
      for (int yy = 0; yy < size; yy += 1) {
        for (int x = 0; x < img.width; x += 1) {
          int y = yy + yStart;
          int i = idx(x, y, img.width);
          pa[x][yy] = pxls[i];
        }
      }
      for (int y = yStart; y < yEnd; y += 1) {
        for (int x = 0; x < width; x += 1) {
          color c = pa[(x + xoff)%pa.length][y-yStart];
          int i = idx(x, y, img.width);
          pxls[i] = getC(rndm, pxls[i], c);
        }
      }
    }

    for (int s = 0; s < NUM_ITERATIONS; s += 1) {
      if (!go()) continue;
      int start = floor(random(pxls.length));
      final int rndm = getRandomChoice();
      int stopAt = floor(random(start, pxls.length-1));
      color c = pxls[start];
      int step = floor(random(1, 5));
      for (int i = start; i < stopAt; i += step) {

        if (i + step > pxls.length-1) continue;
        pxls[i] = getC(rndm, pxls[i], pxls[i+1]);
      }
      pxls[stopAt] = getC(rndm, pxls[stopAt], c);

      //iterations -= 1;
    }
    //iterations = NUM_ITERATIONS;
    for (int s = 0; s < NUM_ITERATIONS; s += 1) {
      if (!go()) continue;
      int start = floor(random(pxls.length));
      final int rndm = getRandomChoice();
      int stopAt = floor(random(0, start-1));
      color c = pxls[start];
      int step = floor(random(1, 5));
      for (int i = start; i >= stopAt; i -= step) {

        if (i - step < 0) continue;
        pxls[i] = getC(rndm, pxls[i], pxls[i-1]);
      }
      pxls[stopAt] = getC(rndm, pxls[stopAt], c);

      //iterations -= 1;
    }
  }
  output.loadPixels();
  for (int i = 0; i < pxls.length; i += 1) {
    output.pixels[i] = pxls[i];
  }
  output.updatePixels();
  clicked = false;
  return output;
}
