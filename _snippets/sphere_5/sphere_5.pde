Poly ball;
void setup() {
  size(800, 600, OPENGL);
  ball = new Poly(200, 0, color(255, 0, 0));
}

void draw() {
  background(255);
  translate(width/2, height/2);
  rotateX(mouseY*0.01);
  rotateY(mouseX*0.01);
  ball.draw();
}

