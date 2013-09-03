import processing.net.*;

final static int PORT = 12345;
final static String END = "\n"; 

Client client;

void setup(){
  size(200, 200);
  client = new Client(this, "localhost", PORT);  
}

 
void draw(){
  client.write("mx " + mouseX + END);
  client.write("my " + mouseY + END);
  
  background(255);
  stroke(0);
  
  line(mouseX, 0, mouseX, height);
  line( 0, mouseY, width, mouseY);
  
  
}
