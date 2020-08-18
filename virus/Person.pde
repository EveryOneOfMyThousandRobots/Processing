
class Person {
  int age;
  final int id;
  final int id_hash;
  {
    ID += 1;
    id = ID;
    id_hash = Integer.hashCode(id);
  }
  VIRUS_STATE vState = VIRUS_STATE.NONE;
  int infectionTimer = INFECTION_DAYS;
  Loc home;
  Loc work;
  Loc currentLoc = null;
  boolean socialDistancer = false;
  Person(Loc home, Loc work, Loc startingLoc, int startingAge) {
    this.home = home;
    this.work = work;
    currentLoc = startingLoc;
    currentLoc.enter(this);
    this.age = startingAge;
    socialDistancer = home.socialDist;
  }

  void gotoWork() {
    if (!socialDistancer) {
      currentLoc.leave(this);
      currentLoc = work;
      currentLoc.enter(this);
    }
  }

  void gotoHome() {
    currentLoc.leave(this);
    currentLoc = home;
    currentLoc.enter(this);
  }

  void gotoRandomBusiness() {
    if (!socialDistancer) {
      // if (random(1) > 0.1) {
      currentLoc.leave(this);
      currentLoc = getRandomBusiness();
      currentLoc.enter(this);
      //}
    }
  }


  int hashCode() {
    return id_hash;
  }

  boolean equals(Object o) {
    if (o instanceof Person) {
      Person p = (Person) o;

      if (p.id == id) {
        return true;
      }
    }
    return false;
  }
}
