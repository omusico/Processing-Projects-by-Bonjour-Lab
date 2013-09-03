void setup(){
  size(800, 600, OPENGL);  
}

void draw(){
  background(255);

  translate(width/2, height/2);
  
  rotateX(mouseY * 0.01);
  rotateY(mouseX * 0.01);

  float r1 = 100;
  float r2 = 50;
  int s1 = 64;
  int s2 = 16;

  float arc1 = TWO_PI / s1;
  float arc2 = TWO_PI / s2;
  
  beginShape(POINTS);
  for (int j=0; j<s1; j++){
    float a1 = arc1 * j;
    for (int i=0; i<s2; i++){
      float a2 = arc2 * i;
      float pz = sin(a2) * r2;
      float px = (r1 + cos(a2) * r2) * cos(a1);      
      float py = (r1 + cos(a2) * r2) * sin(a1);  
      vertex(px, py, pz);
    }
  }    
  endShape();
}

