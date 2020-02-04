class Connector implements Comparable<Connector> {
  CONN_TYPE type;
  Module m;
  final int id;
  {
    MODULE_ID += 1;
    id = MODULE_ID;
  }

  Connector(Module m, CONN_TYPE type) {
    this.m = m;
    this.type = type;
  }

  @Override
    boolean equals(Object o) {
    if (o instanceof Connector) {
      return id == ((Connector)o).id;
    } else {
      return false;
    }
  }

  int hashCode() {
    return Integer.hashCode(id);
  }

  int compareTo(Connector m) {
    return Integer.compare(id, m.id);
  }
}
