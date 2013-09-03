ArrayList <PVector> points;

void setup() {
  size(800, 600, OPENGL);

  points = new ArrayList();

  for (int i=0; i<30000; i++) {
    PVector v1 = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    v1.normalize();
    v1.mult(100);
    points.add(v1);
  }
}


void draw() {
  background(128); 
  translate(width/2, height/2);
  rotateX(mouseY * 0.01);
  rotateY(mouseX * 0.01);

  float offset = frameCount * 0.01;
  beginShape(LINES);
  for (PVector p : points) {
    float r = noise(p.x*0.01 + 100,p.y*0.01 + 200,p.z*0.01 + 124);
    if (r < 0.5) stroke(0);
    else stroke(255);
    vertex(p.x, p.y, p.z);
    PVector p2 = p.get();
    p2.normalize();
    p2.mult(noise(p.x*0.01 * offset, p.y*0.01 * offset, p.z*0.01 * offset) * 40);
    p2.add(p);
    vertex(p2.x, p2.y, p2.z);
  }
  endShape();
  noStroke();
  fill(128);
  sphere(100);
}

