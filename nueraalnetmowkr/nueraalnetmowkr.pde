
Layer input = new Layer(2);
Layer middle = new Layer(5);
Layer output = new Layer(1);
void setup() {
  input.from = null;
  input.to = middle;
  
  middle.from = input;
  middle.to = output;
  
  output.from = middle;
  output.to = null;
  
  input.Connect();
  middle.Connect();
  output.Connect();
  
  input.Print();
  middle.Print();
  output.Print();
  
}



void draw() {
  
}