HashMap<String, Noiser> noisers = new HashMap<String, Noiser>();
final int NUM_COMPONENTS = 10;
Noiser noiseMake(String name) {
  
  if (noisers.containsKey(name)) {
    return noisers.get(name);
  } else {
    Noiser n = new Noiser(NUM_COMPONENTS);
    noisers.put(name, n);
    return n;
  }
}

Noiser noiseGet(String name) {
  if (noisers.containsKey(name)) {
    return noisers.get(name);
  } else {
    Noiser n = new Noiser(NUM_COMPONENTS);
    noisers.put(name, n);
    return n;
  }
}

void noiseUpdateAll() {
  for (String n : noisers.keySet()) {
    noisers.get(n).update();
  }
}

int noiseValueSnap(String name, float vFrom, float vTo, float snap) {
  float v = noiseValue(name,vFrom, vTo);
  
  v = floor(v / snap) * snap;
  
  
  return (int)v;
}

int noiseValueI(String name, float vFrom, float vTo) {
  return int(noiseValue(name,vFrom,vTo));
}

float noiseValue(String name, float vFrom, float vTo) {
  float v = noiseValue(name);
  return map(v, 0, 1, vFrom, vTo);
}


float noiseValue(String name) {
  if (noisers.containsKey(name)) {
    return noisers.get(name).v;
  } else {
    return 0;
  }
}
