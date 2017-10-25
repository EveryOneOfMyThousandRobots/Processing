import java.util.TreeMap;
TreeMap<String, Integer> uniqueIds = new TreeMap<String, Integer>();
int getNextId(String idName) {
  idName = idName.toUpperCase().trim();

  int returnVal = 0;
  if (!uniqueIds.containsKey(idName)) {
    uniqueIds.put(idName, 1);
    returnVal = 1;
  } else {
    returnVal = uniqueIds.get(idName) + 1;
    uniqueIds.put(idName, returnVal);
  }

  return returnVal;
}