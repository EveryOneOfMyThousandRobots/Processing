import java.util.PriorityQueue;
import java.util.Map;
import java.util.TreeMap;
//import java.util.TreeMap.Entry;
import java.util.Set;
import java.util.Comparator;
//import java.util.Entry;

class ValueComparator implements Comparator<nPV> {
    Map<nPV, Float> base;

    public ValueComparator(Map<nPV, Float> base) {
        this.base = base;
    }
    
    

    // Note: this comparator imposes orderings that are inconsistent with
    // equals.
    public int compare(nPV a, nPV b) {
      return Float.compare(base.get(a), base.get(b));
      
        //if (base.get(a) >= base.get(b)) {
        //    return -1;
        //} else {
        //    return 1;
        //} // returning 0 would merge keys
    }
}
