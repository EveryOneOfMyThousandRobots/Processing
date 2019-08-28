String[] listFileNames(String path) {
  ArrayList<String> fileNames = new ArrayList<String>();
  File f = new File(path);

  if (f.isDirectory()) {

    String[] temp = f.list();

    for (String s : temp) {
      int extPos = s.lastIndexOf(".");
      final String ext = s.substring(extPos+1, s.length()).toUpperCase();

      switch (ext) {
      case "JPG":
      case "PNG":
      case "JPEG":

        fileNames.add(s);


        break;
      default:
        continue;
      }
      
      if (testMode && fileNames.size() > 5) {
        break;
      }

      //println(ext);
    }
  } else {
  }
  String[] returnArray = new String[fileNames.size()];
  Collections.shuffle(fileNames);
  for (int i = 0; i < fileNames.size(); i += 1) {

    returnArray[i] = fileNames.get(i);
  }
  return returnArray;
}

PImage bestFit(PImage img, int tileFactor) {
  float ow = img.width;
  float oh = img.height;

  float dw = width;
  float dh = height;


  float resizeFactor = 0 ;
  if (ow > oh ) {
    resizeFactor = ow / dw;
  } else {
    resizeFactor = oh / dh;
  }
  //println(resizeFactor);

  int newWidth = (int) (ow / resizeFactor);
  int newHeight = (int) (oh / resizeFactor);

  while (newWidth % ((int)(newWidth/tileFactor)) != 0) {
    newWidth -= 1;
  }

  while (newHeight % ((int)(newHeight/tileFactor)) != 0) {
    newHeight -= 1;
  }
  //image(img, 0, 0);
  img.resize(floor(newWidth), floor(newHeight));

  return img;

  //image(img, 0, (height / 2) - (img.height / 2));
}
