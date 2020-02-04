class NoiseManager {
  HashMap<String, PVector> noise = new HashMap<String, PVector>();
  float nfactor = 0.006;
  PVector getNoiseVec(String name) {
    if (noise.containsKey(name)) {
      return noise.get(name);
    } else {
      PVector v = new PVector();
      v.x = random(100);
      v.y = random(100);
      v.z = random(100);
      noise.put(name, v);
      return v;
    }
  }

  float getNoise(String name, int i) {
    float f = 0;
    PVector v = getNoiseVec(name);

    f = noise(v.x, v.y, v.z + ((float) i * nfactor));



    return f;
  }

  float getNoise(String name, int i, float min, float max) {
    float f = getNoise(name, i);
    return map(f, 0, 1, min, max);
  }

  float snapNoise(String name, int i, float min, float max, float snap) {
    float f = getNoise(name, i, min, max);
    float CF = (max-min) / snap;


    f = ceil(f / CF);
    f *= CF;
    return f;
  }

  int snap(String name, int i, int min, int max, int snap) {
    return (int)snapNoise(name, i, min, max, snap);
  }
}
