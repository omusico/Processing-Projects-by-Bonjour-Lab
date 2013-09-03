import processing.net.*;

final static int PORT = 12345;
final static String END = "\n"; 

int mx, my;

Server server;

void setup() {
  size(800, 600, OPENGL);
  server = new Server(this, PORT);
  println("----------------------------------");
  println("server IP: " + server.ip());
  println("server PORT: " + PORT);
}

void draw() {
  serverLoop();
  background(255); 
  noFill();
  stroke(0);
  translate(width/2, height/2);
  rotateX(my * 0.01);
  rotateY(mx * 0.01);
  box(300, 200, 100);
} 

void serverLoop(){
  Client c = server.available();
  if (c != null && c.available() > 0) {
    String message = c.readString();
    String[] s = split(trim(message), END);
    for (int i=0; i<s.length; i++) {
       String[] m = split(s[i], " ");
       if (m.length == 2) {
         String type = m[0];
         String val = m[1];         
         // parsing          
         if (type.equals("mx")) mx = int(val);
         else if (type.equals("my")) my = int(val);         
       }
    }
  }
}

