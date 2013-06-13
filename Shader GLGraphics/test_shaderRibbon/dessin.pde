class Pointer
{
  //variable
  PVector location;
  PVector velocity;
  PVector acceleration;

  ArrayList<PVector> plocation;

  float xoff, yoff, zoff, aoff;

  float vy;
  float taille;

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
  Pointer(float x_, float y_, float z_, float taille_, float vy_)
  {
    xoff = x_;
    yoff = y_;
    zoff = z_;

    vy = vy_;
    taille = taille_;

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
    size = 25;

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

    xoff += 0.008;
    yoff += 0.009;
    zoff += 0.005;

    if (plocation.size() >= size)
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
    //debug
    /*
    pushMatrix();
     translate(location.x, location.y, location.z);
     ellipse(0, 0, 10, 10);
     popMatrix();
     */
    drawSkeleton(type, epaisseur);
  }


  void drawSkeleton(int type_, int epaisseur_)
  {  
    for (int i=1; i<plocation.size(); i++)
    {
      PVector p = plocation.get(i);
      PVector p2 = plocation.get(i-1);

      PVector origine = new PVector(p2.x, p2.y, p2.z);
      PVector direction = new PVector(p.x, p.y, p.z);
      float magV = dist(origine.x, origine.y, direction.x, direction.y); 
      direction.sub(origine); // j'ajoute l'inverse du vecteur center (soustraction)
      direction.normalize();
      direction.mult(magV);

      PVector origine2 = new PVector(p2.y, p2.z);
      PVector direction2 = new PVector(p.y, p.z);
      float magV2 = dist(origine.x, origine.y, direction.x, direction.y); 
      direction2.sub(origine2); // j'ajoute l'inverse du vecteur center (soustraction)
      direction2.normalize();
      direction2.mult(magV2);
      /*
      if (i>plocation.size()/2)
       {
       taille = map(i, 0, plocation.size(), 10, 0);
       }
       else
       {
       taille= map(i, 0, plocation.size()/2, 0, 10);
       }
       */
      p2.y += vy;
      float newZ = p.z-p2.z;

      noStroke();
      pushMatrix();
      translate(origine.x, origine.y, origine.z);
      
      rotateZ(direction.heading2D());
      
      float posTex = map(i, 0, plocation.size(), 0.0, 0.1);

      beginShape(QUAD_STRIP);
      texture(offscreenRibbon.getTexture()); //call Texture
      vertex(-1, -taille, 0, 0, 0); 
      vertex(-1, taille, 0, 1, 0);

      vertex(magV, -taille, newZ, 0, 1);
      vertex(magV, taille, newZ, 1, 1);
      endShape();

      popMatrix();
    }
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

