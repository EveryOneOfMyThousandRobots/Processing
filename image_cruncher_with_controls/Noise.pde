final int NOISE_DEPTH = 10;
class NoiseManager {
  HashMap<String, PVector[]> noise = new HashMap<String, PVector[]>();
  float nfactor = 0.006;
  PVector getNoiseVec(String name, int i) {
    i = i % NOISE_DEPTH;
    if (noise.containsKey(name)) {
      return noise.get(name)[i];
    } else {
      PVector[] vecs = new PVector[NOISE_DEPTH];
      for (int j = 0; j < NOISE_DEPTH; j += 1) {
        PVector v = new PVector();
        v.x = random(100);
        v.y = random(100);
        v.z = random(100);
        vecs[j] = v;
      }
      noise.put(name, vecs);

      return vecs[i];
    }
  }

  float getNoise(String name, int i) {
    float f = 0;

    for (int j = 0; j < NOISE_DEPTH; j += 1) {
      PVector v = getNoiseVec(name, j);

      f += noise(v.x, v.y, v.z + ((float) i * nfactor));
    }
    
    f %= 1;    


    return f;
  }

  float getNoise(String name, int i, float min, float max) {
    float f = getNoise(name, i);
    return map(f, 0, 1, min, max);
  }

  float snapNoise(String name, int i, float min, float max, float snap) {
    float f = getNoise(name, i, min, max);



    f = (int)(f / snap);
    f *= snap;

    if (f < min) f = min;
    if (f > max) f = max;
    return f;
  }

  int snap(String name, int i, int min, int max, int snap) {
    return (int)snapNoise(name, i, min, max, snap);
  }
}
