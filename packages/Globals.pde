//imports
import java.awt.Rectangle;
import java.awt.geom.Area;
import java.awt.Polygon;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

//final members
final int WINDOW_WIDTH = 800;
final int WINDOW_HEIGHT = 800;
final float MAX_DIST = WINDOW_WIDTH / 6;
final float MIN_DIST = WINDOW_HEIGHT / 16;
final int NUM_CUST_NODES = 30;
final int NUM_SHOP_NODES = 3;
final int NUM_TRANSPORT_NODES = 50;
final int MAX_CARTONS = 100;
final float CARTON_ORBIT_RADIUS = 10;
final int NODE_LIMIT = 12;


final int TRUCK_WAIT_TIMER = 0;
final int TRUCK_PICKUP_WAIT = 20;
//members
float highestCost = 0;

//delta
long timeLast = 0;
float delta = 0;
float fps = 0;
long elapsed = 0;
long displayDelta = 0;
float displayFps = 0;

//lists
ArrayList<Carton> cartons = new ArrayList<Carton>();
ArrayList<Node> nodes = new ArrayList<Node>();
ArrayList<Node> customers = new ArrayList<Node>();
ArrayList<Node> shops = new ArrayList<Node>();
ArrayList<Node> transport = new ArrayList<Node>();
ArrayList<Truck> trucks = new ArrayList<Truck>();
ArrayList<Conn> connections = new ArrayList<Conn>();

//objects
QuadTree quad;
PathFinder testPath;

//ids
int NODE_ID = 0;
int TRUCK_ID  = 0;
