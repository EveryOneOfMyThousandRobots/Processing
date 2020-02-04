static class Padder {
  static String[] strings = {"hello"};
  static int[] widths = {10};
  static int totalWidth = 10;
  static boolean[] options = {false};
  static void setStrings(String... _strings) {
    Padder.strings = _strings;
  }
  
  static void reset() {
    strings = new String[1];
    strings[0] = "test";
    widths = new int[1];
    widths[0] = 0;
    totalWidth = 10;
    options = new boolean[1];
    options[0] = false;
  }
  
  static void setWidths(int... _widths) {
    Padder.widths = _widths;
  }
  
  static void setTotalWidth(int w) {
    Padder.totalWidth = w;
  }
  
  static void setOptions(boolean... _options) {
    Padder.options = _options;
  }
  
  static String pad() {
    
    String output = "";
    
    for (int i = 0; i < strings.length; i += 1) {
      
      int w = 10;
      boolean right = false;
      if (i <= widths.length-1) {
        w = widths[i];
      }
      if (i <= options.length-1) {
        right = options[i];
      }
      output += pad(strings[i], w, right);
    }
    
    
    return output;
    
  }
  
  static String pad(String s, int w, boolean right) {
    String output = "";
    for (int i = 0; i < w; i += 1) {
      output += " ";
    }
    if (right) {
      output += s;
      output = output.substring(output.length()-w);
    } else {
      output = s + output;
      output = output.substring(0, w);
    }
    
    return  output;
  }
  
}
