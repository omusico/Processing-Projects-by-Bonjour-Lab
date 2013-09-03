PMatrix mat;

ArrayList <PVector> points;
ArrayList <PVector> transFormedPoints;

void setup() {
  size(800, 600, OPENGL);
  mat = new PMatrix3D();
  points = new ArrayList();

  points.add(new PVector(0, 50, 0));
  points.add(new PVector(-20, 0, 0));
  points.add(new PVector(20, 0, 0));
  
  // copie
  transFormedPoints = new ArrayList(points.size());
  for (int i=0; i<points.size(); i++){
    transFormedPoints.add(new PVector());
  }
}


void draw() {
  //background(255);

  translate(width/2, height/2);

  mat.translate(0, 1, 0);
  mat.rotateY(0.012);
  mat.rotateX(0.011);
  mat.rotateZ(0.011);


  for (int i=0; i<points.size(); i++) {
    mat.mult(points.get(i), transFormedPoints.get(i));
  }

  beginShape();
  for (PVector v : transFormedPoints) {
    vertex(v.x, v.y, v.z);
  }  
  endShape(CLOSE);
}

