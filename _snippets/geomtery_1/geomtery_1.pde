ArrayList<PVector> points;

PVector pos;
PMatrix mat;

void setup() {  
  size(800, 600, OPENGL);
  points = new ArrayList();
  pos = new PVector();
  mat = new PMatrix3D();
}


void draw() {

  PVector t = new PVector();

  mat.mult(new PVector(-20, 0, 0), t);
  points.add(t.get());
  mat.mult(new PVector(20, 0, 0), t);
  points.add(t.get());


  if (points.size() > 500) {
    points.remove(0);
    points.remove(0);
  }

  mat.translate(0, 0, 2);

  // interaction  
  if (keyPressed) {
    if (keyCode == UP) mat.rotateX(0.05);
    else if (keyCode == DOWN) mat.rotateX(-0.05);
    else if (keyCode == RIGHT) mat.rotateZ(0.04);
    else if (keyCode == LEFT) mat.rotateZ(-0.04);
  }

  // affichage  
  background(255);
  translate(width/2, height/2);
  rotateY(mouseX *0.01);
  noFill();
  stroke(0);

  beginShape(QUAD_STRIP);
  for (PVector v : points) {
    vertex(v.x, v.y, v.z);
    v.x += random(-0.3, 0.3);
    v.y += random(-0.3, 0.3);
    v.z += random(-0.3, 0.3);
  }
  endShape();
}

