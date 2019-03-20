//import java.util.HashMap;
UniqueId ids = new UniqueId();
class UniqueId {
  private HashMap<String, Integer> ids = new HashMap<String, Integer>(); 


  int getNextId(String idName) {
    String s = idName.toUpperCase();
    s = s.trim();
    int returnValue = -1;
    if (ids.containsKey(s)) {
      returnValue = ids.get(s);
      returnValue += 1;
      ids.put(s, returnValue);
    } else {
      returnValue = 1;
      ids.put(s, returnValue);
    }

    return returnValue;
  }

  String toString() {
    String output = "\nUniquIds:\n";
    for (String k : ids.keySet()) {
      output += k + " : " + ids.get(k) + "\n";
    }

    return output;
  }
}
