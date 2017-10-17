//final float XLOW_FROM = -2;
//final float XLOW_TO = -1;
//final float YLOW_FROM = -2;
//final float YLOW_TO = -1;

//final float XHI_FROM = -1;
//final float XHI_TO = 0;
//final float YHI_FROM = -1;
//final float YHI_TO = -0;

float xmin = -1;
float xmax = 1;
float ymin = -1;
float ymax = 1;

//float xmindir = 1;
//float xmaxdir = -1;
//float xinc = 0.0001;
//float ymindir = 1;
//float ymaxdir = -1;
//float yinc = 0.0001;


final int MAX_ITERATIONS = 50;
void setup() {
  size(600, 600);
}

void draw() {
  //xmin = map(mouseX, 0, width, -2,0);
  //xmax = map(mouseX, 0, width, 2,0);
  //ymin = map(mouseY, 0, height, -2, 0);
  //ymax = map(mouseY, 0, height, 2, 0);
  loadPixels();
  background(0);
  
  float w = 1;
  float h = (w * height) / width;
  float ca = -0.70176;
  float cb = -0.3842;
  
  //xmin = -(w/2);
  //ymin = -(h/2);
  //xmax = w;
  //ymin = h;
  for (int x = 0; x < width; x += 1) {
    
    for (int y = 0; y < height; y += 1) {
      int pix = x + y * width;

      float a = map(x, 0, width, xmin, xmax);  
      float b = map(y, 0, height, ymin, ymax);

      //float ca = a;
      //float cb = b;
      float n = 0;
      //float z = 0;



      while (n < MAX_ITERATIONS) {
        float aa = a * a;
        float bb = b * b;
        float twoab = 2.0 * a * b;
        a = aa - bb + ca;
        b = twoab + cb;
        

        if (abs(a + b) > 4) {
          break;
        }
        n += 1;
      }
      float bright = map(n, 0, 100, 0, 1);
      bright = map(sqrt(bright), 0, 1, 0, 255);
      if (n == MAX_ITERATIONS) {
        bright = 0;
      }

      pixels[pix] = color(bright);
    }
  }
  //xmin += (xinc * xmindir);
  //if (xmin <= XLOW_FROM) {
  //  xmindir *= -1;
  //} else if (xmin >= XLOW_TO) {
  //  xmindir *= -1;
  //}

  //xmax += (xinc * xmaxdir);
  //if (xmax <= XHI_FROM) {
  //  xmaxdir *= -1;
  //} else if (xmin >= XHI_TO) {
  //  xmaxdir *= -1;
  //}

  //ymin += (yinc * ymindir);
  //if (ymin <= YLOW_FROM) {
  //  ymindir *= -1;
  //} else if (ymin >= YLOW_TO) {
  //  ymindir *= -1;
  //}

  //ymax += (yinc * ymaxdir);
  //if (ymax <= YHI_FROM) {
  //  ymaxdir *= -1;
  //} else if (ymin >= YHI_TO) {
  //  ymaxdir *= -1;
  //}
  

  updatePixels();
  
  
}