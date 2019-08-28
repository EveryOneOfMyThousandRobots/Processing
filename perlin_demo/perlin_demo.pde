int outputSize;
float[] noiseSeed1D; 
float[] noise;
int octaves = 1;

void setup() {
  size(1024, 512);
  outputSize = width;
  noiseSeed1D = new float[outputSize];
  noise = new float[outputSize];


  for (int i = 0; i < noiseSeed1D.length; i += 1) {
    noiseSeed1D[i] = random(1);
  }

  perlin1D(outputSize, noiseSeed1D, octaves, noise);
}

void perlin1D(int count, float[] seed, int octaves, float[] output) {

  for (int x = 0; x < count; x += 1) {
    float sumNoise = 0f;
    float scale = 1.0f;
    float scaleAccumulate = 0;
    for (int o = 0; o < octaves; o += 1) {
      int pitch = count >> o;

      int sample1 = (x / pitch) * pitch;
      int sample2 = (sample1 + pitch) % count;

      float blend = (float)(x - sample1) / (float)pitch;
      float sample = (1f - blend) * seed[sample1] + blend * seed[sample2]; 
      sumNoise += sample * scale;
      scaleAccumulate += scale;
      scale /= 2.0f;
    }
    output[x] = sumNoise / scaleAccumulate;
  }
}

void draw() {
  background(0);
  PVector last = new PVector(0, height / 2);
  PVector p = new PVector(0,height/2);
  stroke(255);
  for(int x = 0; x < width; x += 1) {
    float f = noise[x];
    p.set(x,map(f,0,1,0,height/2));
    line(last.x, last.y, p.x, p.y);
    last.set(p);
    
    
  }
  
}


void keyPressed() {
  if (keyCode == ' ') {
    octaves = ((octaves + 1) % 8);
    if (octaves == 0) {
      octaves = 1;
    }
    
    perlin1D(outputSize, noiseSeed1D, octaves, noise);
    
  }
}
