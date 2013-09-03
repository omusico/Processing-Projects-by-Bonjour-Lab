ArrayList <Triangle> triangles;

void setup() {
  size(800, 600, OPENGL); 

  float r = 200;
  PVector a = new PVector(r, 0, 0);
  PVector b = new PVector(0, -r, 0);
  PVector c = new PVector(-r, 0, 0);
  PVector d = new PVector(0, r, 0);
  PVector e = new PVector(0, 0, r);
  PVector f = new PVector(0, 0, -r);


  triangles = new ArrayList();
  triangles.add(new Triangle(a, b, e));
  triangles.add(new Triangle(b, c, e));
  triangles.add(new Triangle(c, d, e));
  triangles.add(new Triangle(d, a, e));

  triangles.add(new Triangle(a, b, f));
  triangles.add(new Triangle(b, c, f));
  triangles.add(new Triangle(c, d, f));
  triangles.add(new Triangle(d, a, f));


  triangles = subdivide(triangles, r);
  triangles = subdivide(triangles, r);
  triangles = subdivide(triangles, r);
  triangles = subdivide(triangles, r);
  triangles = subdivide(triangles, r);



}

ArrayList <Triangle> subdivide(ArrayList <Triangle> source, float r) {
  ArrayList <Triangle> temp = new ArrayList();

  for (Triangle t : source) {
    PVector p1 = PVector.sub(t.b, t.a);
    p1.mult(0.5);
    p1.add(t.a);
    p1.normalize();
    p1.mult(r);

    PVector p2 = PVector.sub(t.c, t.b);
    p2.mult(0.5);
    p2.add(t.b);
    p2.normalize();
    p2.mult(r);

    PVector p3 = PVector.sub(t.a, t.c);
    p3.mult(0.5);
    p3.add(t.c);
    p3.normalize();
    p3.mult(r);

    temp.add(new Triangle(t.a, p1, p3));
    temp.add(new Triangle(p1, t.b, p2));
    temp.add(new Triangle(p3, p2, t.c));
    temp.add(new Triangle(p3, p1, p2));
  }  
  return temp;
}


void draw() {

  background(255);


  translate(width/2, height/2);

  rotateX(mouseY*0.01);
  rotateY(mouseX*0.01);

  beginShape(TRIANGLE);
  for (Triangle t : triangles) {
    vertex(t.a.x, t.a.y, t.a.z);
    vertex(t.b.x, t.b.y, t.b.z);
    vertex(t.c.x, t.c.y, t.c.z);
  }
  endShape();
}

