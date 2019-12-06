String getName() {
  
  String output = "";
  
  output = getFirstName() + " " + arrRnd(nameStarts) + arrRnd(nameEnds); 
  
  
  return output;
}

String arrRnd(String[] arr) {
  return arr[ floor(random(arr.length)) ];
}
