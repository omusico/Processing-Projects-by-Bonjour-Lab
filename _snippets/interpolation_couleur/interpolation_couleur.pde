
float r, g, b;
float R, G, B;

void setup() {
  size(800, 600);
}

void mousePressed() {
  R = random(255);
  G = random(255);
  B = random(255);
}

void draw() {  
  background(255);
  noStroke();

  r += (R - r) * 0.01;
  g += (G - g) * 0.01;
  b += (B - b) * 0.01;

  fill(r, g, b);
  ellipse(width/2, height/2, 500, 500);
}

