String chars = "abcdefghijklmnpqrstvwxyzABCDEFGHJKLMNPQRSTVWXYZ0123456789";

String[] singles = chars.split("");
String p = "";
int charsAdded = 0;
while (charsAdded < 24) {
  p += singles[floor(random(singles.length))];
  charsAdded += 1;
  if (p.length() % 5 == 0 && p.length() > 1) {
    p += "-";
  }
}

println(p);
