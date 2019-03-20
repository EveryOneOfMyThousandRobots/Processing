
Resource getRandomResource() {
  
  return resources.get(floor(random(resources.size())));
}
ArrayList<Resource> resources = new ArrayList<Resource>();
class Resource implements Comparable<Resource>{
  final String name;
  final int id;
  float goldExchangeRate;
  
  {
    //RESOURCE_ID += 1;
    id = getNextId("RESOURCE");
  }
  Resource() {
    this(getName(), random(1, 10));

  }
  Resource(String name, float exRate) {
    this.name = name;
    this.goldExchangeRate = exRate;
    resources.add(this);
  }

  boolean equals(Resource o) {
    return id == o.id;
  }

  int hashCode() {
    return id;
  }
  String toString() {
    return name;
  }
  
  int compareTo(Resource o) {
    return name.compareTo(o.name);
  }
}
