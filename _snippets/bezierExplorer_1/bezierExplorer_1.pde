PVector a1 = new PVector(85, 20); 
PVector c1 = new PVector(10, 10);
PVector c2 = new PVector(90, 90);
PVector a2 = new PVector(15, 80);
PVector current;

ArrayList<PVector> handlers;

void setup() {
  size(800, 600);

  handlers = new ArrayList();
  handlers.add(a1);
  handlers.add(c1);
  handlers.add(c2);
  handlers.add(a2);
}

void mouseDragged() {
  if (current != null) current.set(mouseX, mouseY, 0);
}

void mouseReleased() {
  current = null;
}

void mousePressed() {
  float mind = Float.MAX_VALUE; 
  for (PVector v : handlers) {
    float d = dist(mouseX, mouseY, v.x, v.y);
    if (d < mind && d < 10) {
      current = v;
      mind = d;
    }
  }
  if (current != null) current.set(mouseX, mouseY, 0);
}

void draw() {
  background(255);

  noFill();

  noFill();
  stroke(0);
  bezier(a1.x, a1.y, c1.x, c1.y, c2.x, c2.y, a2.x, a2.y);

  stroke(255, 180, 0);
  line(a1.x, a1.y, c1.x, c1.y);
  line(c2.x, c2.y, a2.x, a2.y);

  fill(0);
  noStroke();
  ellipse(a1.x, a1.y, 5, 5);
  ellipse(a2.x, a2.y, 5, 5);






  /*
  fill(255);
   int steps = 10;
   for (int i = 0; i <= steps; i++) {
   float t = i / float(steps);
   float x = bezierPoint(85, 10, 90, 15, t);
   float y = bezierPoint(20, 10, 90, 80, t);
   ellipse(x, y, 5, 5);
   }
   */
}

