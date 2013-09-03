ArrayList <Particle> particles;

void setup() {
  size(800, 600, OPENGL);
  particles = new ArrayList();
}


void draw() {
  background(255);
  if (mousePressed) {
    for (int i=0; i<100; i++) {
      float x = mouseX + random(-5, 5);
      float y = mouseY + random(-5, 5);
      particles.add(new Particle(x, y, 0));
    }
  }

  for (int i=particles.size()-1; i>=0; i--) {
    Particle p = particles.get(i);
    p.step();
    //p.draw();
    if (p.vq < 0.1) particles.remove(p);
  }

  beginShape(POINTS);
  for (Particle p : particles) {
    vertex(p.x, p.y, p.z);
  }
  endShape();
}

