ArrayList<Component> components = new ArrayList<Component>();
ArrayList<Item> items = new ArrayList<Item>();
ArrayList<String> manu = new ArrayList<String>();
ArrayList<Tbl> tables = new ArrayList<Tbl>();
ArrayList<Robot> robots = new ArrayList<Robot>();
final String alphabet = "ABCDEFGJKPQRSTXYZ";
final String nums = "0123456789abcs";

final int NUM_COMPONENTS = 30;
final int NUM_ROBOTS = 10;
//final int NUM_ITEMS      = 10;

final float COMPONENT_BIN_SIZE = 20;
final float IN_OUT_BIN_SIZE = 50;
final float WORKSPACE_SIZE = 50;

final long FIND_JOBS_EVERY_MILLIS = 100;

final int ITEM_MIN_COMPONENTS = 5;
final int ITEM_MAX_COMPONENTS = 15;


Incoming incoming;
Outgoing outgoing;
WorkSpace workspace;
