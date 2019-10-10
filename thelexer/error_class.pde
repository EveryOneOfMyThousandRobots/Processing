class Error {
  String name;
  String details;
  Error(String name, String details, Position start, Position end) {
    this(name, details);
    details += " pos: " + start.toString() + " to " + end.toString();
  }
  Error(String name, String details) {
    this.name = name;
    this.details = details;
  }
  
  String toString() {
    return name + ":" + details;
  }
}
