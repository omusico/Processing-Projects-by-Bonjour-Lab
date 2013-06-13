class Pointer
{
  //variable
  PVector location;
  PVector velocity;
  PVector acceleration;

  ArrayList<PVector> plocation;

  float xoff, yoff, zoff;

  float d; //distance entre plocation et location
  float size; //taille limite de l'ArrayList plocation

  //PGraphic et dessin de la ligne 
  int type; //type de dessin où [ 1 : tracé normal - 2 : tracé bizeauté - 3 : Pen pressur au debut - 4 : Pen pressur debut et fin ]
  int epaisseur; // epaisseur du trait
  int hue, sat, bright, alpha; // couleur
  boolean degrade;
  int decalageCouleur;
  
  float dx, vx;


  //constructeur
  Pointer(float x_, float y_, float z_)
  {
    xoff = x_;
    yoff = y_;
    zoff = z_;

    //vecteur de tete
    location = new PVector(x_, y_, z_);
    location.x = noise(xoff)*width;
    location.y = noise(yoff)*height;
    location.z = noise(zoff)*1000;

    //velocité /!\ Not used
    velocity = new PVector();
    //acceleration /!\ Not used
    acceleration = new PVector();

    //liste de position
    plocation = new ArrayList<PVector>();
    plocation.add(location.get());

    //taille du squelette
    size = 300;


    //style
    type = 2;
    epaisseur = 20;
    hue = 0;
    sat = 100;
    bright = 100;
    alpha = 100;
    degrade = false;
    decalageCouleur = 150;
  }

  //methodes
  void motion()
  { 
    float d = dist(location.x, location.y, plocation.get(plocation.size()-1).x, plocation.get(plocation.size()-1).y);
    if (d>5)
    {
      plocation.add(location.get());
    }

    location.x = noise(xoff)*width;
    location.y = noise(yoff)*height;
    location.z = noise(zoff)*1000;

    //location.x = map(location.x, 0, 1, 0, width);
    //location.y = map(location.x, 0, 1, 0, height);

    xoff += 0.008;
    yoff += 0.009;
    zoff += 0.01;

    if (plocation.size() >= 1000)
    {
      plocation.remove(0);
    }

    dx+=vx;
    if (dx>=width)
    {
      dx=0.0;
    }
  }

  void display()
  {
    drawSkeleton(type, epaisseur);
  }


  void drawSkeleton(int type_, int epaisseur_)
  {
    shader.start();// debut du shader
    shader.setTexUniform("texture", tex2);
    shader.setVecUniform("deplacement", (float)mouseX, height-(float)mouseY); //envoi les coordonnées de la souris
    shader.setVecUniform("resolution", (float)width, (float)height);
    shader.setVecUniform("origine", (float)location.x, (float)location.y);
    shader.setFloatUniform("time", millis()/2000.0);

    beginShape(QUAD_STRIP);
    texture(tex2); //call Texture
    for (int i=1; i<plocation.size(); i++)
    {
      PVector p = plocation.get(i);
      PVector p2 = plocation.get(i-1);

      PVector origine = new PVector(p2.x, p2.y);
      PVector direction = new PVector(p.x, p.y);
      float magV = dist(origine.x, origine.y, direction.x, direction.y); 
      direction.sub(origine); // j'ajoute l'inverse du vecteur center (soustraction)
      direction.normalize();
      direction.mult(magV);

      //stroke(255);
      noStroke();
      fill(255, 0, 0);
      strokeWeight(1);

      float taille = 1.05;
      
      fill(255, 0, 0);
      vertex(p2.x*taille, p2.y*taille, p2.z*taille, 0, 0);
      
       fill(0, 255, 0);
      vertex(p2.x, p2.y, p2.z, 1, 0);
      
      fill(0, 0, 255);
      vertex(p.x*taille, p.y*taille, p.z*taille, 0, 1);
      
      fill(255, 255, 255);
      vertex(p.x, p.y, p.z, 1, 1);
    }
    endShape();

    shader.stop();
  }


  void updateNewLine(float x_, float y_)
  {
    location = new PVector(x_, y_);
    velocity = new PVector();
    acceleration = new PVector();

    plocation.clear();

    plocation = new ArrayList<PVector>();
    plocation.add(location.get());
  }
}

