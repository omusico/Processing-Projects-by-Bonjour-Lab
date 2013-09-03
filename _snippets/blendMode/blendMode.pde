void setup() {
  size(800, 600, OPENGL);
}


void draw() {
  rectMode(CENTER);
  background(255);
  noStroke();

//blendMode(MULTIPLY);

  fill(255, 128, 0, 127);
  rect(width/2-100, height/2, 200, 100);

  fill(128, 255, 0, 127);
  rect(mouseX, mouseY, 200, 200);

  fill(255, 128, 0, 127);
  rect(width/2+100, height/2, 200, 100);
}

