ArrayList<Resource> resources = new ArrayList<Resource>();

class Resource extends HasId implements Comparable<Resource> {
  final String name;
  float value;
  float baseValue;
  float valueRange;
  float a, ai;

  Resource() {
    this(random(0.1, 50));
  }

  Resource(float value) {
    name = getRandomName();
    this.value = value;
    baseValue = value;
    valueRange = value * 0.1;
    resources.add(this);
    a = 0;
    ai = radians(random(0.01, 0.1));
  }

  String toString() {
    return name;
  }

  int compareTo(Resource o) {
    return name.compareTo(o.name);
  }

  void update() {
    a += ai;
    a = a % TWO_PI;

    value = map(a, 0, TWO_PI, baseValue - valueRange, baseValue + valueRange);
  }
}

void makeResources() {
  for (int i = 0; i < STARTING_HIGH_RESOURCES; i += 1) {
    Resource r  = new Resource(random(10, 50));

    //println("new resource: " + r);
  }
  for (int i = 0; i < STARTING_LOW_RESOURCES; i += 1) {
    Resource r  = new Resource(random(0.1, 5));

    //println("new resource: " + r);
  }
  
  resources.sort(new SortResource());
}

class SortResource implements Comparator<Resource> {
  
  int compare(Resource a, Resource b) {
    return a.name.compareTo(b.name);
  }
  
}

//SortResource sortResource = 

Resource getRandomResource() {

  return resources.get(floor(random(resources.size())));
}
