import java.util.Arrays;
import java.util.List;
final String ENV_START = "ENV::START::0039994858585868686763276jhdkjhdkjhdfkjh";
final String ENV_END = "ENV::END::0039994858585868686763276jhdkjhdkjhdfkjh";
void setEnvelopeValue(String filename, String k, String v) {

  InputStream reader = createInput(filename);
  ArrayList<String> list = new ArrayList<String>(Arrays.asList(loadStrings(reader)));
  int envStart = -1;
  int envEnd = -1;
  int keyAt = -1;


  for (int i = 0; i < list.size(); i += 1) {
    String line = list.get(i);

    if (envStart == -1 && line.equals(ENV_START)) {
      envStart = i;
    }

    if (envStart >= 0 && envEnd == -1) {
      String[] splt = line.split("=",1);
      if (splt[0].equals(k)) {
        keyAt = i; 
      }
      
    }


    if (envStart >= 0 && envEnd == -1 && line.equals(ENV_END)) {
      envEnd = i;
    }
    
    
    
    if (envStart >= 0 && envEnd >= 0) {
      break;
    }
  }
  
  if (envStart >= 0 && envEnd >= 0) {
    
  } else {
    list.add(0, ENV_START);
    envStart = 0;
    list.add(1, ENV_END);
    envEnd = 1;
  }
  
  if (keyAt == -1) {
    list.add(envStart + 1, k + "=" + v);
  } else {
    list.set(keyAt,k + "=" + v );
  }
  
  
  
}
