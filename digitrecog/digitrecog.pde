byte[] imageFile;// = loadBytes("train-images.idx3-ubyte");
byte[] labelFile;

int[] guesses = new int[10];

int numImages;
int rows;
int cols;
int currentLabel;

//float[][] training = {{0, 0, 0}, {0, 1, 1}, {1, 0, 1}, {1, 1, 0}};
Brain brain;
PImage loadedImage = null;







void setup () {
  size(600, 600);
  imageFile = loadBytes("train-images.idx3-ubyte");
  labelFile = loadBytes("train-labels.idx1-ubyte");


  //int magic = toInt(imageFile, 0);
  numImages = toInt(imageFile, 4);
  rows = toInt(imageFile, 8);
  cols = toInt(imageFile, 12);

  brain = new Brain(rows * cols, 5, 16, 10);
  frameRate(10000);
  colorMode(HSB);

  //for (float f = -20; f < 20; f+= 0.1) {

  //  println(f + " " + hyperbol(f));
  //}


  //stop();

  //background(0);
  //for (int i = 0; i < 10; i += 1) {
  //  loadImageA(i);
  //  image(loadedImage, 0, i * 28);
  //  text(currentLabel, 30, 10 + (i * 28));
  //}



  //for (int i = 0; i < 15; i += 1) {

  //  println(bytes[i]);
  //}


  ////brain = new Brain(2, 2, 3, 1);
  //loopTraining(false, true);
  //for (int k = 0; k < 5; k += 1) {
  //  float overallError = 0;

  //  overallError = loopTraining(true, false);

  //}
  //println(loopTraining(false, true));

  //noLoop();
}
int currentIndex = 0;
float total=0, correct=0, wrong=0;
float[] errors = new float[10];


void draw() {
  errors = resetErrors(errors);

  total += 1;
  loadImageA(currentIndex);
  float[] a = getImageArray(loadedImage);
  brain.calc(a);
  int guess = brain.getGuess();
  if (guess >= 0 ) {
    guesses[guess] += 1;
    for (int i = 0; i < errors.length; i += 1) {
      errors[i] = float(guess) - float(currentLabel);
    }
  }

  if (guess == currentLabel) {
    //text("correct", 10, 100);  
    correct += 1;
  } else {
    //text("wrong", 10, 100);
    wrong += 1;
    //brain.adjust(map(guess - currentLabel, -10, 10, -1,1));
    brain.adjust(errors);
  }
  if (frameCount % 100 == 0) {
    background(0);
    image(loadedImage, 0, 0);
    text(guess + " " + currentLabel, 30, 28);
    text(nf((correct / total) * 100, 3, 3) + "%", 10, 120);
    text("wrong:" + wrong + " correct:" + correct + " total:" + total, 10, 140);
    brain.draw();

    for (int i = 0; i < guesses.length; i += 1) {
      text(i + ": " + guesses[i], 10, (height / 2) + (10 * i));
    }
    text(brain.output.toString(), 10, (height / 2) + 100);
  }



  currentIndex += 1;
  currentIndex = currentIndex % numImages;
}