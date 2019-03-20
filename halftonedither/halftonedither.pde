PImage input;
PGraphics output;
final int res = 5;
void settings() {
  input = loadImage("lady.jpg");
  size(input.width*2,input.height);
  
}

void setup() {
  noLoop();
  output = createGraphics(input.width, input.height);
}


void draw() {
  background(0);
  image(input, 0, 0);
  calc();
  image(output, input.width, 0);
}

void calc() {
  output.beginDraw();
  output.background(255);
  output.fill(0);
  output.noStroke();
  input.loadPixels();
  for (int x = 0; x < input.width; x += res) {
    for (int y = 0; y < input.height; y += res){
      float sum = 0;
      int count = 0;
      for (int xx = 0; xx < res; xx += 1) {
        for (int yy = 0; yy < res; yy += 1) {
          int idx = (x + xx) + (y + yy) * input.width;
          if (idx >= input.pixels.length-1) continue;
          sum += brightness(input.get(x + xx, y + yy));
          count += 1;
          
        }
      }
      
      sum /= count;
      //sum = 255 - sum;
      sum = map(sum, 0, 255, res, 1);
      output.circle(x,y,sum);
      
      
    }
  }
  output.endDraw();
  
}
