color[] colors;

void setup() {
  size(800, 600);
  smooth();
  background(255);
  
  colors = new color[4];
  colors[0] = color(128,22,180);
  colors[1] = color(23,220,30);
  colors[2] = color(78,2,243);
  colors[3] = color(80,183,20);
}


void draw() {

  int index = int(random(colors.length));
  color col = colors[index];

  float d = 50;
  float x = random(width);
  float y = random(height);
  noStroke();
  fill(col);
  ellipse(x, y, d, d);
}

