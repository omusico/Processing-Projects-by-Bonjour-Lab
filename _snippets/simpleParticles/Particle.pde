class Particle extends PVector {

  PVector vel;
  float damp;
  float vq;
  Particle(float x, float y, float z) {
    super(x, y, z);
    vel = PVector.random3D();
    vel.mult(random(1, 2));
    damp = random(0.96, 0.98);
  }

  void step() {
    this.add(vel);
    vel.mult(damp);
    vq = pow(vel.x, 2) + pow(vel.y, 2) + pow(vel.y, 2); 
  }
}

