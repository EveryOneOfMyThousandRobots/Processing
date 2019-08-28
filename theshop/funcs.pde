final String spaces = "                      ";

String pad(String... strings) {
  String output = "";
  
  for (String s : strings) {
    s += spaces;
    s = s.substring(0,20);
    s += " ";
    output += s;
  }
  
  return output;
}
