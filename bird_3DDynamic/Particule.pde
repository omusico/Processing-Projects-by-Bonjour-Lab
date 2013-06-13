//declaration d'une classe
class Particule
{
  //Declaration des membres classe particules
  float x=0;
  float y=0;
  float z=0;
  float newX=0;
  float newY=0;
  float newZ=0;
  float d=5;
  float vx=0;
  float vy=0;
  float vz=0;

  //Bruit Perlin
  float nxScale;
  float nyScale;
  float nzScale;
  float n=0;
  float t;
  int w = width;
  int h = height;

  //taille de l'animal
  float taille;
  float hauteur;
  float envergure;
  float rapportTailleHauteur;
  float rapportTailleEnvergure;

  //Couleur
  int hueBird;
  int brightBird;
  int satBird;
  color c;
  float alphaBirds;

  //ailes
  float px, py, px2, py2;
  float angle;
  float frequency;
  boolean aileInvert=false;
  boolean plane;

  //Rotation - sens de oiseaux
  float rx;
  float ry;
  float rz;

  //Vie & Jauge de vie
  int nombreDeBattementdAile;
  float dureeDeVie;

  //Logo Motorola
  PShape logo;
  //logo pour capta
  PImage logo2;

  //Font
  PFont anivers;

  //Variable d'etat de l'Oiseau
  boolean arrivee;
  boolean vol;
  boolean depart;
  float destination;


  //Declaration de la fonction constructeur au variable de stockage x_ et y_ permettant de stocker les varaible x et y
  Particule(float x_, float y_, float z_)
  {
    //forme
    this.taille=60;
    this.rapportTailleHauteur=0.2;
    this.rapportTailleEnvergure=0.6;
    this.frequency=random(20, 30);
    //position
    this.x = x_;
    this.y = y_;
    this.z = z_;
    this.newX= newX;
    this.newY= newY;
    this.newZ= newZ;
    //murs
    this.d = random(5, 30);
    //vitesse
    this.vx = random(-5, 5);
    this.vy = random(-5, 5);
    this.vz = random(-5, 5);
    //couleur
    this.hueBird = int(random(0, 48));
    this.brightBird = 100;
    this.satBird = 0;
    //this.c= color(hueBird, 78, this.brightBird);
    this.alphaBirds = 100;
    //axe de l'oiseau
    this.rx=0;
    this.ry=0;
    this.rz=0;
    //battement d'aile
    this.nombreDeBattementdAile=0;
    this.plane =false;
    //textes
    this.anivers = loadFont("Anivers-Regular-11.vlw");
    //etat de l'oiseau
    this.arrivee = true;
    this.vol=false;
    this.depart=false;
    this.destination=random(-height+(height/4), 0);
    //image blockmark
    this.logo= loadShape("logoMotorola.svg");
    this.logo2= loadImage("logoMotorola.png");
  }

