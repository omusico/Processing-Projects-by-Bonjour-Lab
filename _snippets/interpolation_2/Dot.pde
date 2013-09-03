class Dot extends PVector {
  PVector dpos;
  color col;
  float d;
  float damping;
  
  Dot(float x, float y) {
    super(x, y);
    dpos = get();
    d = 30;    
    damping = random(0.01, 0.08);
    col = color(random(255), random(255), random(255));
  }

  void step() {
    x += (dpos.x - x) * damping;
    y += (dpos.y - y) * damping;
  }

  void draw() {
    // trajectoire
    stroke(col, 128);
    line(x, y, dpos.x, dpos.y);  

    // position
    fill(col);
    noStroke();
    ellipse(x, y, d, d);

    // cible
    stroke(col);
    noFill();
    ellipse(dpos.x, dpos.y, d+7, d+7);
    ellipse(dpos.x, dpos.y, 7, 7);
  }
}

