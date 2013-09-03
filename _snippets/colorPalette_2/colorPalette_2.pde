color[] colors;

void setup() {
  size(800, 600);
  smooth();
  background(255);
  
  PImage pal = loadImage("palette.png");
  
  colors = new color[pal.pixels.length];
  for (int i=0; i<pal.pixels.length; i++){
    colors[i] = pal.pixels[i];
  }  
  
  
  println("color[] palette = new color["+colors.length+"];");  
  for (int i=0; i<colors.length; i++){
    int c = colors[i];
    int r = (int) red(c); //c >> 16 & 0xFF;
    int g = (int) green(c); //c >> 8 & 0xFF;
    int b = (int) blue(c); //c & 0xFF;
    println("palette["+i+"] = color(" + r + "," + g + "," + b + ");");
  }  
  


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

