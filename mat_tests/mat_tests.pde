float[][] m = {
  {0,8,2,10},
  {12,4,14,6},
  {3,11,1,9},
  {15,7,13,5}
};

float[][] ma;
final int SIZE = 4;

PImage img; 
PGraphics imgPost;
void settings() {
  img = loadImage("burst.jpg");
  size(img.width*2, img.height);
  
}

void setup() {
  
  imgPost = createGraphics(img.width,img.height);
  ma = new float[SIZE][SIZE];
  float n = 1.0 / 16.0;
  for (int x = 0; x < SIZE; x += 1) {
    for (int y = 0; y < SIZE; y += 1) {
      
      ma[x][y] = m[x][y] * n;
      
    }
  }
  process();
  
 noLoop(); 
}


void process() {
  imgPost.beginDraw();
  imgPost.background(0);
  img.loadPixels();
  imgPost.loadPixels();
  for (int xm = 0; xm < img.width; xm += SIZE) {
    for (int ym = 0; ym < img.height; ym += SIZE) {
      
      for (int xx = 0; xx < SIZE; xx += 1) {
        for (int yy = 0; yy < SIZE; yy += 1) {
          int xp = xx + xm;
          int yp = yy + ym;
          int idx = yp * img.width + xp;
          if (xp > img.width - 1 || yp > img.height-1) {
            continue; 
          } else {
            int oc = img.pixels[idx];
            
            float r = (oc >> 16) & 255;
            float g = (oc >> 8) & 255;
            float b = (oc) & 255;
            r = rc(r);
            g = rc(g);
            b = rc(b);
            float m = ma[xx][yy] * 255;
            int nc = color(0);
            if (r > m) {
              nc += (int)r << 16;
            }
            
            if (g > m) {
              nc += (int)g << 8;
            }
            
            if (b > m) {
              nc += (int)b;
            }
            
            imgPost.pixels[idx] = nc;
              
            
            
          }
        }
      }
      
    }
    
  }
  imgPost.updatePixels();
  
  imgPost.endDraw();
}

void draw() {
  image(img,0,0);
  image(imgPost,img.width,0);
  
  
}

final float NUM_COLOURS = 4;
final float COL_FACTOR = 255.0 / NUM_COLOURS;
float rc(float c) {
  float cc = c;
  cc = ceil(cc / COL_FACTOR);
  cc *= COL_FACTOR;
  
  
  return cc;
  
}
