float x, y;
float dx, dy;
float d;

void setup() {
  size(800, 600);
  smooth();  
  x = 50; 
  y = 40;
  d = 30;
}

void mouseDragged() {
  dx = mouseX;
  dy = mouseY;
}

void draw() {
  // interpolation
  x += (dx - x) * 0.01;
  y += (dy - y) * 0.01; 

  // affichage
  background(255);

  fill(255, 0, 0);
  noStroke();
  ellipse(x, y, d, d);

  stroke(255, 0, 0);
  noFill();
  ellipse(dx, dy, d+7, d+7);
}

