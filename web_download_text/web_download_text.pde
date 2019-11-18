import processing.net.*;

Client client;
String data;
String url = "https://www.gutenberg.org/files";  
//https://www.gutenberg.org/files/16328/16328.txt
void setup() {
  size(200, 200);
}
int count = 0;
void draw() {
  count += 1;
  String urlA = url + "/" + count + "/" + count + ".txt";
  try {
    client = new Client(this, urlA, 80);

    client.write("GET / HTTP/1.0\r\n"); // Use the HTTP "GET" command to ask for a Web page
    client.write("\r\n");

    if (client.available() > 0) {
      println(client.readString());
    }
  } 
  catch (Exception e) {
  }
}
