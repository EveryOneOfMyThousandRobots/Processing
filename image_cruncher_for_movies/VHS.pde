NoiseManager vhsNoise = new NoiseManager();
void VHS(String name, PGraphics input, int frame) {
  input.loadPixels();

  float ypos = vhsNoise.snap(name + "_vhs_ypos", frame, 0, input.height, 1);
  int h = vhsNoise.snap(name + "_vhs_height", frame, 0, 50, 10) + 10;
  
  float roff = vhsNoise.snap(name + "_vhs_r", frame, 0, input.width/16, 5);
  float goff = vhsNoise.snap(name + "_vhs_g", frame, 0, input.width/16, 5);
  float boff = vhsNoise.snap(name + "_vhs_b", frame, 0, input.width/16, 5);
  float aoff = vhsNoise.snap(name + "_vhs_a", frame, 0, input.width/16, 5);

  for (int y = (int)ypos - h; y < ypos + h; y += 1) {
    float dist = (float)abs(ypos - y) / (float)h;
    boolean doSomething = true;
    if (random(1) > pow(1-dist, 4)) {
      doSomething = false;
    }

    int xoff = floor((input.width/8) - ((input.width/8) * dist));
    float xo0 = 1.0 / sqrt(TAU);
    xo0 *= exp(- 0.5 * (dist));
    xoff = floor((input.width / 8) * xo0 + random(input.width/64));
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

    //int xoffSet = vhsNoise.snap("vhs_xoff_"+yy, frame, 0, input.width, 10);
    
    for (int x = 0; x < input.width; x += 1) {
      int xx = (x + xoff) % input.width;
      int xr = floor((x + xoff + roff) % input.width);
      int xg = floor((x + xoff + goff) % input.width);
      int xb = floor((x + xoff + boff) % input.width);
      int xa = floor((x + xoff + aoff) % input.width);

      int r = floor(random(100)) % 4;

      if (r == 0 && doSomething) {
         
        input.pixels[yy * input.width + xx] = color(random(128, 255));
        
      } else if (r == 1 && doSomething) {
        input.pixels[yy * input.width + xx] = color(0);
      } else {

        int ri = yy * input.width + xr;
        int gi = yy * input.width + xg;
        int bi = yy * input.width + xb;
        int ai = yy * input.width + xa;
        int rc = overwriteChannel(input.pixels[ri],buffer[x],COL.R);
        int gc = overwriteChannel(input.pixels[gi],buffer[x],COL.R);
        int bc = overwriteChannel(input.pixels[bi],buffer[x],COL.R);
        
        input.pixels[ri] = rc;
        input.pixels[gi] = gc;
        input.pixels[bi] = bc;
        
        int ac = buffer[x];
        input.pixels[ai] = ac;
      }
    }
  }



  input.updatePixels();
}
