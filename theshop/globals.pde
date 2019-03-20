//strings

final String MIN_LIKE_AMOUNT = "min_Like_Amount";
final String LIKE_FACTOR = "like_Factor";
final String MUT_RATE = "mutation_Rate";
final String MUT_RANGE_LOW = "mutation_Range_Low";
final String MUT_RANGE_HIGH = "mutation_Range_High";
final String CHANCE_TO_BUY = "chance_to_buy";
final String VALUE_FACTOR = "value_factor";


//starting values
final int NUM_PRODUCTS = 20; //floor(random(50, 100));
final int NUM_PROPERTIES = 10; //floor(random(5, 10));
final int NUM_CUSTOMERS = 50;//floor(random(200,300));
final float ITEM_VALUE = 5;

//lists

ArrayList<Product> products = new ArrayList<Product>();
TreeMap<Product, Integer> purchased = new TreeMap<Product, Integer>();
ArrayList<Property> glo_properties = new ArrayList<Property>();
ArrayList<Customer> customers = new ArrayList<Customer>();


//comparators

import java.util.Comparator;
class CustomerComparator implements Comparator<Customer> {
  int compare(Customer a, Customer b) {
    return a.compareTo(b);
  }
  
}

CustomerComparator custComparator = new CustomerComparator();
