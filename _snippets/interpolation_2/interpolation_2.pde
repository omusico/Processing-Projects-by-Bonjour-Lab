ArrayList<Dot> dots;


void setup() {
  size(800, 600);
  smooth();  
  
  dots = new ArrayList();
  
  for (int i=0; i<20; i++){
    dots.add(new Dot(random(width), random(height)));
  }
  
}

void mousePressed(){
  for (Dot d : dots) {
    d.dpos.x = random(width);
    d.dpos.y = random(height);
  }
}


void draw() {
  background(255);
  
  for (Dot d : dots){
    d.step();
    d.draw();
  }

}

