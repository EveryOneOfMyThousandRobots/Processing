String text = "0123456789ABCDEFGHJKLMPQRSTVWXYZ";
String output = "";
int l = text.length();
int i = 0;


for (int j = 0; j < l; j += 1) {
  String s = str(text.charAt(floor(random(text.length()))));
  text = text.replaceAll(s,"");
  output += s;
  println(s + " " + output + " " + text);
}

println(output + " orig len: " + l + " new len: " + output.length());
