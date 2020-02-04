String corruptString(String s, float amount) { //<>// //<>//

  String r = "";
  float nx = s.hashCode() % 300;
  float ny = amount;
 // println(s);
  for (int p = 0; p < s.length(); p += 1) {
    float nz = ((float)p / (float)s.length());
    char c = s.charAt(p);
    if (pow(noise(nx, ny, nz),2) < amount) {
      int j = printables.lastIndexOf(c);
      int i = (j + floor(amount * noise(ny, nx, nz+5)*printables.length())) % printables.length();

      c = printables.charAt(i);
      //if (noise(nx,ny,nz+1) < 0.5) {
      //  c += floor(noise(nx,ny,nz+5) * 10);
      //} else {
      //  c -= floor(noise(nx,ny,nz+5) * 10);
      //}
    }
    r += str(c);
  }


  return r;
}
int roundChannel(int c, int num) {
  float CF = 255.0 / (float) num;

  float cc = c;
  cc = ceil(cc / CF);
  cc *= CF;

  return (int)cc;
}

void replaceColour(PGraphics input, int numColours, color A, color B0, color B1) {
  
  input.loadPixels();
  for (int i = 0; i < input.pixels.length; i += 1) {
    int rc = roundColour(input.pixels[i],numColours);
    
    if (rc == A) {
      input.pixels[i] = lerpColor(B0, B1, (float) i / (float) input.pixels.length);;
    }
    
  }
  input.updatePixels();
  
  
}

color getMostCommonColour(PGraphics input, int numColours) {
  HashMap<Integer, Integer> colours = new HashMap<Integer,Integer>();
  color c = color(0);
  
  input.loadPixels();
  for (int i = 0; i < input.pixels.length; i += 1) {
    
      int rc = roundColour(input.pixels[i],numColours);
      int cname = rc;
      if (colours.containsKey(cname)) {
        int count = colours.get(cname);
        count += 1;
        colours.put(cname,count);
        
      } else {
        colours.put(cname, 1);
      }
    
  }
  
  int most = -1;
  int imost = -1;
  
  for (int cname : colours.keySet()) {
    int m = colours.get(cname);
    if (most == -1 || m > imost) {
      most = cname;
      imost = m;
    }
  }
  
  c = most;
  
  
  
  return c;
}

int roundColour(int c, int num) {
  int nc = 0;


  float a = (c >> 24) & 0xff;
  float r = (c >> 16) & 0xff;
  float g = (c >> 8) & 0xff;
  float b = c & 0xff;

  int ia = roundChannel((int)a, num);
  int ir = roundChannel((int)r, num);
  int ig = roundChannel((int)g, num);
  int ib = roundChannel((int)b, num);


  nc = (ia << 24) + (ir << 16) + (ig << 8) + ib;

  return nc;
}

int overwriteChannel(int c, int nc, COL mode) {
  switch (mode) {
  case A:
    return  (c & 0x00ffffff) + (nc & 0xff000000);
  case R:
    return (c & 0xff00ffff) + (nc & 0x00ff0000);
  case G:
    return (c & 0xffff00ff) + (nc & 0x0000ff00);
  case B:
    return (c & 0xffffff00) + (nc & 0x000000ff);
  default:
    return nc;
  }
}

int getChannel(int c, COL mode) {
  switch (mode) {
  case A:
    return c & 0xff000000;
  case R:
    return c & 0xff0000;
  case G:
    return c & 0x00ff00;
  case B:
    return c & 0xff;
  case ALL:
    return c;
  default:
    return c;
  }
}

int getChannelByte(int c, COL mode) {
  switch (mode) {
  case R:
    return (c >> 16) & 0xff;
  case G:
    return (c >> 8) & 0xff;
  case B:
    return c & 0xff;
  case A:
    return (c >> 24) & 0xff;
  case ALL:
    return c;
  default:
    return c;
  }
}
