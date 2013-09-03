void setup() {
  size(800, 600, OPENGL);
  noFill();
}

void draw() {
  background(255);
  // eyeX, eyeY, eyeZ, 
  // centerX, centerY, centerZ, 
  // upX, upY, upZ
  camera(mouseX, 0, 200,     0, 0, 0,     0, 1, 0);
  
  stroke(0);
  box(45);
}

