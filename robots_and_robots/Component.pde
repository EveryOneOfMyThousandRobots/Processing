class Component extends UniqueId{

  final String name;
  final float value;
  
  boolean equals(Component o) {
    return o.id == id;
  }

  Component(String name) {
    super();
    this.name = name;
    value = random(0.01, 1);
  }
  
  Component () {
    super();
    name = getComponentName();
    value = random(0.01, 1);
  }
}
