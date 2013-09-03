
Camera cam;

void setup() {
  size(800, 600, OPENGL);
  noFill();  
  cam = new Camera(new PVector(0, 0, 200), new PVector(0,0,0));
}


void mousePressed(){
  PVector v = new PVector(random(-100, 100),random(-100, 100),random(100, 300));
  cam.setEye(v);

}
void draw() {
  background(255);
    cam.interpolate();
    cam.apply();
    
  stroke(0);
  box(45);


  
}

