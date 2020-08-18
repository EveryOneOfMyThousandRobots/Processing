Loc getRandomBusiness() {
  return businesses.get(floor(random(businesses.size())));
}

Loc getRandomHome() {
  return homes.get(floor(random(homes.size())));
}

class Loc {
  final int id;
  final int id_hash;
  boolean socialDist = false;
  {
    ID += 1;
    id = ID;
    id_hash = Integer.hashCode(id);
  }
  ArrayList<Person> occupants = new ArrayList<Person>();

  void enter(Person p) {
    if (!occupants.contains(p)) {
      occupants.add(p);
    }
  }

  void leave(Person p) {
    if (occupants.contains(p)) {
      occupants.remove(p);
    }
  }

  int hashCode() {
    return id_hash;
  }

  boolean equals(Object o) {
    if (o instanceof Loc) {
      Loc p = (Loc) o;

      if (p.id == id) {
        return true;
      }
    }
    return false;
  }
}
