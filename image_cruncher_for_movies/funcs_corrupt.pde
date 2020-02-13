  void corruptDims(NoiseManager nse, PGraphics input, String name, int frame) {

    input.loadPixels();
    int offset = nse.snap(name + "_OFFSET_CPT", frame, 0, input.width/2, input.width / 16);
    //int yo = floor(nse.snapNoise(name + "_YO_CPT", frame, -4.0f, 4.0f, 1.0f));

    int offset_timer = nse.snap(name + "_OFFSET_TIMER", frame, input.pixels.length / 2, input.pixels.length, input.width) + input.width;
    int timer = 0;
    PGraphics ng = createGraphics(input.width, input.height);
    ng.beginDraw();
    ng.loadPixels();
    int offset_2 = nse.snap(name + "_OFFSET2_CPT", frame, 0, input.width/2, input.width / 16);
    for (int i = 0; i < input.pixels.length; i += 1) {
      timer += 1;

      if (timer >= offset_timer) {
        offset_2 = nse.snap(name + "_OFFSET2_CPT", i+frame, 0, input.width/2, input.width / 8);
        timer = 0;
      }

      int j = (i+offset+offset_2) % input.pixels.length;

      ng.pixels[i] = input.pixels[j];
    }
    //int nw = input.width + floor(random(-2,2));


    //for (int y = 0; y < ng.height; y += 1) {
    //  for (int x = 0; x < ng.width; x += 1) {
    //    int i = (y * nw + x) % input.pixels.length;

    //    ng.pixels[i] = input.pixels[y * ng.width + x];


    //  }
    //}
    ng.updatePixels();
    ng.endDraw();
    input.image(ng, 0, 0);
  }
