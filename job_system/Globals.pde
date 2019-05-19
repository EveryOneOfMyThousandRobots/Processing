import java.util.Comparator;
import java.util.Collections;
import java.util.UUID;


//ResourceTypeManager resourceTypeManager = new ResourceTypeManager();
ResourceManager resources = new ResourceManager();
StructureManager structures = new StructureManager();
MaterialManager materials = new MaterialManager();
GUIManager gman = new GUIManager();

Map map;
JobManager jobs;

//lists
ArrayList<DrawMe> draw = new ArrayList<DrawMe>();
//ArrayList<Tree> trees = new ArrayList<Tree>();
//ArrayList<Chest> chests = new ArrayList<Chest>();
ArrayList<Robot> robots = new ArrayList<Robot>();


//ENUMS

enum GAME_STATE {
  PLAY, 
    OPTIONS_MENU, 
    BUILD_MENU, 
    PAUSE
}
