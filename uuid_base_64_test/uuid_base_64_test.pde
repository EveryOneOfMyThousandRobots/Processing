import java.util.UUID;
import java.util.Base64;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.zip.GZIPOutputStream;
import java.util.zip.*;
import java.util.Arrays;
import java.util.List;
import java.security.MessageDigest;
String getuuid(int c) {
  String rt = "";

  for (int i = 0; i < c; i += 1) {
    rt += UUID.randomUUID().toString();
  }
  List<String> strlist = Arrays.asList(rt.split("-"));

  rt = String.join("", strlist);


  return rt;
}

void setup() {

  String env = getuuid(5);
  String env64 = Base64.getEncoder().encodeToString(env.getBytes());

  println(env);
  env64 = env64.replace('+', '.').replace('/', '_').replace('=', '-');
  println(env64);
  String compressed = env64;
  try {
    compressed = compress(env64);
    println(compressed);
  } 
  catch (Exception e) {
    println(e.getMessage());
  }

  try {
    MessageDigest msg = MessageDigest.getInstance("SHA-256");
    msg.update(compressed.getBytes());
    byte[] bytes = msg.digest();
    String ss = bytesToHex(bytes);
    
    println(ss);
    String ss64 = Base64.getEncoder().encodeToString(ss.getBytes());
    println(ss64);
  } 
  catch (Exception e) {
    println(e.getMessage());
  }
} 

void draw() {
  exit();
}

String bytesToHex(byte[] hash) {
  StringBuffer hexString = new StringBuffer();
  for (int i = 0; i < hash.length; i++) {
    String hex = Integer.toHexString(0xff & hash[i]);
    if (hex.length() == 1) hexString.append('0');
    hexString.append(hex);
  }
  return hexString.toString();
}


String compress(String str)throws Exception {
  if (str == null || str.length() == 0) {
    return str;
  }

  ByteArrayOutputStream out = new ByteArrayOutputStream();
  GZIPOutputStream gzip = new GZIPOutputStream(out);
  gzip.write(str.getBytes());
  gzip.close();
  return out.toString("UTF8");
}