  //Decalaration d'une methode - fonction permettant d'intervenir sur les variable/membre de la classe
  void display()
  {
    //controleur (taille, envergure....)
    hauteur=taille*rapportTailleHauteur;
    envergure = taille*rapportTailleEnvergure;


    if (arrivee==true)
    {
      this.z-=5;
      this.brightBird = int(map(this.z, height/4, 0, 0, 100));
      if (this.z<=this.destination)
      {
        //this.z=this.destination;
        vol=true;        
        arrivee=false;
      }
    }
    if (vol==true) //&& this.z==this.destination)
    { 
      this.z = this.z+this.vz;
      
      //percussion mur Arriere  
      if (this.z>0)// && vol ==true)
      {
        this.z=0;
        this.vz = -this.vz;
      }
      //percussion mur avant
      if (this.z<-height+(height/4+10))// && vol ==true)
      {
        this.z=-height+(height/4+10);
        this.vz = -this.vz;
      }
    }
    if (depart==true)
    {
      this.z-=5;
    }

    //Bruit Perlien (vent)
    float mx = map(h, 0, w, 0.5, 4);
    t+=mx;
    nxScale = w/2;
    nyScale = h;
    nzScale=400;
    n = noise(this.x/nxScale, this.y/nyScale, this.z/nzScale);
    float newN = map(n, 0, 1, -10, 10);

    //deplacement des oiseau
    this.x = this.x+this.vx;
    this.y = this.y+this.vy;
    
    //nouvelle position du point d'ancrage de l'oiseau
    this.newX=this.x+newN;
    this.newY=this.y+newN;
    this.newZ=this.z;

    //REFAIRE LES MURS
    //percussion mur droit
    if (this.newX>width)
    {
      this.newX=width;
      this.vx=-this.vx;
      newN = - newN;
    }
    //percussion mur gauche
    if (this.newX<0)
    {
      this.newX=0;
      this.vx=-this.vx;
      newN = - newN;
    }
    //percussion mur bas
    if (this.newY>height)
    {
      this.newY=height;
      this.vy=-this.vy;
      newN = - newN;
    } 
    //percussion mur haut
    if (this.newY<0)
    {
      this.newY=0;
      this.vy=-this.vy;
      newN = - newN;
    }

    //battement d'ailes
    if (this.plane==false)
    {
      if (aileInvert==false) {
        angle -= frequency;
        px = 0 - cos(radians(angle))*(envergure);
        py = 0 - sin(radians(angle))*(envergure);
        px2 = 0 + cos(radians(angle))*(envergure);
        py2 = 0 - sin(radians(angle))*(envergure);
      }
      if (aileInvert==true) {
        angle += frequency;
        px = 0 - cos(radians(angle))*(envergure);
        py = 0 - sin(radians(angle))*(envergure);
        px2 = 0 + cos(radians(angle))*(envergure);
        py2 = 0 - sin(radians(angle))*(envergure);
      }
      //limite ailes
      if (px<0 + cos((11*PI)/6)*(envergure/2) && py<0+sin((11*PI)/6)*(envergure/2)) {     
        aileInvert=true;
        nombreDeBattementdAile+=1;
        //println(nombreDeBattementdAile);
      }
      if (px<=0 + cos(PI/6)*(envergure/2) && py>=0+sin(PI/6)*(envergure/2)) {     
        aileInvert=false;
      }
    }
    
    /*
    //Module de plannage à faire
     else if(this.plane==true)
     {
     angle = 0;
     }
     */

    //Jauge de Vie 
    //---------------------------
    //NB : À coupler avec Twitter
    //---------------------------
    /*
    dureeDeVie+=0.2;
     if (dureeDeVie>=30)
     {
     dureeDeVie = 0;
     }
     */
     
    //couleur et profondeur de champs
    noStroke();
    //noFill();
    fill(this.hueBird, this.satBird, this.brightBird, this.alphaBirds);//, alphaBirds);
    if (this.z<=-height+(height/4))
    {
      this.alphaBirds *= 0.9; //100-(abs(this.z/100)*10); *+0.9
    }
    else
    {
      alphaBirds = 100;
    }

    //dessin d'oiseau
    pushMatrix();
    translate(this.newX, this.newY, this.newZ);
    rotateX(this.rx);
    rotateY(this.ry);
    rotateZ(this.rz);
    //corps
    beginShape(TRIANGLES);
    vertex(0, 0, 0);
    vertex(0, 0+hauteur, 0-(taille*0.3));
    vertex(0, 0, 0-taille);
    //aile droite
    //fill(0, 255, 0);
    endShape();
    beginShape(TRIANGLES);
    vertex(0, 0, 0-(taille*0.3));
    vertex(px, py, 0-(taille*0.6));
    vertex(0, 0, 0-(taille*0.65));
    endShape();
    //aile gauche
    beginShape(TRIANGLES);
    vertex(0, 0, 0-(taille*0.3));
    vertex(px2, py2, 0-(taille*0.6));
    vertex(0, 0, 0-(taille*0.65));
    endShape();

    //jauge
    /*
    beginShape();
     fill(hueBird, 20, 100, alphaBirds);//, alphaBirds);
     vertex(0, hauteur+5, 0-(taille*0.3));
     vertex(30, hauteur+5, 0-(taille*0.3));
     vertex(30, hauteur+8, 0-(taille*0.3));
     vertex(0, hauteur+8, 0-(taille*0.3));
     endShape();
     */

    //barre de vie
    /*   
     beginShape();
     fill(hueBird, 78, 100, alphaBirds);//, alphaBirds);
     vertex(0, hauteur+5, 0-(taille*0.3));
     vertex(30-dureeDeVie, hauteur+5, 0-(taille*0.3));
     vertex(30-dureeDeVie, hauteur+8, 0-(taille*0.3));
     vertex(0, hauteur+8, 0-(taille*0.3));
     endShape();
     */


    //Text
    /*
     fill(219, 42, 77);//, alphaBirds);
     textFont(anivers, 11);
     textFont(anivers, 16);
     text("MotoEventsFR"+" : ", 25, hauteur+25, 0-(taille*0.3));
     textFont(anivers, 14);
     text("Découvrez le RAZR i", 25, hauteur+40, 0-(taille*0.3));
     text("au Citadium #birdsbymotorola", 25, hauteur+54, 0-(taille*0.3));
     */


    //logo2 Capatiaon
    /*
    translate(0, 0, 0-(taille*0.3));
     tint(360, alphaBirds);
     image(this.logo2, 0, hauteur+12, 238, 63);
     */



    //repere battement d'ailes
    /*
     //ailes
     stroke(0, 50);
     noFill();
     ellipseMode(CENTER);
     ellipse(0, 0, envergure, envergure);
     rectMode(CENTER);
     fill(0, 50);
     //draw rectangle
     rect (px, py, 5, 5);
     fill(255, 0, 0, 50);
     //draw rectangle
     rect (px2, py2, 5, 5);
     
     fill(0, 255, 0, 30);
     rect(0 + cos(PI/3)*(envergure/2), 0+sin(PI/3)*(envergure/2), 10, 10);
     fill(0, 255, 255, 30);
     rect(0 + cos((5*PI)/3)*(envergure/2), 0+sin((5*PI)/3)*(envergure/2), 10, 10);
     fill(0, 0, 255, 30);
     rect(0 + cos((2*PI)/3)*(envergure/2), 0+sin((2*PI)/3)*(envergure/2), 10, 10);
     fill(255, 0, 255, 30);
     rect(0 + cos((4*PI)/3)*(envergure/2), 0+sin((4*PI)/3)*(envergure/2), 10, 10);
     */
    popMatrix();

    //println("-----------------------");
    //println("this.z = "+this.z);
    //println(randomColor);
    //println("this.vz = "+this.vz+"   this.z = "+this.z+"   this.newZ = "+this.newZ+"   this.z+this.vz = "+(this.z+this.vz)+"   limite = "+(-height+(height/4+10)));
    //etat de l'oiseau
    //println("boolean arrivee : "+arrivee);
    //println("boolean vol : "+vol);
    //println("boolean plane : "+depart);

  }
};

