ArrayList<PVector> points;

PVector pos;
PMatrix mat;
Camera cam;

void setup() {  
  size(800, 600, OPENGL);
  points = new ArrayList();
  pos = new PVector();
  mat = new PMatrix3D();
  cam = new Camera(new PVector(0, 0, 200), new PVector(0, 0, 0));
}


void draw() {
  PVector center = new PVector();
  mat.mult(new PVector(0, 0, 0), center);

  PVector eye = center.get();  
  float r = mouseY * 2 + 100;
  float a = map(mouseX, 0, width, -PI, PI);
  eye.x += sin(a) * r;
  eye.z += cos(a) * r;
  
  
  
  cam.setEye(eye);  
  cam.setCenter(center);

  PVector t = new PVector();
  mat.mult(new PVector(-20, 0, 0), t);
  points.add(t.get());
  mat.mult(new PVector(20, 0, 0), t);
  points.add(t.get());


  if (points.size() > 2000) {
    points.remove(0);
    points.remove(0);
  }

  mat.translate(0, 0, -5);

  // interaction  
  if (keyPressed) {
    if (keyCode == UP) mat.rotateX(0.05);
    else if (keyCode == DOWN) mat.rotateX(-0.05);
    else if (keyCode == RIGHT) mat.rotateZ(0.04);
    else if (keyCode == LEFT) mat.rotateZ(-0.04);
  }

  // affichage  
  background(255);

  cam.interpolate();
  cam.apply();

  fill(255);
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

