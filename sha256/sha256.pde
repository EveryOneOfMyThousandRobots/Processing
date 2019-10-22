import java.security.MessageDigest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.nio.charset.StandardCharsets;




void setup() {
  frameRate(1);
}

void draw() {
  DateFormat df = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss.SSS");
  Date dt = new Date();
  String s = "ProperMusicGroup" + df.format(dt) + "password" + "secretKey";
  try {
    MessageDigest mg = MessageDigest.getInstance("SHA-256");

    byte[] hash = mg.digest(s.getBytes(StandardCharsets.UTF_8));

    println("");
    for (int i = 0; i < hash.length; i += 1) {
      print(String.format("%02x", hash[i]));
    }
    String ss = hash.toString();
    
    //println(ss);
  } 
  catch(Exception e) {
    println(e.getMessage());
  }
}
