final int WIN_WIDTH = 1000;
final int WIN_HEIGHT = 800;
final int PLAY_XPOS = 0;
final int PLAY_YPOS = 100;
final int PLAY_WIDTH = WIN_WIDTH - (PLAY_XPOS *2);
final int PLAY_HEIGHT = WIN_HEIGHT - PLAY_YPOS;
final int PLAY_OFFSCREEN = 20;
final int PLAYER_START_XPOS = PLAY_XPOS + (PLAY_WIDTH / 2);
final int PLAYER_START_YPOS = PLAY_YPOS + (PLAY_HEIGHT / 2);
int score = 0;
int highScore = 0;
boolean paused = true;
float multiplier = 1;
float multiplerFactor = 0.01;
int playerShotCoolDownTime = 10;
Rectangle PLAY_BOUNDS = new Rectangle(PLAY_XPOS, PLAY_YPOS, PLAY_WIDTH, PLAY_HEIGHT);
boolean debug = true;
long lastTime;
long delta;
float fDelta;
long fps;
long displayDelta, displayFPS;
long lastUpdateDebug = 0;
ArrayList<Entity> entities = new ArrayList<Entity>();
int enemyCount = 0, rockCount = 0;
final float ROCK_START_SIZE = 40;
ArrayList<Entity> removeMe = new ArrayList<Entity>();
Player player;