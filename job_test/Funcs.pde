int ID = 0;
class HasId {
  public final int id;
  {
    ID += 1;
    id = ID;
  }

  int hashCode() {
    return id;
  }

  boolean equals(HasId o) {
    return o.id == id;
  }
}
