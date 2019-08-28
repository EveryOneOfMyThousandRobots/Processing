HashMap<Integer, FloorType> floors = new HashMap<Integer, FloorType>();
Tile[][] tiles;
final int TILE_WIDTH = 50;
final int TILE_HEIGHT = 50;
int TILES_ACROSS, TILES_DOWN;

final int FLOOR_TYPE_GRASS = 0;
final int FLOOR_TYPE_WATER = 1;
final int FLOOR_TYPE_ROCK = 2;
final int FLOOR_TYPE_MOUNTAIN = 3;
final int FLOOR_TYPE_HIGHEST = FLOOR_TYPE_MOUNTAIN; 

final float NOISE_FACTOR = 0.04;


final float WATER_LOW = 0;
final float WATER_HIGH = 0.2;
final float GRASS_LOW = WATER_HIGH;
final float GRASS_HIGH = 0.55;
final float ROCK_LOW = GRASS_HIGH;
final float ROCK_HIGH = 0.7;
final float MOUNTAIN_LOW = ROCK_HIGH;
final float MOUNTAIN_HIGH = 1;


boolean debug = true;
