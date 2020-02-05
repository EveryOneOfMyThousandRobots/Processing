NoiseManager vhsNoise = new NoiseManager();
void VHS(String name, PGraphics input, int frame) {
  input.loadPixels();

  float ypos = vhsNoise.snap(name + "_vhs_ypos", frame, 0, input.height, 5);
  
  for (int y = (int)ypos - 20; y < ypos + 20; y += 1) {
    float dist = (float)abs(ypos - y) / 20.0;

    if (random(1) > pow(1-dist,2)) continue;


    int yy = y;
    if (yy < 0 ) {
      yy = abs(yy);
      yy = yy % input.height;
      yy = input.height - yy;
    } else if (yy > input.height-1) {
      yy %= input.height;
    }


    int[] buffer = new int[input.width];
    for (int x = 0; x < input.width; x += 1) {
      buffer[x] = input.pixels[yy * input.width + x];
    }

    int xoffSet = vhsNoise.snap("vhs_xoff_"+yy, frame, 0, input.width, 10);
    for (int x = 0; x < input.width; x += 1) {
      int xx = (x + xoffSet) % input.width;

      int r = floor(random(100)) % 4;

      switch(r) {
      case 0:
        input.pixels[yy * input.width + xx] = buffer[x];
        break;
      case 1:
        input.pixels[yy * input.width + xx] = color(random(128, 255));
        break;
      case 2:
        break;
      default:
        input.pixels[yy * input.width + xx] = color(0);
        break;
      }
    }
  }



  input.updatePixels();
}
