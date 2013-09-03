PVector a1 = new PVector(85, 20,20); 
PVector c1 = new PVector(10, 10,12);
PVector c2 = new PVector(90, 90, 57);
PVector a2 = new PVector(15, 80 ,73);
PVector current;

ArrayList<PVector> handlers;
ArrayList<PVector> pointBesier;

void setup() {
  size(800, 600, OPENGL );
  handlers = new ArrayList();
  
  handlers.add(a1);
  handlers.add(c1);
  handlers.add(c2);
  handlers.add(a2);



}

void mouseDragged() {
  if (current != null) current.set(mouseX, mouseY, 0);
}

void mouseReleased() {
  current = null;
}

void mousePressed() {
  float mind = Float.MAX_VALUE; 
  for (PVector v : handlers) {
    float d = dist(mouseX, mouseY, v.x, v.y);
    if (d < mind && d < 10) {
      current = v;
      mind = d;
    }
  }
  if (current != null) current.set(mouseX, mouseY, 0);
}

void draw() {
  background(255);

  noFill();

  noFill();
  stroke(0);
  bezier(a1.x, a1.y, a1.z, c1.x, c1.y,c1.z, c2.x, c2.y, c2.z, a2.x, a2.y, a2.z);

  stroke(255, 180, 0);
  line(a1.x, a1.y, a1.z, c1.x, c1.y, c1.z);
  line(c2.x, c2.y, c2.z, a2.x, a2.y, a2.z);

  fill(0);
  noStroke();

  
  int steps =  10 ;
  
  for (int i = 0; i <= steps; i++) {
    float t = i / (float)steps;
    float x = bezierPoint(a1.x, c1.x, c2.x, a2.x, t);
    float y = bezierPoint(a1.y, c1.y, c2.y, a2.y, t);
    float z = bezierPoint(a1.z, c1.z, c2.z, a2.z, t);
    
    
    
    //ellipse(x, y, z , 5, 5);
   // translate
    pushMatrix();
    translate(x, y, z);
    sphere(5);
    popMatrix();
  }
}

