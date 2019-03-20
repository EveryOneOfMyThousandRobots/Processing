

class Property extends HasId{
  final String name;
  Property () {
    name = getRandomName();
    //glo_properties.add(this);
  }
}
