// PP2013
// Jour 1
// Demonstration de l'interplation couleur des vertices

void setup(){
   size(800, 600, OPENGL);
}

void draw(){
  background(255);
  noStroke();

  beginShape();
  fill(255,0,0);
  vertex(10, 10);
  fill(0,255,0);
  vertex(mouseX, mouseY);
  fill(0,0,255);
  vertex(10, height - 10);
  endShape(CLOSE);
}

