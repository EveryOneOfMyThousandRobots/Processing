import java.text.SimpleDateFormat;
import java.util.Date;
import java.lang.Runtime;
class Movie {
  ArrayList<String> files = new ArrayList<String>();
  ArrayList<FrameSet> sets = new ArrayList<FrameSet>();
  PImage[] frames;
  final int lenFrames;
  final int FPS;
  final int lenSeconds;
  String outputFolder;
  final int TARGET_WIDTH, TARGET_HEIGHT;
  boolean saveoutput = false;

  int processFrameIndex = -1;
  int frameSetIndex = -1;
  String state = "";
  String nextState = "BEGIN";

  int framesRemaining = -1;
  //timing
  long time_now = getTime();
  long time_last = time_now;
  long time_delta;
  int f_index = 0;
  float frame_timer = 0;

  void update() {

    time_now = getTime();
    time_delta = time_now - time_last;
    time_last = time_now;



    switch(state) {
    case "BEGIN":
      nextState = "MAKE_FOLDER";
      break;
    case "MAKE_FOLDER":
      makeOutputFolder();
      nextState = "MAKE_FRAMES_BEGIN";
    case "MAKE_FRAMES_BEGIN":
      nextState = "MAKE_FRAMES_STEP";
      framesRemaining = lenFrames;
      break;
    case "MAKE_FRAMES_STEP":
      makeFramesStep();
      if (framesRemaining == 0) {
        nextState = "MAKE_FRAMES_FINISH";
      }
      break;
    case "MAKE_FRAMES_FINISH":
      nextState = "MAKE_SETS_BEGIN";
      break;
    case "MAKE_SETS_BEGIN":
      frameSetIndex = -1;
      nextState = "MAKE_SETS_STEP";
      break;
    case "MAKE_SETS_STEP":

      frameSetIndex += 1;

      nextState = "MAKE_SET_FRAMES_BEGIN";
      if (frameSetIndex > sets.size()-1) {
        nextState = "MAKE_SETS_FINISH";
      }
      break;
    case "MAKE_SETS_FINISH":
      nextState = "SAVE_BEGIN";
      break;
    case "MAKE_SET_FRAMES_BEGIN":
      processFrameIndex = -1;
      
    
      nextState = "MAKE_SET_FRAMES_STEP";
      
      break;
    case "MAKE_SET_FRAMES_STEP":
      processFrameIndex += 1;
      FrameSet set = sets.get(frameSetIndex);
      
      set.generateOneFrame(processFrameIndex);
      
      if (processFrameIndex >= set.numFrames-1) {
        nextState = "MAKE_SET_FRAMES_FINISH";
      }
      
      break;
    case "MAKE_SET_FRAMES_FINISH":
      nextState = "MAKE_SETS_STEP"; 
      break;
    case "SAVE_BEGIN":
      processFrameIndex = -1;
      nextState = "SAVE_STEP";
      break;
    case "SAVE_STEP":
      processFrameIndex += 1;
      saveOutput();

      if (processFrameIndex >= frames.length-1) {
        nextState = "SAVE_FINISH";
      }


      break;
    case "SAVE_FINISH":
      convertOutput();
      nextState = "DISPLAY_BEGIN";

      break;
    case "DISPLAY_BEGIN":
      processFrameIndex = -1;
      nextState = "DISPLAY_STEP";
      break;
    case "DISPLAY_STEP":
      frame_timer += time_delta;

      if (frame_timer > 1000.0 / (float)FPS) {
        processFrameIndex += 1;
        frame_timer = 0;
      }

      if (processFrameIndex >= frames.length-1) {
        nextState = "DISPLAY_BEGIN";
      }    
      break;
    case "DISPLAY_FINISH":
      break;
    default:
      break;
    }

    state = nextState;
  }

  void draw() {
    if (state.equals("DISPLAY_STEP")) {
      if (processFrameIndex >= 0 && processFrameIndex <= frames.length - 1) {
        println(frames.length);
        image(frames[processFrameIndex], 0, 0, width, height);
      }
    } 

    fill(255);
    noStroke();
    text("STATE:" + state + "\n" + 
      "frameIndex:" + processFrameIndex + "\n" +
      "setIndex:" + frameSetIndex + "\n" +
      "remaining:" + framesRemaining

      , 10, 10);
  }

  //void makeSet() {
  //  FrameSet set = sets.get(frameSetIndex);
  //  if (set != null) {
  //    set.generate();
  //  }
  //}

  void makeFramesStep() {
    float totalFrames = lenFrames;
    float frame = (totalFrames - framesRemaining);

    float t = 1 - pow(frame / totalFrames, 3);
    int ff = ceil(2.0 + ((float)FPS * t));

    if (ff > framesRemaining) {
      ff = framesRemaining;
      framesRemaining = 0;
    } else {
      framesRemaining -= ff;
    }

    int r = floor(random(files.size()));
    String s = files.get(r);
    files.remove(r);
    sets.add(new FrameSet(this, s, ff, (int)frame));
  }



  Movie(int FPS, int lenSeconds, int targetWidth, int targetHeight, boolean saveoutput) {
    this.saveoutput = saveoutput;
    TARGET_WIDTH = targetWidth;
    TARGET_HEIGHT= targetHeight;
    this.FPS = FPS;
    this.lenSeconds = lenSeconds;
    this.lenFrames = FPS * lenSeconds;
    frames = new PImage[this.lenFrames];
    TEXT_Y = ibmFont.getSize()+ (targetHeight / 6);

    String path = "C:\\Users\\sam.PROPER\\Pictures\\Movie stills";
    File[] fls = (new File(path)).listFiles();
    for (File f : fls) {

      if (f.isFile()) {
        String p1 =f.getAbsolutePath().toLowerCase();
        String p = f.getAbsolutePath();
        if (p1.endsWith(".jpg") || p1.endsWith(".jpeg") || p1.endsWith(".png")) {
          files.add(p);
        }
      }
    }
  }

  void makeOutputFolder() {
    if (saveoutput) {
      SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmssSSS");
      String dt = sdf.format(new Date());
      println(dt);
      outputFolder = sketchPath() + "\\data\\" + dt;
      File f = new File(outputFolder);
      f.mkdir();
    }
  }

  void saveOutput() {
    if (saveoutput) {
      processFrameIndex += 1;


      PImage img = frames[processFrameIndex];
      String s = "00000" + processFrameIndex;
      s = s.substring(s.length()-5);
      img.save(outputFolder + "\\img" + s +".jpg");
    }
  }

  void convertOutput() {
    if (saveoutput) {
      try {
        String c = "cmd /c ffmpeg -framerate " + FPS + " -i img%05d.jpg -c:v mpeg4 -vf scale=1280:720:flags=neighbor -sws_dither none " + outputFolder + "\\out.mp4";
        println("\n" + c + "\n");
        Runtime.getRuntime().exec(c, null, new File(outputFolder));
      } 
      catch (Exception e) {
        println(e.getMessage());
      }
    }
  }

  String toString() {
    String out = "Movie\n";
    out += "\tFPS:" + FPS + "\tSeconds:" + lenSeconds + "\tFrames:" + lenFrames;
    int i = 0;
    for (FrameSet fs : sets) {
      out += "\n\t" + i + ":" + fs.numFrames;
      i += 1;
    }




    return out;
  }
}
