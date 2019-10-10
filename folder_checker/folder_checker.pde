
String[] inFolders = {"orderRequest", "cancelRequest"};
String[] outFolders = {"orderResponse", "cancelResponse"};

HashMap<String, String> hashToFolder = new HashMap<String, String>();
HashMap<String, String> folderToHash = new HashMap<String, String>();

import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.math.BigInteger;


String getFolderHash(String folder) {
  String fld = folder.toUpperCase().trim();

  if (folderToHash.containsKey(fld)) {
    return folderToHash.get(fld);
  } else {
    String hash = null;

    while (hash == null) {
      hash = getBase32Name(7);
      if (hashToFolder.containsKey(hash)) {
        hash = null;
      }
    }

    hashToFolder.put(hash, fld);
    folderToHash.put(fld, hash);
    return hash;
  }
}

void mkDir(String dir) {
  File file = new File(dir);
  if (file.exists()) {
  } else {
    file.mkdir();
  }
}


class Client {
  final String name;
  final String baseFolder;
  ArrayList<String> folders = new ArrayList<String>();
  final String procFolder;


  Client(String clientName, String base) {
    this.name = clientName;
    String tb = base;
    if (tb.charAt(tb.length()-1) != '\\') {
      tb += "\\";
    }


    this.baseFolder = tb;
    mkDir(this.baseFolder);
    procFolder = this.baseFolder + "proc\\";
    mkDir(procFolder);
    String inFolder = this.baseFolder + "in\\";
    String outFolder = this.baseFolder + "out\\";
    mkDir(inFolder);

    for (String folder : inFolders) {
      String fullPath = inFolder + folder + "\\";
      folders.add(fullPath);
      mkDir(fullPath);
      getFolderHash(fullPath);
    }

    mkDir(outFolder);

    for (String folder : outFolders) {
      mkDir(outFolder + folder + "\\");
    }
  }

  void check() {
    for (String folder : folders) {
      File f = new File(folder);
      if (f.isDirectory()) {
        File[] files = f.listFiles();

        for (File file : files) {
          if (!file.isDirectory()) {


            while (true) {


              DateFormat f1 = new SimpleDateFormat("yyMMddHHmmssSSS");
              
              Date d = new Date();
              String dt1 = f1.format(d);
              
              BigInteger big = new BigInteger(dt1, 10);
              
              
              
              String newName = getFolderHash(file.getParent()) + "." + big.toString(32);

              File nf = new File(procFolder + "\\" + newName);
              if (nf.exists()) continue;
              file.renameTo(nf);
              println("renamed\n\t\t" + file + "\n\tto\n\t\t" + nf);
              break;
            }
          }
        }
      }

      //getNewNameFromFilePath(folder);
    }
  }

  void createRandom() {
    if (random(1) < 0.01) {
      String randomPath = folders.get(floor(random(folders.size())));

      File file = new File(randomPath + "\\something.csv");
      try {
        if (file.createNewFile()) {
          println("created new file + " + file.getAbsolutePath());
        } else {
          println("failed to create new file + " + file.getAbsolutePath());
        }
      } 
      catch (Exception e) {
        println(e.getMessage());
      }
    }
  }
}



void addFile(ArrayList<File> files, String folder) {
  File file = new File(folder);

  if (file.isDirectory()) {
    files.add(file);
    File[] sub = file.listFiles();
    if (sub == null) {
      //println("no files found in " + file.getAbsolutePath());
    } else {

      for (File sf : sub) {
        //println(sf.getAbsolutePath());
        addFile(files, sf.getAbsolutePath());
      }
    }
  } else {
    //println("file is a file");
    files.add(file);
  }
}
String base32 = "$%#abcdefghjkpqrstvxyz0123456789";
String getBase32Name(int len) {

  String rt = "";

  for (int i = 0; i < len; i += 1) {
    int r = floor(random(0, 32));
    rt += str(base32.charAt(r));
  }


  return rt;
}

ArrayList<Client> clients = new ArrayList<Client>();

String getNewNameFromFilePath(File  file) {
  String newName = "";



  String[] parts = split(file.getParent(), '\\');
  //printArray(parts);
  boolean begin = false;

  for (String part : parts) {
    if (part.equals("cust")) {
      begin = true;
      continue;
    }

    if (begin) {
      if (part.length() > 0) {
        if (newName.length() > 0) {
          newName += "#";
        }
        newName += part;
      }
    }
  }

  newName += "." + getBase32Name(6);




  return newName;
}

void setup() {
  size(400, 400);




  String path= sketchPath() + "\\data\\cust\\";
  ArrayList<File> files = new ArrayList<File>();

  addFile(files, path);
  println("found:");
  printArray(files);
  Client client = new Client ("hello", path + "hello\\");
  clients.add(client);
  for (String hash : hashToFolder.keySet()) {
    println(hash + "\t\t" + hashToFolder.get(hash));
  }
}


void draw() {
  for (Client client : clients) {
    client.createRandom();
    client.check();
  }
}
