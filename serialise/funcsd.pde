String strAppend(String s, String a) {

  s += "\n[v]" + a;
  return s;
}

String strAppendKV(String s, String k, String v) {
  s += "\n[kv]{" + k + "}:{" + v + "}";
  
  return s;
}

void writeSegmentStart(OutputStream s, String v) throws Exception{
  String v0 = "\n[" + v + "]";
  s.write(v0.getBytes());
}

void writeSegmentEnd(OutputStream s, String v) throws Exception{
  String v0 = "\n[/" + v + "]";
  s.write(v0.getBytes());
}
void writePlain(OutputStream s, String v) throws Exception{
    String v0 = "\n" + v;
    s.write(v0.getBytes());
  
}

void writeV(OutputStream s, String v) throws Exception{
    String v0 = "\n[v]" + v;
    s.write(v0.getBytes());
  
}

void writeKV(OutputStream s, String k, String v) throws Exception{
    String v0 = "\n[kv]${" + k + "}=" + v + "";
    s.write(v0.getBytes());
  
}
