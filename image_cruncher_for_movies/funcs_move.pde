  void move(NoiseManager nse, PGraphics input, COL mode, String name, int frame) {

    int x_start = 0;
    name += "_" + mode.toString();
    int x_snap = 50;
    int y_snap = 50;
    int y_start = nse.snap(name + "_YS", frame, 0, input.height, x_snap);


    int x_offset_odd = nse.snap(name + "_XOO", frame, 0, input.width, x_snap);
    int x_offset_even = nse.snap(name + "_XOE", frame, 0, input.width, x_snap);

    int y_offset_odd = nse.snap(name + "_YOO", frame, 0, input.height, y_snap);
    int y_offset_even = nse.snap(name + "_XOE", frame, 0, input.height, y_snap);
    int w = input.width;
    int h = 30 + nse.snap(name + "_H", frame, 0, input.height, y_snap);

    int[][] buffer = new int[input.width][h];

    input.loadPixels();

    for (int x = 0; x < w; x += 1) {
      int gx = (x + x_start) % input.width;
      for (int y = 0; y < h; y += 1) {
        int gy = (y + y_start) % input.height;
        int col = input.pixels[gy * input.width + gx];


        buffer[x][y] = col; //(col >> 16) & 0xff;
      }
    }

    for (int x = 0; x < w; x += 1) {

      int gx = 0;
      if (x % 2 == 0) {
        gx = (x + x_offset_even) % input.width;
      } else {
        gx = (x + x_offset_odd) % input.width;
      }

      for (int y = 0; y < h; y += 1) {
        int gy = 0;
        if (y % 2 == 0) {
          gy = (y + y_offset_even) % input.height;
        } else {
          gy = (y + y_offset_odd) % input.height;
        }


        int p = input.pixels[gy * input.width + gx]; 

        p = overwriteChannel(p, buffer[x][y], mode);

        input.pixels[gy * input.width + gx] = p;
      }
    }

    input.updatePixels();
  }
