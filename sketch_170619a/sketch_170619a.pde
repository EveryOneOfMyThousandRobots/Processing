Layer input, l1, l2, output;

void setup () {
  input = new Layer();
  input.putValue(1,1);
  input.putValue(0,1);
  
  l1 = new Layer();
  l1.createLayer(10);
  
  l2 = new Layer();
  l2.createLayer(10);
  
  
}

void draw() {
}

//float[] input = new float[2];

//float[] nodes_weight = new float[5];
//float[] nodes_val = new float[5];

//float[] output = new float[1];
//float[] out_w = new float[1];

//void setup() {
//  input[0] = 1;
//  input[1] = 0;

//  for (int i = 0; i < nodes_weight.length; i += 1) {
//    nodes_weight[i] = random(0.0001, 1);
//  }
//  for (int i = 0; i < out_w.length; i += 1) {
//    out_w[i] = random(0.0001, 1);
//  }
//  noLoop();
//}

//void printAll() {
//  print("\nINPUT\n| ");
//  for (int i = 0; i < input.length; i += 1) {
//    print(input[i] + " | ");
//  }
//  print("\nWEIGHT\n| ");
//  for (int i = 0; i < nodes_weight.length; i += 1) {
//    print(nodes_weight[i] + " | ");
//  }
//  print("\nVALUES\n| ");
//  for (int i = 0; i < nodes_val.length; i += 1) {
//    print(nodes_val[i] + " | ");
//  }
//  print("\nOUTPUT WEIGHT\n| ");
//  for (int i = 0; i < out_w.length; i += 1) {
//    print(out_w[i] + " | ");
//  }

//  print("\nOUTPUT\n");
//  for (int i = 0; i < output.length; i += 1) {
//    print(output[i] + "\t");
//  }
//}

//void cycle() {
//  for (int i = 0; i < nodes_val.length; i += 1) {
//    nodes_val[i] = 0;
//    for (int j = 0; j <input.length; j += 1) {
//      nodes_val[i] += input[j] * nodes_weight[i];
//    }
//  }
//  for (int i = 0; i < output.length; i += 1) {
//    for (int j = 0; j < nodes_val.length; j += 1) {
//      output[i] += nodes_val[j] * out_w[i];
//    }
//  }
//  printAll();
//}


//void draw() {
//  cycle();
//}