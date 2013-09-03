PShape donut;
void setup() {
  size(800, 600, OPENGL);
  smooth(8);

  donut = torus(100, 50, 64, 32, color(255, 0, 0), color(255, 255, 0));
}

void draw() {
  background(255);

  lights();
  lightSpecular(255, 255, 255);
  translate(width/2, height/2);  
  rotateX(mouseY * 0.01);
  rotateY(mouseX * 0.01);

  noStroke();
  fill(255, 0, 0);
  shape(donut, 0, 0);
}


PShape torus(float r1, float r2, int s1, int s2, color col1, color col2) {


  float arc1 = TWO_PI / s1;
  float arc2 = TWO_PI / s2;
  ArrayList <PVector>  points = new ArrayList();

  for (int j=0; j<s1; j++) {
    float a1 = arc1 * j;
    for (int i=0; i<s2; i++) {
      float a2 = arc2 * i;
      float pz = sin(a2) * r2;
      float px = (r1 + cos(a2) * r2) * cos(a1);      
      float py = (r1 + cos(a2) * r2) * sin(a1);  
      points.add(new PVector(px, py, pz));
    }
  }

  int num = s1 * s2;
  PVector v1, v2, v3, v4;

  PShape s = createShape();
  s.beginShape(QUADS);
  s.noStroke();

  for (int j=0; j<s1; j++) {

    if (j % 2 == 0) s.fill(col1);
    else s.fill(col2);

    for (int i=0; i<s2; i++) {
      int p1 = j * s2 + i;
      int p2 = j * s2 + (i + 1) % s2;
      int p3 = (p2 + s2) % num;
      int p4 = (p1 + s2) % num;




      v1 = points.get(p1);
      v2 = points.get(p2);
      v3 = points.get(p3);
      v4 = points.get(p4);

      s.vertex(v1.x, v1.y, v1.z);
      s.vertex(v2.x, v2.y, v2.z);
      s.vertex(v3.x, v3.y, v3.z);
      s.vertex(v4.x, v4.y, v4.z);
    }
  }
  s.endShape();
  return s;
}

