ArrayList <PVector> points;

void setup() {
  size(800, 600, OPENGL);

  points = new ArrayList();

  for (int i=0; i<1000; i++) {
    PVector v1 = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    
    v1.normalize();
    PVector v2 = v1.get();    
    v1.mult(100);
    v2.mult(12);
    points.add(v1);
    points.add(v2);
  }
}


void draw() {
  background(255); 
  translate(width/2, height/2);
  rotateX(mouseY * 0.01);
  rotateY(mouseX * 0.01);
  
  beginShape(LINES);
  for (PVector p : points) vertex(p.x, p.y, p.z);
  endShape();
}

